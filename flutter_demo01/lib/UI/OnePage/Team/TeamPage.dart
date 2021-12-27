/**
 *  two_page.dart
 *
 *  Created by iotjin on 2019/08/14.
 *  description:  通讯录
 */

import 'dart:convert';
import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo01/Common/Global.dart';
import 'package:flutter_demo01/Common/SkinMgr.dart';
import 'package:lpinyin/lpinyin.dart';

import 'Cell/JhSetCell.dart';
import 'Model/ContactsModel.dart';

const Color bgColor = Colors.black87;
const double radius = 3.0;

class TeamPage extends StatefulWidget {
  final String strTitle;

  const TeamPage({Key key, this.strTitle}) : super(key: key);

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  List<ContactsModel> _dataList = List();

  // 联系人总数
  String _contactsCount = '';

  double _suspensionHeight = 27;
  double _itemHeight = 50;
  String _suspensionTag = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      _loadData();
    });
  }

  void _loadData() async {
    // 获取用户信息列表
    final jsonStr = await rootBundle.loadString('lib/res/wx_contacts.json');

    Map dic = json.decode(jsonStr);
    List dataArr = dic['data'];
    dataArr.forEach((item) {
      ContactsModel model = ContactsModel.fromJson(item);
      _dataList.add(model);
    });
    _handleList(_dataList);
    setState(() {});
  }

  // void _loadData() async {
  //   //加载城市列表
  //   rootBundle.loadString('lib/res/china.json').then((value) {
  //     Map countyMap = json.decode(value);
  //     List list = countyMap['china'];
  //     list.forEach((item) {
  //       print('name: ${item['name']}');
  //       //_cityList.add(ContactsModel(name: item['name']));
  //     });
  //     // _handleList(_cityList);
  //     setState(() {});
  //   });
  // }

  void _handleList(List<ContactsModel> list) {
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;

      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    //根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(_dataList);

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(_dataList);

    // add header.
    _dataList.insert(0, ContactsModel(name: 'header', tagIndex: '🔍'));

    _contactsCount = "${_dataList.length - 1} 位朋友及联系人";

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Global.getNavigationBar(context, widget.strTitle),
      body: _body(),
      backgroundColor: Color(0xFFEDEDED),
    );
  }

  //body
  Widget _body() {
    return AzListView(
      data: _dataList,
      itemCount: _dataList.length,
      itemBuilder: (BuildContext context, int index) {
        //if (index == 0) return _buildHeader();
        if (index == 0)
          return Container(
            height: 140,
            color: SkinMgr.Blue,
          );

        ContactsModel model = _dataList[index];
        return _buildListItem(model);
      },
      physics: BouncingScrollPhysics(),
      susItemHeight: _suspensionHeight,
      susItemBuilder: (BuildContext context, int index) {
        ContactsModel model = _dataList[index];
        String tag = model.getSuspensionTag();
        if ('🔍' == model.getSuspensionTag()) {
          return Container();
        }
        return _buildSusWidget(tag, isFloat: true);
      },
      indexBarData: SuspensionUtil.getTagIndexList(_dataList),
      indexBarOptions: IndexBarOptions(
        needRebuild: true,
        ignoreDragCancel: true,
        selectTextStyle: TextStyle(
            fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500),
        selectItemDecoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.green),
        indexHintWidth: 120 / 2,
        indexHintHeight: 100 / 2,
        indexHintDecoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/ic_index_bar_bubble_gray.png'),
            fit: BoxFit.contain,
          ),
        ),
        indexHintAlignment: Alignment.centerRight,
        indexHintTextStyle: TextStyle(
            color: Colors.white70, fontSize: 30.0, fontWeight: FontWeight.w700),
        indexHintChildAlignment: Alignment(-0.25, 0.0),
        indexHintOffset: Offset(-10, 0),
      ),
    );
  }

  // 吸顶组件
  Widget _buildSusWidget(String susTag, {bool isFloat = false}) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
      height: _suspensionHeight,
      width: width,
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: SkinMgr.Line,
        border: isFloat
            ? Border(bottom: BorderSide(color: Color(0xFFE6E6E6), width: 0.5))
            : null,
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        '${susTag == '★' ? '★ 星标朋友' : susTag}',
        softWrap: false,
        style: TextStyle(
          fontSize: 13,
          color: SkinMgr.Font,
        ),
      ),
    );
  }

  //Cell
  Widget _buildListItem(ContactsModel model) {
    String susTag = model.getSuspensionTag();
    double _cellH = _itemHeight;
    double _leftSpace = 65.0;
    double _imgWH = 40;
    Widget _cell = JhSetCell(
      titleWidth: 200,
      leftImgWH: _imgWH,
      cellHeight: _cellH,
      lineLeftEdge: _leftSpace,
      title: model.name,
      hiddenArrow: true,
      leftWidget: Container(
        height: _imgWH,
        width: _imgWH,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Center(
          child: Text(model.name.substring(0, 1),
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ),
      clickCallBack: () {
        //跳转个人信息页 跳转传递model
        String jsonStr = Uri.encodeComponent(jsonEncode(model));
        // NavigatorUtils.pushNamed(
        //     context, '${"WxUserInfoPage"}?passValue=${jsonStr}');
      },
    );

    return Column(
      children: <Widget>[
        _cell,
        Offstage(
          offstage: _dataList[_dataList.length - 1].id != model.id,
          child: Container(
            width: double.infinity,
            height: _cellH,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(width: 0.5, color: SkinMgr.BlackColor1),
                )),
            child: Text(
              _contactsCount,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  void _clickCell(context, text) {
    // JhToast.showText(context, msg: '点击 ${text}');
    if (text == '新的朋友') {
      //NavigatorUtils.pushNamed(context, 'WxNewFriendPage');
    }
    if (text == '群聊') {
      //NavigatorUtils.pushNamed(context, 'WxGroupChatPage');
    }
  }
}
