import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo01/Common/SkinMgr.dart';

class TowPage extends StatefulWidget {
  const TowPage({Key key}) : super(key: key);

  @override
  _TowPageState createState() => _TowPageState();
}

class _TowPageState extends State<TowPage> {
  Future<bool> isEuropeUser() async {
    // Native channel
    const platform = const MethodChannel("com.test/name"); //分析1
    bool result = false;
    try {
      result = await platform.invokeMethod("isChinese"); //分析2
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SkinMgr.Orange,
    );
  }
}
