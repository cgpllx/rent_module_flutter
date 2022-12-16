

import 'package:flutter/cupertino.dart';
import 'package:rent_module_flutter/list/multi_select_container.dart';

abstract class IFlexible<T> {
  final T value;

  /// Returns if the Item is enabled.
  ///
  /// @return (default) true for enabled item, false for disabled one.
  /// 是否可以点击
  final bool enabled;

  /// (Internal usage).
  /// When and item has been deleted (with Undo) or has been filtered out by the
  /// adapter, then, it has hidden status.
  ///
  /// @return true for hidden item, (default) false for the shown one.
  final bool hidden;



  /// Returns if the item can be selected.
  ///
  /// @return (default) true for a Selectable item, false otherwise
  ///是否可以被选择
  final bool selectable;

  ///if true - initially selected, Can be changed at any time
  final Color hoverColor;

  Widget buildWidget(BuildContext context, int index,  MultiSelectContainer multiSelectContainer);

  IFlexible(
      {required this.value,
      required this.enabled,
      required this.hidden,
      required this.selectable,
      required this.hoverColor,
  });

  /// 返回值 是否自己全部处理  true 拦截 false 不拦截
   bool onClick(BuildContext context, int index,MultiSelectContainer multiSelectContainer) {
     // multiSelectContainer.
    return false;
  }
}
