import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rent_module_flutter/list/multiselect_list_settings.dart';
import 'package:rent_module_flutter/utils/textutils.dart';

import 'items/item_footer.dart';
import 'items/item_rent.dart';
import 'list/iflexible.dart';
import 'list/multi_select_container.dart';
import 'model/rent_info.dart';
import 'model/response.dart';

/**
 * 二手盘列表
 */
class RentListWidget2 extends StatefulWidget {
  RentListWidget2({Key? key}) : super(key: key);
  List<IFlexible> list = <IFlexible>[];

  @override
  State<RentListWidget2> createState() => _RentListWidgetState();
}

class _RentListWidgetState extends State<RentListWidget2> {
  @override
  void initState() {
    _onRefresh();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        print('滑动到了最底部');
        _onLoadMore();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: MultiSelectContainer(
        items: widget.list,
        listViewSettings: ListViewSettings(
            controller: _scrollController,
            separatorBuilder: (context, index) {
              return Container(
                height: 1,
                color: const Color(0xfff6f6f6),
              );
            }),
         onChange: (IFlexible<dynamic> selectedItem) {  },
      ),
    );

    //   ListView.separated(
    //   separatorBuilder: (context, index) {
    //     return Container(
    //       height: 1,
    //       color: const Color(0xfff6f6f6),
    //     );
    //   },
    //   itemBuilder: (context, index) {
    //     return InkWell(
    //
    //       splashColor: Colors.transparent,
    //       // highlightColor: Colors.teal, //设置高亮颜色
    //       // focusColor: Colors.red,
    //       onTap: (){},
    //       child: _RentItem(widget.list[index]),
    //     ); //
    //   },
    //   controller: _scrollController,
    //   itemCount: widget.list.length,
    // );
  }

  ScrollController _scrollController = ScrollController(); //listview 的控制器
  _Item() {
    return const Text(
      "item",
      style: TextStyle(color: Colors.orange, fontSize: 32, height: 1.2),
    );
  }

  int page = 1;

  Future<void> _onLoadMore() async {
    try {
      var response = await Dio().get(
          'https://app.house101.com.hk/property-app/api/v7/houseResource/listData?type=2&page=$page');
      ResultResponse response1 = ResultResponse.fromJson(response.data);
      if (response1.data != null) {
        // widget.list.addAll(response1.data!.map((e) => Item_Rent(e, false)));
        widget.list.add(Item_Footer("dddd", false));

        widget.list.addAll(
            response1.data!.map((e) => Item_Rent(e, false)));
        widget.list.add(Item_Footer("", false));
        print(widget.list.length);
        print("page=$page");
        setState(() {
          page++;
        });
      }
    } catch (e) {}
  }

  Future<void> _onRefresh() async {
    page = 1;
    _onLoadMore();
  }
}
