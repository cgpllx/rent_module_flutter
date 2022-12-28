import 'dart:async';

import 'package:flutter/foundation.dart';

import '../items/item_loadmore.dart';
import 'easy_response.dart';
import 'iflexible.dart';
import 'multi_select_container.dart';
typedef LoadMoreCallback = Future<void> Function();

///  使用他
class EasyListController {
  ///   List for the multi select container.
  final List<IFlexible<dynamic>> _items = [];

  final List<IFlexible<dynamic>> _headerItems = [];

  final List<IFlexible<dynamic>> _footerItems = [];

  final IFlexible<dynamic>? loadMoreItem = Item_LoadMore(); // 放在最后面，页尾，

  /// 最大选择数
  final int? maxSelectableCount;

  /// Call when reached to the maximum selectable count.
  /// 到达最大选择数 时候的 回调方法
  final void Function(List<int> selectedItems, dynamic selectedItem)?
      onMaximumSelected;

  /// Call when item is selected.
  final void Function(IFlexible<dynamic> selectedItem)? onChange;

  final LoadMoreCallback onLoad;
  /// 选择模式
  ModeSelect _mode = ModeSelect.modeMulti;

  ModeSelect get mode => _mode;

  set mode(ModeSelect value) {
    if (_mode == ModeSelect.modeSingle && value == ModeSelect.modeIdle) {
      clearSelected();
    }
    _mode = value;
  }

  final _selectedPositions = <int>{};

  addItems(Iterable<IFlexible<dynamic>> newItems) {
    _items.addAll(newItems);
  }

  addHeaderItems(Iterable<IFlexible<dynamic>> newItems) {
    _headerItems.addAll(newItems);
  }

  addFooterItems(Iterable<IFlexible<dynamic>> newItems) {
    _footerItems.addAll(newItems);
  }

  addFooterItem(IFlexible<dynamic> newItem) {
    _footerItems.add(newItem);
  }

  setItems(Iterable<IFlexible<dynamic>> newItems) {
    _items.clear();
    _items.addAll(newItems);
  }

  clearItem() {
    _items.clear();
  }

  clearHeaderItem() {
    _headerItems.clear();
  }

  clearFooterItem() {
    _footerItems.clear();
  }

  List<int> getSelectedPositions() {
    return _selectedPositions.toList();
  }

  int getSelectedLength() {
    return _selectedPositions.toList().length;
  }

  bool isSelected(int position) {
    return _selectedPositions.contains(position);
  }

  List<IFlexible<dynamic>> selectAll() {
    List<IFlexible<dynamic>> tempList = [];
    tempList.addAll(_headerItems);
    tempList.addAll(_items);
    tempList.addAll(_footerItems);
    _selectedPositions.addAll(tempList.asMap().keys);
    return tempList;
  }

  bool addSelection(int position) {
    return isSelectable(position) && _selectedPositions.add(position);
  }

  bool isSelectable(int position) {
    return getItem(position).selectable;
  }

  IFlexible getItem(int position) {
    int temp;
    if (position < _headerItems.length) {
      //满足条件 说明在_headerItems 里面
      temp = position;
      return _headerItems[temp];
    }
    if (position < _headerItems.length + _items.length) {
      //在_items 中
      temp = position - _headerItems.length;
      return _items[temp];
    }
    if (position < _headerItems.length + _items.length + _footerItems.length) {
      //_footerItems 中
      temp = position - _headerItems.length - _items.length;
      return _footerItems[temp];
    }
    temp = position - _headerItems.length - _items.length - _footerItems.length;
    return loadMoreItem!;
  }

  int getItemCount() {
    int loadMore = loadMoreItem != null ? 1 : 0;
    return _headerItems.length + _items.length + _footerItems.length + loadMore;
  }

  bool removeSelection(int position) {
    return _selectedPositions.remove(position);
  }

  void clearSelected() {
    _selectedPositions.clear();
  }

  void toggleSelection(int index, IFlexible<dynamic> item) {
    //可以被选择
    if (mode == ModeSelect.modeSingle || mode == ModeSelect.modeMulti) {
      if (mode == ModeSelect.modeSingle) {
        clearSelected();
      }
      bool contains = isSelected(index);
      if (contains) {
        //如果已经被选择了
        removeSelection(index);
      } else {
        if (item.selectable) {
          //item 支持被选择才添加
          //多选，当前item 已经是未选择状态
          int? maxSelectableCount = this.maxSelectableCount;
          //超过了设置的最大选择项，进行相应处理
          if (maxSelectableCount != null &&
              maxSelectableCount <= getSelectedLength()) {
            if (onMaximumSelected != null) {
              onMaximumSelected!(getSelectedPositions(), item.value);
            }
          } else {
            addSelection(index);
          }
        }
      }
    } //回调当前点击的 项
    onChange?.call(item);
  }

  EasyResponse? _easyResponse;

  set easyResponse(EasyResponse? value) {
    _easyResponse = value;
    _handleLoadMoreState(value);
  }

  getNextPage() {
    int page = (_easyResponse?.currentPage ?? 0) + 1;
    return page;
  }


  bool _isLoading = false;


  set isLoading(bool value) {
    _isLoading = value;
    if(value){
      _handleLoadMoreState(null);
    }else{
      //TODO
    }
  }

  bool get isLoading => _isLoading;

  _handleLoadMoreState(EasyResponse? easyResponse) {
    if (loadMoreItem is FooterHander) {
      FooterHander footerHander = loadMoreItem as FooterHander;
      if (easyResponse == null) {
        footerHander.showLoading();
        return;
      }
      if (!easyResponse!.isSuccess) {
        //加载失败
        footerHander.showLoadFail();
        return;
      }
      if (easyResponse!.allPageLoaded) {
        //这个需要根据具体业务判断
        //加载结束
        footerHander.showLoadFullCompleted();
        return;
      } else {
        //还有下一页
        footerHander.showLoadCompleted();
        return;
      }
    }
  }

  EasyListController(this.onLoad,
      {this.maxSelectableCount, this.onMaximumSelected, this.onChange}) {}
}
