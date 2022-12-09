import 'package:json_annotation/json_annotation.dart';
import 'package:rent_module_flutter/model/rent_info.dart';

part 'response.g.dart';

@JsonSerializable()
class ResultResponse {
  String? code;
  String? msg;
  List<RentInfo>? data;
  int? currentPage;
  int? pageSize;
  int? count;
  int? pageCount;
  String? token;
  String? extra;


  ResultResponse(
      this.code,
      this.msg,
      this.data,
      this.currentPage,
      this.pageSize,
      this.count,
      this.pageCount,
      this.token,
      this.extra); // 固定格式，不同的类使用不同的mixin即可
  // 这里声明一个工厂构造方法
  // 固定格式，不同的类使用不同的mixin即可
  // 这里声明一个工厂构造方法
  factory ResultResponse.fromJson(Map<String, dynamic> json) => _$ResultResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResultResponseToJson(this);
}