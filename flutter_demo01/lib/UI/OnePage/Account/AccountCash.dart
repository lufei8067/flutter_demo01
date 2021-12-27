import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_demo01/Common/SkinMgr.dart';

class AccountCash extends StatefulWidget {
  const AccountCash({Key key}) : super(key: key);

  @override
  _AccountCashState createState() => _AccountCashState();
}

class _AccountCashState extends State<AccountCash> {
  int iSelIndex = 0;
  final List<double> vtList = List();

  @override
  void initState() {
    super.initState();

    for (int iIndex = 0; iIndex < 20; iIndex++) {
      vtList.add(Random().nextInt(8) * 10 + 20.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
            child: new MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(children: [
                  Container(
                    height: 271,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromRGBO(255, 199, 93, 1),
                          Color.fromRGBO(255, 165, 62, 1),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "  本月收益（元）",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              " 1231242342353232",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 26),
                            ),
                            Spacer(),
                            Container(
                              width: 80,
                              height: 32,
                              child: FlatButton(
                                color: Colors.white,
                                textColor: Color.fromRGBO(255, 166, 63, 1),
                                onPressed: () {},
                                child: Text(
                                  "提现",
                                  style: TextStyle(fontSize: 12),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "  本月收益（元）",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Spacer(),
                        _histogram()
                      ],
                    ),
                  ),
                  _itemBottom(SkinMgr.Red, "直营分润"),
                  _itemBottom(SkinMgr.Yellow, "联盟分润"),
                  _itemBottom(SkinMgr.Blue, "管理津贴"),
                  _itemBottom(SkinMgr.Green, "交易量奖励"),
                  _itemBottom(Colors.cyan, "交易量达标奖励"),
                  _itemBottom(Color.fromRGBO(1, 0, 245, 1), "交易量阶梯奖励"),
                  _itemBottom(Color.fromRGBO(251, 144, 40, 1), "提现"),
                ])))
      ],
    );
  }

  _histogram() {
    List<Widget> pagesList = List();

    for (int iIndex = 0; iIndex < 20; iIndex++) {
      pagesList.add(GestureDetector(
        onTap: () {
          setState(() {
            iSelIndex = iIndex;
          });
        },
        child: Container(
          //color: SkinMgr.LightFont,
          child: Column(
            children: [
              SizedBox(
                height: vtList[iIndex],
              ),
              Container(
                  width: 13,
                  height: 100 - vtList[iIndex],
                  decoration: BoxDecoration(
                    color: iIndex == iSelIndex
                        ? Colors.white
                        : Color.fromRGBO(252, 157, 22, 1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 0, style: BorderStyle.none),
                  )),
              Spacer(),
              Text(
                "21/" + "${iIndex.toString()}",
                style: TextStyle(color: SkinMgr.Bg, fontSize: 11),
              )
            ],
          ),
        ),
      ));

      pagesList.add(Container(
        width: 20,
        //color: SkinMgr.Orange,
      ));
    }

    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 5, right: 15),
      height: 130,
      child: ListView(
        scrollDirection: Axis.horizontal,
        reverse: true,
        shrinkWrap: true,
        children: pagesList,
      ),
    );
  }

  //
  _itemBottom(Color mColor, String strTitle) {
    return Container(
      //color: SkinMgr.LightFont,
      margin: EdgeInsets.only(top: 12),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: mColor,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(width: 0, style: BorderStyle.none),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                strTitle,
                style: TextStyle(color: SkinMgr.Font, fontSize: 14),
              ),
              Spacer(),
              Text(
                "+100",
                style: TextStyle(color: SkinMgr.Font, fontSize: 14),
              ),
              SizedBox(
                width: 15,
              )
            ],
          ),
          Container(
            height: 1,
            color: SkinMgr.Line,
            margin: EdgeInsets.fromLTRB(15, 12, 15, 0),
          ),
        ],
      ),
    );
  }
}
