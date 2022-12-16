import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../list/iflexible.dart';
import '../list/multi_select_container.dart';
import '../model/rent_info.dart';
import '../utils/textutils.dart';

class Item_Footer implements IFlexible<String> {
  String rentInfo;

  Item_Footer(this.rentInfo, this.selected);

  @override
  Widget buildWidget(BuildContext context, int index,MultiSelectContainer multiSelectContainer) {
    return _RentItem1("rentInfo");
  }

  Widget _RentItem1(String info) {
    return ListTile(
      // selected: false,
      focusColor: Colors.red,
      hoverColor: Colors.amberAccent,
      selectedColor: Colors.deepPurple,
      selectedTileColor: Colors.blueAccent,
      title: Text(info ?? "data"),
      style: ListTileStyle.drawer,
      onTap: () {},
    );
  }

  buildListWidget(String tag) {
    List<Widget> list = <Widget>[];
    if (!TextUtils.isEmpty(tag)) {
      var tags = tag.split(",");
      if (tags.isNotEmpty) {
        for (var element in tags) {
          if (!TextUtils.isEmpty(element)) {
            list.add(buildTagWidget(element));
          }
        }
      }
    }
    return list;
  }

  buildTagWidget(String singleTag) {
    return Container(
      // padding: const EdgeInsets.all(2),

      decoration: BoxDecoration(
          color: Color(0x297F69E7), borderRadius: BorderRadius.circular(2)),
      margin: const EdgeInsets.fromLTRB(0, 0, 3, 0),
      padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
      child: Text(
        singleTag,
        strutStyle: StrutStyle(
          fontSize: 12,
          leading: 0,
          height: 1.0,
          // 1.1更居中
          forceStrutHeight: true, // 关键属性 强制改为文字高度
        ),
        style: const TextStyle(
          color: Color(0xFF7F69E7),
          fontSize: 12,
          // backgroundColor: Color(0x297F69E7),
          decoration: TextDecoration.none,
        ),
        textAlign: TextAlign.center,
      ),
      alignment: Alignment.center,
    );
  }

  @override
  late bool selected;

  @override
  bool get enabled => true;

  @override
  bool get hidden => false;

  @override
  Color get hoverColor => Colors.red;

  @override
  bool get selectable => true;

  @override
  String get value => rentInfo;

  @override
  bool onClick(BuildContext context, int index,MultiSelectContainer multiSelectContainer) {

   return false;
  }




}
