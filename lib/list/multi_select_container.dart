import 'package:flutter/material.dart';

import 'iflexible.dart';
import 'multiselect_controller.dart';
import 'multiselect_list_settings.dart';

///Container for multi MultiSelectCard.

class MultiSelectContainer<T> extends StatefulWidget {
  MultiSelectContainer({
    Key? key,
    required this.items,
    required this.onChange,
    this.maxSelectableCount,
    this.onMaximumSelected,
    this.listViewSettings = const ListViewSettings(),
    this.controller,
    this.singleSelectedItem = false,
    this.mMode = ModeSelect.modeMulti,
  }) : super(key: key);

  ///   List for the multi select container.
  final List<IFlexible<T>> items;

  final List<IFlexible<dynamic>> headerItems = [];

  final List<IFlexible<dynamic>> footerItems = [];

  /// Maximum selectable count.
  /// 最大选择数
  final int? maxSelectableCount;

  /// let select only one
  /// 是否单选
  final bool singleSelectedItem;
  final ModeSelect mMode;

  /// ListView 时候的设置
  final ListViewSettings listViewSettings;

  /// A Controller for multi select. Allows to get all selected items, de select all, select all.
  final MultiSelectController<T>? controller;

  /// Call when reached to the maximum selectable count.
  /// 到达最大选择数 时候的 回调方法
  final void Function(List<
      int> selectedItems, T selectedItem)? onMaximumSelected;

  /// Call when item is selected.
  final void Function( IFlexible<T> selectedItem) onChange;

  @override
  State<MultiSelectContainer<T>> createState() =>
      _SimpleMultiSelectContainerState<T>();
}

