import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo01/Common/SkinMgr.dart';
import 'package:flutter_demo01/UI/Common/RoundCheckBox.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter_demo01/Common/Global.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode _focusNode = FocusNode();

  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  bool passwordVisible = false; //密码是否可见
  bool bSelProtocol = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _unameController?.dispose();
    _pwdController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
        child: Scaffold(
            appBar: Global.getNavigationBar(context, ""),
            body: Padding(
              padding: EdgeInsets.only(left: 32, right: 32, bottom: 20),
              child: Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12),
                      Text(
                        "登录",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: SkinMgr.Font),
                      ),
                      SizedBox(height: 24),
                      Wrap(
                        runSpacing: 14,
                        children: [
                          TextField(
                            onTap: () {
                              onPressSelArea();
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            decoration: InputDecoration(
                              labelText: "中国大陆",
                              labelStyle: TextStyle(
                                color: SkinMgr.Font,
                                // fontFamily: Font.DEFAULT_FONT_NAME,
                                // fontSize: Font.DEFAULT_FONT_SIZE
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: SkinMgr.Line),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: SkinMgr.Orange),
                              ),
                              suffixIcon: Icon(
                                Icons.expand_more,
                                color: SkinMgr.MinorFont,
                              ),
                            ),
                          ),
                          TextField(
                            keyboardType: TextInputType.number, //数字优先
                            controller: _unameController,
                            style: TextStyle(
                              color: SkinMgr.Font,
                              // fontFamily: Font.DEFAULT_FONT_NAME,
                              // fontSize: Font.DEFAULT_FONT_SIZE
                            ),
                            decoration: InputDecoration(
                              hintText: '请输入手机号码',
                              hintStyle: TextStyle(
                                color: SkinMgr.LightFont,
                                //fontSize: Font.DEFAULT_FONT_SIZE
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: SkinMgr.Line),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: SkinMgr.Orange),
                              ),
                              suffixIcon: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Icon(
                                        Icons.cancel,
                                        color: SkinMgr.MinorFont,
                                        size: 20,
                                      )),
                                  onTap: onPressCleanAct),
                            ),
                          ),
                          TextField(
                            style: TextStyle(
                              color: SkinMgr.Font,
                              // fontFamily: Font.DEFAULT_FONT_NAME,
                              // fontSize: Font.DEFAULT_FONT_SIZE
                            ),
                            keyboardType: TextInputType.visiblePassword, //数字优先
                            controller: _pwdController,
                            focusNode: _focusNode,
                            obscureText: !passwordVisible,
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Icon(
                                    passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: SkinMgr.MinorFont,
                                    size: 20,
                                  ),
                                ),
                                onTap: () {
                                  //判断TextFormField是否处于获得焦点的状态，如果没有，当点击图标时禁止TextFormField获取焦点，也就不会弹出软键盘了，当TextFormField获取焦点时，点击图标，不关闭软键盘
                                  if (!_focusNode.hasFocus) {
                                    _focusNode.canRequestFocus = false;
                                    Future.delayed(Duration(milliseconds: 500),
                                        () {
                                      _focusNode.canRequestFocus = true;
                                    });
                                  }

                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                              ),
                              hintText: '请输入密码',
                              hintStyle: TextStyle(
                                color: SkinMgr.LightFont,
                                //fontSize: Font.DEFAULT_FONT_SIZE
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: SkinMgr.Line),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: SkinMgr.Orange),
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: onPressLogin,
                            child: Text(
                              "登录",
                              style: TextStyle(fontSize: 18),
                            ),
                            color: SkinMgr.Orange,
                            textColor: Colors.white,
                            minWidth: Global.winSize.width,
                            height: 40,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundCheckBox(
                                value: this.bSelProtocol,
                                onChanged: (bool val) {
                                  this.setState(() {
                                    this.bSelProtocol = !this.bSelProtocol;
                                  });
                                },
                              ),
                              RichText(
                                text: TextSpan(
                                  text: '已阅读并同意',
                                  style: TextStyle(
                                      //fontSize: Font.SMALL_FONT_SIZE,
                                      color: SkinMgr.LightFont),
                                  children: [
                                    TextSpan(
                                      text: '《服务条款》',
                                      style: TextStyle(
                                          //fontSize: Font.SMALL_FONT_SIZE,
                                          color: SkinMgr.Orange),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          //launch(Config.Service);
                                        },
                                    ),
                                    TextSpan(
                                      text: '和',
                                      style: TextStyle(
                                          //fontSize: Font.SMALL_FONT_SIZE,
                                          color: SkinMgr.LightFont),
                                    ),
                                    TextSpan(
                                      text: '《隐私政策》',
                                      style: TextStyle(
                                          //fontSize: Font.SMALL_FONT_SIZE,
                                          color: SkinMgr.Orange),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // launch(Config.Privacy);
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FlatButton(
                          onPressed: onPressRegister,
                          child: Text('注册',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 18)),
                          textColor: SkinMgr.PrimaryFont),
                      Container(
                        width: 1,
                        height: 12,
                        color: SkinMgr.MinorFont,
                      ),
                      FlatButton(
                        onPressed: onPressForgot,
                        child: new Text('忘记密码',
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 15)),
                        textColor: SkinMgr.PrimaryFont,
                      ),
                    ],
                  )
                ],
              ),
            )));
  }

  void onPressVisitor() {}

  void onPressLogin() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void onPressRegister() {}

  void onPressForgot() {}

  void onPressCleanAct() {
    setState(() {
      _unameController.text = "";
    });
  }

  void onPressSelArea() {}

  //在其他地方登陆了
  void onLoginElseWhere(dynamic data) {}

  void onFinishSymbolList(dynamic data) {}

  void onFastRegister(dynamic data) {}
}
