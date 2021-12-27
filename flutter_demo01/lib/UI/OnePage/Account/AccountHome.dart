import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_demo01/Common/Global.dart';
import 'package:flutter_demo01/Common/SkinMgr.dart';
import 'package:flutter_demo01/UI/Common/My_Underline_TabIndicator.dart';

import 'AccountCash.dart';
import 'AccountShare.dart';

class AccountHomeView extends StatefulWidget {
  final String strTitle;

  const AccountHomeView({Key key, this.strTitle}) : super(key: key);

  @override
  _AccountHomeViewState createState() => _AccountHomeViewState();
}

// class _VideoViewState extends State<VideoView>
//     with SingleTickerProviderStateMixin {

class _AccountHomeViewState extends State<AccountHomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  TabController _tabController;
  final List<Widget> _tabs = [Tab(text: "分润账户"), Tab(text: "返现账户")];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: _tabs.length,
      vsync: ScrollableState(),
    )..addListener(() {
        //print("-------------${_tabController.index}");

        FocusScope.of(context).requestFocus(FocusNode());
      });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void outCalBack() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    List<Widget> pagesList = new List();

    pagesList.add(AccountShare());
    pagesList.add(AccountCash());

    return Scaffold(
      appBar: Global.getNavigationBar(context, widget.strTitle),
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, Global.paddingTop),
        color: SkinMgr.Bg,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(48.0),
              child: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0.5,
                title: Container(
                  height: 48,
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: Theme(
                    child: TabBar(
                      indicator: MyUnderlineTabIndicator(
                          borderSide:
                              BorderSide(width: 3.0, color: SkinMgr.Blue),
                          wantWidth: 26,
                          insets: EdgeInsets.only(right: 16, bottom: 2)),

                      labelPadding: EdgeInsets.only(
                        right: 16,
                      ),

                      indicatorColor: SkinMgr.Blue, //指示器颜色
                      indicatorSize: TabBarIndicatorSize.label,
                      labelColor: SkinMgr.Font, //选中label颜色
                      unselectedLabelColor: SkinMgr.MediaFont,
                      unselectedLabelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ), // 选择的样式
                      tabs: _tabs,
                      controller: _tabController,
                    ),
                    data: ThemeData(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                  ),
                ),
                backgroundColor: SkinMgr.Bg,
              )),
          body: Container(
            color: SkinMgr.Bg,
            child: TabBarView(controller: _tabController, children: pagesList),
          ),
        ),
      ),
      backgroundColor: SkinMgr.Bg,
    );
  }
}
