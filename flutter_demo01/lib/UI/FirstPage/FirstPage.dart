import 'dart:math';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)][200],
    );
  }
}
