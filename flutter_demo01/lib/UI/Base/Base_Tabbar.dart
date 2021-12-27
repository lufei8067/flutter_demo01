/**
 *  base_tabbar.dart
 *
 *  Created by iotjin on 2020/03/08.
 *  description:  tabbar
 */

import 'package:flutter/material.dart';

import 'package:flutter/scheduler.dart';
import 'package:flutter_demo01/Common/Global.dart';
import 'package:flutter_demo01/Common/SkinMgr.dart';
import 'package:flutter_demo01/UI/OnePage/OnePage.dart';
import 'package:flutter_demo01/UI/TowPage/TowPage.dart';
import 'package:flutter_demo01/common/Image_utils.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class BaseTabBar extends StatefulWidget {
  BaseTabBar({Key key}) : super(key: key);

  _BaseTabBarState createState() => _BaseTabBarState();
}

class _BaseTabBarState extends State<BaseTabBar> {
  int _currentIndex = 0;
  List<Widget> _pageList = [OnePage(), TowPage(), Container()];
  static double _iconWH = 24.0;
  static double _fontSize = 10.0;
  Color selColor = SkinMgr.Blue;

  List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      title: Text("首页"),
      icon: LfLoadAssetImage('tab/ic_home01', width: _iconWH),
      activeIcon: LfLoadAssetImage('tab/ic_home', width: _iconWH),
    ),
    BottomNavigationBarItem(
      title: Text("数据"),
      icon: LfLoadAssetImage('tab/ic_data01', width: _iconWH),
      activeIcon: LfLoadAssetImage('tab/ic_data', width: _iconWH),
    ),
    BottomNavigationBarItem(
      title: Text("我"),
      icon: LfLoadAssetImage('tab/ic_my01', width: _iconWH),
      activeIcon: LfLoadAssetImage('tab/ic_my', width: _iconWH),
    ),
  ];

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((Duration timestamp) {
      // 设置EasyRefresh的默认样式
      EasyRefresh.defaultHeader = ClassicalHeader(
        enableInfiniteRefresh: false,
        refreshText: '下拉刷新',
        refreshReadyText: '释放刷新',
        refreshingText: '加载中...',
        refreshedText: '加载完成',
        refreshFailedText: '加载失败',
        noMoreText: '没有更多',
        showInfo: false,
      );
    });

    SkinMgr.setSkinIndex(0);
  }

  @override
  Widget build(BuildContext context) {
    Global.Init(context); //放在connectlayer里面

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: selColor,
        //选中的颜色
        unselectedFontSize: _fontSize,
        selectedFontSize: _fontSize,
        type: BottomNavigationBarType.fixed,
        //配置底部BaseTabBar可以有多个按钮
        items: bottomTabs,
        currentIndex: this._currentIndex,
        //配置对应的索引值选中
        onTap: (int index) {
          setState(() {
            //改变状态
            this._currentIndex = index;
          });
        },
      ),
    );
  }
}
