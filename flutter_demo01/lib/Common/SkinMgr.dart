import 'package:flutter/material.dart';

import 'Global.dart';
// import 'package:flutter_app/DataBase/SettingData.dart';
// import 'package:flutter_app/DataBase/StockData.dart';
// import 'package:flutter_app/Global.dart';

enum SkinType { Day, Dark }

class SkinMgr {
  static int s_iSkinIndex = 0;

  static Color Red = const Color(0xFFEB4654);
  static Color Green = const Color(0xFF00AF92);
  static Color Golden = const Color(0xFFD3A552);
  static Color Orange = const Color(0xFFFE7241);
  static Color Yellow = const Color(0xFFFFB419);
  static Color Blue = const Color(0xFF4777F4);
  static Color DeepGolden = const Color(0xFF785005);

  static Color Keyboard;

  static Color KLineRed = Red;
  static Color KLineGreen = Green;
  static Color KLineBlue = Blue;
  static Color KLineDeepSkyBlue = const Color(0xFF1CBEDC);
  static Color KLineMediumOrchid = const Color(0xFF9B7DE1);
  static Color KLineViolet = const Color(0xFFD773C3);
  static Color KLineFuchsia = const Color(0xFFE73586);
  static Color KLineOrange = const Color(0xFFFFA046);
  static Color KLineYellow = const Color(0xFFFFD124);
  static Color KLineBrown = const Color(0xFFA76438);
  static Color KLineTan = const Color(0xFFC19E94);
  static Color KLineLimeGreen = const Color(0xFFA3BB47);
  static Color KLineLightGreen = const Color(0xFF47C890);
  static Color KLineGray = const Color(0xFF77A1BF);

  static Color Font;
  static Color LightFont;
  static Color PrimaryFont;
  static Color MinorFont;
  static Color BtnBg;
  static Color Bg;
  static Color Line;
  static Color Line2;
  static Color Panel;
  static Color OrangeBg;
  static Color PrimaryBg;
  static Color BarsColor;
  static Color MediaFont;
  static Color Shodow;
  static Color CodeBg;
  static Color TimeSelectorColor;
  static Color BlackColor1;
  static Color BlackColor2;
  static Color BlackColor3; //黑白灰/浅浅灰
  static Color OrderPointColor; //下单点
  static Color OrderPointSelColor; //下单点选中
  static Color OrderPointFColor; //下单点 的点
  static Color OrderPointFSelColor; //下单点 的点 选中
  static Color OrderPointPanel;

  static SkinType get getSkinType =>
      Global.ToEnum(SkinType.values, s_iSkinIndex);

  static bool get isDark => s_iSkinIndex != 0;

  static void setSkinIndex(int iIndex) {
    s_iSkinIndex = iIndex;
    if (s_iSkinIndex == 0) {
      // 白天模式
      BarsColor = Color.fromRGBO(245, 246, 249, 1);
      Shodow = Colors.black.withAlpha(10);
      Font = Color(0xFF2B3039);
      MediaFont = Color(0xFF83889A);
      PrimaryFont = Color(0xFF7A7E86);
      LightFont = Color(0xFFA2A8B3);
      MinorFont = Color(0xFFC3C6CD);
      Bg = Color(0xFFFFFFFF);
      Line = Color(0xFFEEEEEE);
      Line2 = Color(0xFFEFEFEF);
      Panel = Color(0xFFF5F6F9);
      OrangeBg = Color(0xFFFEF1E8);
      PrimaryBg = Color(0xFFF5F6F9);

      BtnBg = Color(0xFFF5F6F9);
      CodeBg = Color(0xFFFFFFFF);

      TimeSelectorColor = Color(0x19FB7419);
      BlackColor1 = Color.fromRGBO(195, 198, 205, 1);
      BlackColor2 = Color.fromRGBO(245, 246, 249, 1);
      BlackColor3 = Color.fromRGBO(225, 227, 233, 1);

      Keyboard = const Color(0xFFE1E3E9);

      OrderPointColor = Color(0xFF7A7E86);
      OrderPointSelColor = Color(0xFF2B3039);
      OrderPointFColor = Color(0xFFA2A8B3);
      OrderPointFSelColor = Color(0xFF7A7E86);
      OrderPointPanel = Color(0xFFE1E3E9);
    } else {
      // 黑夜模式
      Font = Color(0xE6FFFFFF);
      PrimaryFont = Color(0xFFA2A8B3);
      LightFont = Color(0xFF7A7E86);
      MinorFont = Color(0xFF3C4555);
      Bg = Color(0xFF141923);
      Line = Color(0xFF2D384F);
      Line2 = Color(0x0FFFFFFF);
      Panel = Color(0xFF171E31);
      OrangeBg = Color.fromRGBO(75, 56, 47, 1);

      PrimaryBg = Color(0xFF232933);
      BarsColor = Color.fromRGBO(35, 41, 51, 1);
      MediaFont = Color(0xFFA2A8B3);
      BtnBg = Color(0xFF232933);

      CodeBg = Color(0xFF323946);
      Shodow = Colors.white.withAlpha(10);
      TimeSelectorColor = Color(0x33FB7419);
      BlackColor1 = Color.fromRGBO(122, 126, 134, 1);
      BlackColor2 = Color.fromRGBO(35, 41, 51, 1);
      BlackColor3 = Color.fromRGBO(50, 57, 70, 1);

      Keyboard = const Color(0xFF081317);
      OrderPointColor = Color(0xFF7A7E86);
      OrderPointSelColor = Color(0xFFA2A8B3);
      OrderPointFColor = Color(0xFF7A7E86);
      OrderPointFSelColor = Color(0xFFA2A8B3);
      OrderPointPanel = Color(0xFF3C4555);
    }

    //setInverseKLineColor();
  }

  // static void setInverseKLineColor() {
  //   if (SettingData.GetInstance().bInverseKLineColor.value) {
  //     KLineRed = Green;
  //     KLineGreen = Red;
  //   } else {
  //     KLineRed = Red;
  //     KLineGreen = Green;
  //   }

  //   StockData.GetInstance().updateColor();
  // }
}
