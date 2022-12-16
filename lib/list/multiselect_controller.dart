import 'package:flutter/foundation.dart';

import 'iflexible.dart';

///  A Controller for multi select. Allows to get all selected items, de select all, select all.
class MultiSelectController<T> {

  /// Select all items
  late List<IFlexible<dynamic>> Function() selectAll;

  /// get all selected items
  late List<int> Function() getSelectedItems;

  MultiSelectController( );
}
