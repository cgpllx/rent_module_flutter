import 'dart:core';

class TextUtils {
  /// 会过滤掉内容为空 或者空字符串的
  static String join(String delimiter, Iterable tokens) {
    final Iterator it = tokens.iterator;
    if (!it.moveNext()) {
      return "";
    }
    final StringBuffer sb = StringBuffer();
    sb.write(it.current);
    while (it.moveNext()) {
      sb.write(delimiter);
      sb.write(it.current);
    }
    return sb.toString();
  }

  static String joinFilterEmpty(String delimiter, Iterable tokens) {
    final Iterator it = tokens.iterator;
    bool firstTime = true;
    final StringBuffer sb = StringBuffer();
    while (it.moveNext()) {
      if (isEmpty(it.current)) {
        continue;
      }
      if (firstTime) {
        firstTime = false;
      } else {
        sb.write(delimiter);
      }
      sb.write(it.current);
    }
    return sb.toString();
  }

  static bool isEmpty(String? text) {
    return text == null || text.isEmpty;
  }
}