class _SimpleMultiSelectContainerState<T>
    extends State<MultiSelectContainer<T>> {


  @override
  void initState() {
    _headerItems = widget.headerItems;
    _items = widget.items;
    _footerItems = widget.footerItems;

    if (widget.controller != null) {
      widget.controller!.getSelectedItems = _getSelectedPositions;
      widget.controller!.selectAll = _selectAll;
    }
    super.initState();
  }

  late final List<IFlexible<T>> _items;
  late final List<IFlexible<dynamic>> _headerItems;
  late final List<IFlexible<dynamic>> _footerItems;

  // final _selectedItems = <IFlexible<T>>[];
  final _selectedPositions = <int>{};

  List<IFlexible<dynamic>> _selectAll() {
    List<IFlexible<dynamic>> tempList = [];
    tempList.addAll(_headerItems);
    tempList.addAll(_items);
    tempList.addAll(_footerItems);
    _selectedPositions.addAll(tempList
        .asMap()
        .keys);
    return tempList;
  }

  List<int> _getSelectedPositions() {
    return _selectedPositions.toList();
  }

  bool isSelected(int position) {
    return _selectedPositions.contains(position);
  }

  bool addSelection(int position) {
    return isSelectable(position) && _selectedPositions.add(position);
  }


  bool removeSelection(int position) {
    return _selectedPositions.remove(position);
  }

  void setItemChecked(int position, bool checked) {
    if (widget.mMode == ModeSelect.modeSingle) {
      _selectedPositions.clear();
    }
    bool selected = isSelected(position);
    if (checked && !selected) {
      addSelection(position);
    } else if (selected) {
      removeSelection(position);
    }
    setState(() {

    });
  }

  bool isSelectable(int position) {
    return getItem(position).selectable;
  }

  IFlexible getItem(int position) {
    if (position < widget.headerItems.length) {
      return widget.headerItems[position];
    }
    if (position > getItemCount() - widget.footerItems.length) {
      return widget.footerItems[position];
    }
    return _items[position];
  }

  @override
  void didUpdateWidget(MultiSelectContainer<T> oldWidget) {
    if (widget.controller != null) {
      widget.controller!.getSelectedItems =
          oldWidget.controller!.getSelectedItems;
      widget.controller!.selectAll = oldWidget.controller!.selectAll;
    }
    super.didUpdateWidget(oldWidget);
  }

  //onlyForDeselect, call from onChange
  void _clearSelected() {
    _selectedPositions.clear();
    setState(() {});
  }

  void _toggleSelection(int index, IFlexible<T> item) {
    //可以被选择
    if (widget.mMode == ModeSelect.modeSingle ||
        widget.mMode == ModeSelect.modeMulti) {
      if (widget.mMode == ModeSelect.modeSingle) {
        _clearSelected();
      }
      bool contains = _selectedPositions.contains(index);
      if (contains) {
        //如果已经被选择了
        _selectedPositions.remove(index);
      } else {
        if (item.selectable) {
          //item 支持被选择才添加
          //多选，当前item 已经是未选择状态
          int? maxSelectableCount = widget.maxSelectableCount;
          //超过了设置的最大选择项，进行相应处理
          if (maxSelectableCount != null &&
              maxSelectableCount <= _selectedPositions.length) {
            if (widget.onMaximumSelected != null) {
              widget.onMaximumSelected!(
                  _selectedPositions.toList(growable: false), item.value);
            }
          } else {
            _selectedPositions.add(index);
          }
        }
      }
    }
    //回调全部选中项
    widget.onChange(item);
    setState(() {});
  }

  /// Counts the selected items.
  ///
  /// @return Selected items count
  int getSelectedItemCount() {
    return _selectedPositions.length;
  }

  /// Retrieves the list of selected items.
  /// <p>The list is a copy and it's sorted.</p>
  ///
  /// @return A copied List of selected items ids from the Set
  List<int> getSelectedPositions() {
    return _selectedPositions.toList(growable: false);
  }

  int getItemCount() {
    return widget.headerItems.length +
        _items.length +
        widget.footerItems.length;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: widget.listViewSettings.shrinkWrap,
      scrollDirection: widget.listViewSettings.scrollDirection,
      reverse: widget.listViewSettings.reverse,
      addAutomaticKeepAlives: widget.listViewSettings.addAutomaticKeepAlives,
      addRepaintBoundaries: widget.listViewSettings.addRepaintBoundaries,
      dragStartBehavior: widget.listViewSettings.dragStartBehavior,
      keyboardDismissBehavior: widget.listViewSettings.keyboardDismissBehavior,
      clipBehavior: widget.listViewSettings.clipBehavior,
      controller: widget.listViewSettings.controller,
      primary: widget.listViewSettings.primary,
      physics: widget.listViewSettings.physics,
      padding: widget.listViewSettings.padding,
      cacheExtent: widget.listViewSettings.cacheExtent,
      restorationId: widget.listViewSettings.restorationId,
      itemCount: getItemCount(),
      separatorBuilder: widget.listViewSettings.separatorBuilder ??
              (BuildContext context, int index) {
            return const SizedBox(
              height: 5,
            );
          },
      itemBuilder: (BuildContext context, int index) {
        // wrap in the center, otherwise not affect each single item's margin and padding properties.
        // like different paddings for a single item.
        if (index < widget.headerItems.length) {
          return Center(
            child: getHeaderItem(context, index, widget.headerItems[index]),
          );
        }
        if (index > getItemCount() - widget.footerItems.length) {
          return Center(
            child: getHeaderItem(context, index, widget.footerItems[index]),
          );
        }
        return Center(
          child: getItemWidget(context, index, _items[index]),
        );
      },
    );
  }

  Widget getItemWidget(BuildContext context, int index, IFlexible<T> item) {
    return Material(
        type: MaterialType.transparency,
        child: InkWell(
            hoverColor: item.hoverColor,
            onTap: !item.enabled
                ? null
                : () {
              if (!item.onClick(context, index, widget)) {
                _toggleSelection(index, item);
              }
            },
            child: item.buildWidget(context, index, widget)));
  }

  Widget getHeaderItem(BuildContext context, int index,
      IFlexible<dynamic> item) {
    return Material(
        type: MaterialType.transparency,
        child: InkWell(
            hoverColor: item.hoverColor,
            onTap: !item.enabled
                ? null
                : () {
              if (!item.onClick(context, index, widget)) {}
            },
            child: item.buildWidget(context, index, widget)));
  }
}

enum ModeSelect { modeIdle, modeSingle, modeMulti }
