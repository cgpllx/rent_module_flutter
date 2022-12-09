// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultResponse _$ResultResponseFromJson(Map<String, dynamic> json) =>
    ResultResponse(
      (json['code'] as int).toString(),
      json['msg'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => RentInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['currentPage'] as int?,
      json['pageSize'] as int?,
      json['count'] as int?,
      json['pageCount'] as int?,
      json['token'] as String?,
      json['extra'] as String?,
    );

Map<String, dynamic> _$ResultResponseToJson(ResultResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
      'currentPage': instance.currentPage,
      'pageSize': instance.pageSize,
      'count': instance.count,
      'pageCount': instance.pageCount,
      'token': instance.token,
      'extra': instance.extra,
    };
