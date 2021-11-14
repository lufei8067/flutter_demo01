import 'dart:math';
import 'package:flutter/material.dart'; // material风格
import 'package:flutter/cupertino.dart';
import 'package:flutter_demo01/UI/FirstPage/FirstPage.dart';
import 'package:flutter_demo01/UI/SecondPage/SecondPage.dart'; // ios风格

class HomeNavPage extends StatefulWidget {
  @override
  _HomeNavPageState createState() => _HomeNavPageState();
}

class _HomeNavPageState extends State<HomeNavPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.location), label: "首页"),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.map), label: "数据"),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.down_arrow), label: '收益'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.envelope_badge), label: '我'),
  ];

  final List tabBodies = [
    FirstPage(),
    SecondPage(),
    Container(
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)][200],
    ),
    Container(
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)][200],
    ),
  ];

  int currentIndex = 0; // 当前激活的tab索引值

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: tabBodies[currentIndex],
    );
  }
}
