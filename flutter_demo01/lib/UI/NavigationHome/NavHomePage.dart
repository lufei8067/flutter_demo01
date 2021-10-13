import 'dart:math';
import 'package:flutter/material.dart'; // material风格
import 'package:flutter/cupertino.dart';
import 'package:flutter_demo01/UI/HomePage/FirstPage.dart';
import 'package:flutter_demo01/UI/SecondPage/SecondPage.dart'; // ios风格

class NavHomePage extends StatefulWidget {
  @override
  _NavHomePageState createState() => _NavHomePageState();
}

class _NavHomePageState extends State<NavHomePage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.location), label: "语文"),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.map), label: "数学"),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.down_arrow), label: '画画'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.envelope_badge), label: '英语'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.music_house), label: "音乐"),
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
