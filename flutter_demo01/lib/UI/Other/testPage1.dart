import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo01/Common/SkinMgr.dart';

class TestPage1 extends StatefulWidget {
  const TestPage1({Key key}) : super(key: key);

  @override
  _TestPage1State createState() => _TestPage1State();
}

class _TestPage1State extends State<TestPage1> {
  bool _isHidePassWord = false;
  FocusNode _focusNode = FocusNode();
  TextEditingController _pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("widget.title"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _pwdController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: '密码：',
                hintText: '请输入密码',
                hintStyle: TextStyle(fontSize: 12),
                suffixIcon: IconButton(
                  onPressed: () {
                    //判断TextFormField是否处于获得焦点的状态，如果没有，当点击图标时禁止TextFormField获取焦点，也就不会弹出软键盘了，当TextFormField获取焦点时，点击图标，不关闭软键盘
                    if (!_focusNode.hasFocus) {
                      _focusNode.canRequestFocus = false;
                      Future.delayed(Duration(milliseconds: 500), () {
                        _focusNode.canRequestFocus = true;
                      });
                    }
                    setState(() {
                      print(_isHidePassWord);
                      _isHidePassWord = !_isHidePassWord;
                    });
                  },
                  icon: Icon(_isHidePassWord
                      ? Icons.visibility_off
                      : Icons.visibility),
                ),
              ),
              validator: (v) => v.trim().length >= 6 ? null : '密码最多六位',
              obscureText: _isHidePassWord,
              textInputAction: TextInputAction.done, //设置软键盘确定按键显示为完成
            )
          ],
        ),
      ),
    );
  }
}
