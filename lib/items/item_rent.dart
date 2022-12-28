import 'package:flutter/material.dart';
import '../list/easylist_controller.dart';
import '../list/iflexible.dart';
import '../model/rent_info.dart';
import '../utils/textutils.dart';

class Item_Rent   implements IFlexible<RentInfo>   {
  RentInfo rentInfo;
  Item_Rent(this.rentInfo );
  @override
  Widget buildWidget(BuildContext context, int index,EasyListController easyListController) {

    print("context.widget=${context.widget}");
    return _RentItem(rentInfo, easyListController.isSelected(index));
  }

  Widget _RentItem(RentInfo info,bool selected) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        height: 155,

          color: !selected?Colors.transparent:Colors.grey[300],
        alignment: Alignment.centerLeft,
        width: double.maxFinite,
        child: Row(children: [
          Container(
            width: 133,
            height: 108,
            margin: const EdgeInsets.fromLTRB(14, 16, 0, 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color.fromARGB(0xff, 0x88, 0x59, 0x98),
              borderRadius: BorderRadius.circular(4),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                info.photo?.replaceAll("{size}", "400x300") ??
                    "https://image.aps101.com.hk/toolkit-image/testapshouse101other/202210/8/400x300/578f42c4-2db3-4cb7-97b4-7de08eee54ac.png",
                fit: BoxFit.cover,
                height: 108,
                width: 133,
              ),
            ),
          ),
          _DescWidget(
              info.estateName!,
              info.interval(),
              info.getRoomArea(),
              info.getBuildArea(),
              info.getRentPrice(),
              info.getRentPriceUnit(),
              " ${info.propertyType ?? ""}",
              info.label!)
        ]));
  }

  _DescWidget(String title, String interval, String roomArea, String buildArea,
      String price, String priceUnit, String houseType, String tag) {
    return Expanded(
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              SizedBox(
                  width: double.maxFinite,
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  )),
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                  width: double.maxFinite,
                  child: Text(
                    interval,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.normal),
                    overflow: TextOverflow.ellipsis,
                  )),
              Container(
                  width: double.maxFinite,
                  margin: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        roomArea,
                        style: const TextStyle(
                            color: Color(0xffef8354),
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        buildArea,
                        style: const TextStyle(
                            color: Color(0xff909399),
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  )),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                width: double.maxFinite,
                child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: price,
                        style: const TextStyle(
                            color: Color(0xffE04153),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: priceUnit,
                        style: const TextStyle(
                            color: Color(0xffE04153),
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                      TextSpan(
                        text: houseType,
                        style: const TextStyle(
                            color: Color(0xff303133),
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ])),
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                  width: double.maxFinite,
                  child: Row(
                    children: buildListWidget(tag),
                  )),
            ],
          ),
        ));
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
      alignment: Alignment.center,
      child: Text(
        singleTag,
        strutStyle:   const StrutStyle(
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
    );
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
  RentInfo get value => rentInfo;

  @override
  bool onClick(BuildContext context, int index,EasyListController easyListController) {

    return false;
  }



}
