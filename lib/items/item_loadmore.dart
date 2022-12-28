import 'package:flutter/material.dart';
import '../list/easylist_controller.dart';
import '../list/iflexible.dart';

class Item_LoadMore implements IFlexible<String>, FooterHander {
  Item_LoadMore();

  ValueNotifier<int> indexNotifier =
      ValueNotifier(FooterHander.loadStatusCompleted);

  @override
  Widget buildWidget(
      BuildContext context1, int index, EasyListController easyListController) {
    return ValueListenableBuilder(
      valueListenable: indexNotifier,
      builder: (BuildContext context, int value, Widget? child) {
        return _content(value, easyListController.onLoad);
      },
    );
  }

  Widget _content(int _loadStatus, Function() loadMore) {
    switch (_loadStatus) {
      case FooterHander.loadStatusFullCompleted:
        return _loadNormalWidget("我是有底线的", null);
      case FooterHander.loadStatusFail:
        return _loadNormalWidget("加载失败，点击重试", loadMore);
      case FooterHander.loadStatusLoading:
        return _loading();
      case FooterHander.loadStatusCompleted:
      default:
        return _loadNormalWidget("点击加载更多", loadMore);
    }
  }

  Widget _loading() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: const SizedBox(
          width: 24.0,
          height: 24.0,
          child: CircularProgressIndicator(strokeWidth: 2.0)),
    );
  }

  _loadNormalWidget(String message, var click) {
    return InkWell(
      onTap: click,
      child: Container(
        alignment: Alignment.center,
        child: SizedBox(
            height: 54.0,
            child: Center(
              child: Text(
                message,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal),
              ),
            )),
      ),
    );
  }

  /// 显示普通布局
  @override
  void showLoadCompleted() {
    int status = FooterHander.loadStatusCompleted;
    indexNotifier.value = status;
  }

  /// 显示已经加载完成，没有更多数据的布局
  @override
  void showLoadFullCompleted() {
    int status = FooterHander.loadStatusFullCompleted;
    indexNotifier.value = status;
  }

  /// 显示正在加载中的布局
  @override
  void showLoading() {
    int status = FooterHander.loadStatusLoading;
    indexNotifier.value = status;
  }

  /// 显示加载失败的布局
  @override
  void showLoadFail() {
    int status = FooterHander.loadStatusFail;
    indexNotifier.value = status;
  }

  @override
  bool get enabled => true;

  @override
  bool get hidden => false;

  @override
  Color get hoverColor => Colors.grey;

  @override
  bool get selectable => true;

  @override
  String get value => "endTip";

  @override
  bool onClick(
      BuildContext context, int index, EasyListController easyListController) {
    return false;
  }

  @override
  bool onCanLoadMore() {
    return true;
  }
}

abstract class FooterHander {
  static const int loadStatusCompleted = 0;
  static const int loadStatusFail = 1;
  static const int loadStatusFullCompleted = 2;
  static const int loadStatusLoading = 3;

  /// 显示普通布局
  void showLoadCompleted();

  /// 显示已经加载完成，没有更多数据的布局
  void showLoadFullCompleted();

  /// 显示正在加载中的布局
  void showLoading();

  /// 显示加载失败的布局
  void showLoadFail();

  bool onCanLoadMore();
}
