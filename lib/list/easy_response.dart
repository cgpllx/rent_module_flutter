class EasyResponse<T> {
  var currentPage = 0; //当前页码
  var pageSize = 0; //每页数量
  var count = 0; //总是
  var pageCount = 0; //页数

  dynamic nextPageToken; //下一页的token
  dynamic prevPageToken; //上一页的token

  bool get isSuccess {
    //计算属性  是否成功
    return "200" == code;
  }

  bool get allPageLoaded {
    return currentPage >= count;
  }

  String code = "-1"; //业务状态码
  T? data; //业务数据
  String? msg; //错误信息

}
