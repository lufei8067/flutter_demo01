import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_demo01/common/Global.dart';
//import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter_app/Global.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'MsgPacket.dart';
export 'package:http/http.dart';

typedef HttpCallback = void Function(int, http.Response);

class NetClient {
  static void Get(String strUrl, int tag, HttpCallback callback,
      {VoidCallback errorCallback, bool repeat = false}) async {
    try {
      var response = await http.get(strUrl);
      if (callback != null) {
        callback(tag, response);
      }
    } catch (e) {
      if (errorCallback != null) errorCallback();
      showTip(e);

      if (repeat) //失败后, 5秒之后重复请求
      {
        Timer(Duration(seconds: 5), () {
          Get(strUrl, tag, callback,
              errorCallback: errorCallback, repeat: repeat);
        });
      }
    }
  }

  static void GetWithHeader(String strUrl, int tag, Map<String, String> headers,
      HttpCallback callback,
      {VoidCallback errorCallback, bool repeat = false}) async {
    try {
      var response = await http.get(strUrl, headers: headers);
      if (callback != null) {
        callback(tag, response);
      }
    } catch (e) {
      if (errorCallback != null) errorCallback();
      showTip(e);

      if (repeat) //失败后, 5秒之后重复请求
      {
        Timer(Duration(seconds: 5), () {
          GetWithHeader(strUrl, tag, headers, callback,
              errorCallback: errorCallback, repeat: repeat);
        });
      }
    }
  }

  static void Post(String strUrl, int tag, Object body, HttpCallback callback,
      {VoidCallback errorCallback, bool repeat = false}) async {
    try {
      var response = await http.post(strUrl, body: body);
      if (callback != null) {
        callback(tag, response);
      }
    } catch (e) {
      if (errorCallback != null) errorCallback();
      showTip(e);

      if (repeat) //失败后, 5秒之后重复请求
      {
        Timer(Duration(seconds: 5), () {
          Post(strUrl, tag, body, callback,
              errorCallback: errorCallback, repeat: repeat);
        });
      }
    }
  }

  static void PostMsg(
      String strUrl, int tag, MsgPacket msg, HttpCallback callback,
      {VoidCallback errorCallback, bool repeat = false}) async {
    try {
      var response = await http.post(strUrl, body: msg.getUint8Content());
      if (callback != null) {
        callback(tag, response);
      }
    } catch (e) {
      if (errorCallback != null) errorCallback();
      showTip(e);

      if (repeat) //失败后, 5秒之后重复请求
      {
        Timer(Duration(seconds: 5), () {
          PostMsg(strUrl, tag, msg, callback,
              errorCallback: errorCallback, repeat: repeat);
        });
      }
    }
  }

  static void PostWithHeader(String strUrl, int tag, Object body,
      Map<String, String> head, HttpCallback callback,
      {VoidCallback errorCallback, bool repeat = false}) async {
    try {
      var response = await http.post(strUrl, body: body, headers: head);
      if (callback != null) {
        callback(tag, response);
      }
    } catch (e) {
      showTip(e);
      if (errorCallback != null) errorCallback();

      if (repeat) //失败后, 5秒之后重复请求
      {
        Timer(Duration(seconds: 5), () {
          PostWithHeader(strUrl, tag, body, head, callback,
              errorCallback: errorCallback, repeat: repeat);
        });
      }
    }
  }

  static void showTip(dynamic e) {
    if (e is SocketException) {
      //Global.ShowError("网络连接不可用", timeLen: Toast.LENGTH_LONG);
    }
  }
}
