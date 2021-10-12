import 'dart:async';

import 'package:flutter/material.dart';

import 'UI/NavigationHome/NavHomePage.dart';

void collectLog(String line) {
  //... //收集日志，如存储在本地等
}
void reportErrorAndLog(FlutterErrorDetails details) {
  //... //上报错误和日志逻辑，通过服务端日志接口上报日志

  print(details);
}

FlutterErrorDetails makeDetails(Object obj, StackTrace stack) {
  //...// 构建错误信息，根据FlutterErrorDetail组件自己的error模型及赋予基本特征信息
}

void main() {
  //runApp(MyApp());

  // print('main #1 of 2');
  // scheduleMicrotask(() => print('microtask #1 of 2'));

  // new Future.delayed(
  //     new Duration(seconds: 1), () => print('future #1 (delayed)'));
  // new Future(() => print('future #2 of 3'));
  // new Future(() => print('future #3 of 3'));

  // scheduleMicrotask(() => print('microtask #2 of 2'));

  // print('main #2 of 2');

  runZoned(
    () => runApp(MyApp()),
    zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        parent.print(zone, "Intercepted: $line");
      },
    ),
    onError: (Object obj, StackTrace stack) {
      var details = makeDetails(obj, stack);
      // 自定义error收集
      reportErrorAndLog(details);
    },
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo01',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NavHomePage(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Mydata',
//               style: TextStyle(fontSize: 50, color: Colors.red),
//             ),
//             SizedBox(
//               height: 60,
//             ),
//             Text(
//               '点击按钮18',
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
