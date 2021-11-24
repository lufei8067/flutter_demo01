import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_demo01/Common/SkinMgr.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        brightness: SkinMgr.getSkinType == SkinType.Day
            ? Brightness.light
            : Brightness.dark,
        backgroundColor: SkinMgr.Bg,
      ),
      body: Material(
        child: Column(
          children: [
            Container(
              height: 50,
              color: SkinMgr.BlackColor2,
            ),
            Flexible(
                child: new MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView(children: [
                      Container(
                        height: 130,
                        color: SkinMgr.BlackColor1,
                      ),
                      Container(
                        height: 130,
                        color: SkinMgr.Blue,
                      ),
                      Container(
                        height: 130,
                        color: SkinMgr.Red,
                      ),
                      Container(
                        height: 130,
                        color: SkinMgr.Orange,
                      ),
                    ])))
          ],
        ),
        color: SkinMgr.Bg,
      ),
    );
  }
}
