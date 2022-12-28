import 'package:flutter/material.dart';

import 'easylist_controller.dart';
import 'iflexible.dart';
import 'multiselect_list_settings.dart';

class MultiSelectContainer<T> extends StatefulWidget {
  const MultiSelectContainer({
    Key? key,
    this.listViewSettings = const ListViewSettings(),
    required this.easyListController,
  }) : super(key: key);

  /// ListView 时候的设置
  final ListViewSettings listViewSettings;

  /// A Controller for multi select. Allows to get all selected items, de select all, select all.
  final EasyListController easyListController;

  @override
  State<MultiSelectContainer<T>> createState() =>
      _SimpleMultiSelectContainerState<T>();
}

class _SimpleMultiSelectContainerState<T>
    extends State<MultiSelectContainer<T>> {
  @override
  void initState() {
    _easyListController = widget.easyListController;
    super.initState();
  }

  late final EasyListController _easyListController;

  @override
  void didUpdateWidget(MultiSelectContainer<T> oldWidget) {
    // oldWidget.
    super.didUpdateWidget(oldWidget);
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
      itemCount: _easyListController.getItemCount(),
      separatorBuilder: widget.listViewSettings.separatorBuilder ??
          (BuildContext context, int index) {
            return const SizedBox(
              height: 5,
            );
          },
      itemBuilder: (BuildContext context, int index) {
        // wrap in the center, otherwise not affect each single item's margin and padding properties.
        // like different paddings for a single item.
        return Center(
          child:
              getItemWidget(context, index, _easyListController.getItem(index)),
        );
      },
    );
  }

  Widget getItemWidget(
      BuildContext context, int index, IFlexible<dynamic> item) {
    return Material(
        type: MaterialType.transparency,
        child: InkWell(
            hoverColor: item.hoverColor,
            splashColor: item.hoverColor,
            onTap: !item.enabled
                ? null
                : () {
                    if (!item.onClick(context, index, _easyListController)) {
                      setState(() {
                        _easyListController.toggleSelection(index, item);
                      });
                    }
                  },
            child: item.buildWidget(context, index, _easyListController)));
  }
}

enum ModeSelect { modeIdle, modeSingle, modeMulti }
