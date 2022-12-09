

abstract class IFlexible<T> {
  final T value;

  /// Returns if the Item is enabled.
  ///
  /// @return (default) true for enabled item, false for disabled one.
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
  final bool selectable;

  ///if true - initially selected, Can be changed at any time
  bool selected;

  ///if true - perpetual in the selected status
  final bool perpetualSelected;

  IFlexible(
      {required this.value,
      required this.enabled,
      required this.hidden,
      required this.selectable,
      this.selected = false,
      this.perpetualSelected = false});
}
