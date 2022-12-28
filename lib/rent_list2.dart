import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rent_module_flutter/items/item_loadmore.dart';
import 'package:rent_module_flutter/list/multiselect_list_settings.dart';

import 'items/item_rent.dart';
import 'list/easylist_controller.dart';
import 'list/multi_select_container.dart';
import 'model/response.dart';

/// 二手盘列表
class RentListWidget2 extends StatefulWidget {
  const RentListWidget2({Key? key}) : super(key: key);

  @override
  State<RentListWidget2> createState() => _RentListWidgetState();
}

class _RentListWidgetState extends State<RentListWidget2> {
  Future<void> _onLoadData({bool refresh = false}) async {
    if (controller.isLoading) {
      return;
    }
    ResultResponse? response1;
    try {
      int page = 1;
      if (!refresh) {
        //不是刷新
        page = controller.getNextPage();
        print("page getNextPage =$page");
      }
      controller.isLoading = true;
      //发起请求开始
      var response = await Dio().get(
          'https://app.house101.com.hk/property-app/api/v7/houseResource/listData?type=2&page=$page');
      response1 = ResultResponse.fromJson(response.data);
      if (response1.data != null) {
        if (refresh) {
          controller.clearItem();
        }
        controller.addItems(response1.data!.map((e) => Item_Rent(e)));
        print("page=$page");
        print("page count =${controller.getItemCount()}");
        setState(() {});
      }
    } catch (e) {
      print("page e =$e");
      response1 = ResultResponse("", "", null, 0, 0, 0, 0, "", "");
    } finally {
      controller.easyResponse = response1;
      controller.isLoading = false;
    }
  }

  Future<void> _onRefresh() async {
    _onLoadData(refresh: true);
  }

  late EasyListController controller = EasyListController(_onLoadData);

  @override
  void initState() {
    _onRefresh();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        if (controller.isLoading) {
          return;
        }
        _onLoadData();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: MultiSelectContainer(
          listViewSettings: ListViewSettings(
              controller: _scrollController,
              separatorBuilder: (context, index) {
                return Container(
                  height: 1,
                  color: const Color(0xfff6f6f6),
                );
              }),
          easyListController: controller),
    );
  }

  final ScrollController _scrollController = ScrollController(); //listview 的控制器

}
