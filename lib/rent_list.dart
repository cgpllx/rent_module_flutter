import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rent_module_flutter/utils/textutils.dart';

import 'model/rent_info.dart';
import 'model/response.dart';

/**
 * 二手盘列表
 */
class RentListWidget extends StatefulWidget {
  RentListWidget({Key? key}) : super(key: key);
  List<RentInfo> list = <RentInfo>[];

  @override
  State<RentListWidget> createState() => _RentListWidgetState();
}

class _RentListWidgetState extends State<RentListWidget> {
  @override
  void initState() {
    // getHttp();
    _onRefresh();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        print('滑动到了最底部');
        _onRefresh();
      }
    });
    super.initState();
  }

  void getHttp() async {
    try {
      var response = await Dio().get(
          'http://house101.cn/property-app/api/v7/houseResource/listData?type=2&page=1');
      // Map<String, dynamic> jsonMap = jsonDecode(response.);
      print("cgp" + response.data.toString());
      print("cgp" + response.data.runtimeType.toString());
      // Map<String, dynamic> respons2e =null;

      ResultResponse response1 = ResultResponse.fromJson(response.data);
      // setState(() {
      //   widget.list.addAll(iterable);
      //
      // });

      if (response1.data != null) {
        widget.list.addAll(response1.data!);
        print(widget.list.length);
        setState(() {});
      }
      //print("cgp  data " + response.extra["data"]);
      print("cgp" + response1.toString());
      print("cgp" + response1.pageSize.toString());
    } catch (e) {
      print("cgp" + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Container(
          height: 1,
          color: const Color(0xfff6f6f6),
        );
      },
      itemBuilder: (context, index) {
        return InkWell(
          splashColor: Colors.red,
          focusColor: Colors.red,
          onTap: (){},
          child: _RentItem1(widget.list[index]),
        ); //
      },
      controller: _scrollController,
      itemCount: widget.list.length,
    );
  }

  ScrollController _scrollController = ScrollController(); //listview 的控制器
  _Item() {
    return const Text(
      "item",
      style: TextStyle(color: Colors.orange, fontSize: 32, height: 1.2),
    );
  }

  Widget _RentItem1(RentInfo info) {
    return ListTile(
      selected: false,
      focusColor: Colors.red,
      hoverColor: Colors.amberAccent,
      selectedColor: Colors.deepPurple,
      selectedTileColor: Colors.blueAccent,
      title: Text(info.estateName ?? "data"),
      style: ListTileStyle.drawer,
      onTap: () {},
    );
  }

  Widget _RentItem(RentInfo info) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 1, 0, 0),
        height: 155,
        // color: Colors.red,
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
              borderRadius: BorderRadius.circular(16),
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

  int page = 1;

  Future<void> _onRefresh() async {
    try {
      print("cgp page= $page");
      var response = await Dio().get(
          'https://app.house101.com.hk/property-app/api/v7/houseResource/listData?type=2&page=$page');
      // Map<String, dynamic> jsonMap = jsonDecode(response.);
      print("cgp" + response.data.toString());
      print("cgp" + response.data.runtimeType.toString());
      // Map<String, dynamic> respons2e =null;

      ResultResponse response1 = ResultResponse.fromJson(response.data);
      // setState(() {
      //   widget.list.addAll(iterable);
      //
      // });

      if (response1.data != null) {
        widget.list.addAll(response1.data!);
        print(widget.list.length);
        setState(() {
          page++;
        });
      }
      //print("cgp  data " + response.extra["data"]);
      print("cgp" + response1.toString());
      print("cgp" + response1.pageSize.toString());
    } catch (e) {
      print("cgp" + e.toString());
    }
  }
}

// Text(
// price,
// textAlign: TextAlign.left,
// style: const TextStyle(
// color: Color(0xffE04153),
// fontSize: 20, fontWeight: FontWeight.bold),
// overflow: TextOverflow.ellipsis,
// ))
