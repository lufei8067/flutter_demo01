import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

//import 'package:fluttertoast/fluttertoast.dart';

import 'SkinMgr.dart';

export 'dart:io';
export 'dart:math';
export 'dart:convert';

typedef CompareSetFunc = int Function(dynamic a, dynamic b);

class Global {
  //物理
  static Size winSize; //逻辑分辨率
  static Size physicalSize; //屏幕物理分辨率
  static double devicePixelRatio; //physicalSize/winSize
  static double paddingTop; //刘海高度
  static double paddingBottom; //刘海高度
  static double bottomNavHeight = 48; //底部按钮高度

  static bool Init(BuildContext context) {
    InitSize(context);

    return true;
  }

  static void InitSize(BuildContext context) {
    if (context == null) return;

    MediaQueryData queryData = MediaQuery.of(context);
    winSize = Size(queryData.size.shortestSide, queryData.size.longestSide);
    physicalSize = window.physicalSize;
    devicePixelRatio = queryData.devicePixelRatio;
    paddingTop = queryData.padding.top;
    paddingBottom = queryData.padding.bottom;
  }

  // static void ShowError(String msg, {Toast timeLen = Toast.LENGTH_SHORT}) {
  //   //TradeLog.showErr(msg);
  //   Fluttertoast.showToast(
  //       gravity: ToastGravity.CENTER,
  //       msg: msg,
  //       toastLength: timeLen,
  //       textColor: SkinMgr.Font,
  //       backgroundColor: SkinMgr.BtnBg);
  // }

//索引转枚举
  static T ToEnum<T>(List<T> values, int value) {
    if (value == null) {
      return null;
    }

    return values[value];
  }

  //设置竖屏
  static Future<void> setPortrait() {
    return SystemChrome.setPreferredOrientations([
      // 强制竖屏
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
  }

  //设置横屏
  static Future<void> setLandscape() {
    return SystemChrome.setPreferredOrientations([
      //强制横屏
      Platform.isAndroid
          ? DeviceOrientation.landscapeLeft
          : DeviceOrientation.landscapeRight
    ]);
  }

  //通用导航栏
  static PreferredSizeWidget getNavigationBar(
      BuildContext context, String strTitle,
      {List<Widget> actions, Widget title, Color color, Color backColor}) {
    return AppBar(
      backgroundColor: color ?? SkinMgr.Bg,
      elevation: 0,
      centerTitle: true,
      leading: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.maybePop(context);
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: backColor ?? SkinMgr.Font,
          size: 22,
        ),
      ),
      title: title ??
          Text(
            strTitle,
            style: TextStyle(color: SkinMgr.Font, fontSize: 18),
          ),
      actions: actions,
    );
  }
}
