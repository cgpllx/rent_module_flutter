import 'package:flutter/src/widgets/framework.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';
import 'package:rent_module_flutter/utils/textutils.dart';

import '../list/iflexible.dart';

part 'rent_info.g.dart';

@JsonSerializable()
class RentInfo  {
  // int type = 0; //二手盘还是租盘

  String? houseResourceId;

  String? photo;

  String? estateName;

  String? stageName;

  String? buildingName;

  String? title;

  String? floorLevel;

  String? floorName;

  String? roomName;

  int? guestRoom;

  double? roomArea;

  double? buildArea;

  String? partition;

  String? propertyType;

  String? location;

  String? label;

  double? price;

  bool? openType;

  int? guestRoomX;

  int? suite;

  double? roomAreaX;

  double? buildAreaX;

  double? priceX;

  int? time;

  int? status;

  String? advertUrl;

  String? advertLink;

  String? displayStatus;

  String? city;
  bool? overseas;

  String? advertId;
  String? vedio;
  String? shopPath;
  String? carportNumber;

  RentInfo(
      this.houseResourceId,
      this.photo,
      this.estateName,
      this.stageName,
      this.buildingName,
      this.title,
      this.floorLevel,
      this.floorName,
      this.roomName,
      this.guestRoom,
      this.roomArea,
      this.buildArea,
      this.partition,
      this.propertyType,
      this.location,
      this.label,
      this.price,
      this.openType,
      this.guestRoomX,
      this.suite,
      this.roomAreaX,
      this.buildAreaX,
      this.priceX,
      this.time,
      this.status,
      this.advertUrl,
      this.advertLink,
      this.displayStatus,
      this.city,
      this.overseas,
      this.advertId,
      this.vedio,
      this.shopPath,
      this.carportNumber)  ; // 固定格式，不同的类使用不同的mixin即可
  // 这里声明一个工厂构造方法
  factory RentInfo.fromJson(Map<String, dynamic> json) =>
      _$RentInfoFromJson(json);

  Map<String, dynamic> toJson() => _$RentInfoToJson(this);

  String interval() {
    String jiange = buildHouseTypeString2(openType, guestRoom, suite, 0);

    return TextUtils.joinFilterEmpty(" ", [floorLevel, roomName, jiange]);
  }

  String buildHouseTypeString2(
      bool? openType, int? guestRoom, int? suite, int livingRoom) {
    StringBuffer stringBuilder = StringBuffer();
    //"%1$d房(%2$d套)%3$d廳";
    if (openType != null && openType) {
      stringBuilder.write("開放式");
    } else {
      if (guestRoom != null && guestRoom > 0) {
        stringBuilder.write(guestRoom);
        stringBuilder.write("房");
      }
      if (suite != null && suite > 0) {
        stringBuilder.write("(");
        stringBuilder.write(suite);
        stringBuilder.write("套)");
      }
    }
    return stringBuilder.toString();
  }

  String getRoomArea() {
    if (roomArea != null && roomArea! > 0) {
      return "實${doubleAreaFormatToString(roomArea!)}呎 ";
    }
    return "";
  }

  String getBuildArea() {
    if (buildArea != null && buildArea! > 0) {
      return "建${doubleAreaFormatToString(buildArea!)}呎";
    }
    return "";
  }

  String doubleAreaFormatToString(double area) {
    var formatter = NumberFormat('#,###');
    String p = formatter.format(area); // format 返回的是字符串
    return p;
  }

  String getRentPrice() {
    if (price == null) {
      return "";
    }
    return "\$ ${doubleRentPriceFormatToString2(price!)}";
  }
  String getRentPriceUnit() {
    if (price == null) {
      return "";
    }
    return doubleRentOfUnit(price!);
  }

  String doubleRentPriceFormatToString2(double price) {
    //超过一万万 显示亿
    double newprice;
    if (price >= 100000) {
      newprice = price / 10000;
    } else {
      newprice = price;
    }
    var decimalFormat = NumberFormat("#,###.##"); //
    String p = decimalFormat.format(newprice); // format 返回的是字符串
    return p;
  }

  String doubleRentOfUnit(double price) {
    if (price >= 100000) {
      return " 萬";
    } else {
      return " ";
    }
  }



}
