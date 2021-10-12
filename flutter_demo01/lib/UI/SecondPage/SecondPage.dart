import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final _controller = StreamController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: _controller.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text("You entered: ${snapshot.data}");
            }
            return Text("waiting...");
          },
        ),
      ),
      body: Stack(
        children: [
          Puzzle(),
          Align(
            alignment: Alignment.bottomCenter,
            child: KeyPad(_controller),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }
}

//数字
class Puzzle extends StatefulWidget {
  @override
  _PuzzleState createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> with SingleTickerProviderStateMixin {
  int a, b;
  Color color;
  double x;

  AnimationController _controller;

  reset() {
    a = Random().nextInt(5) + 1;
    b = Random().nextInt(5);
    x = Random().nextDouble() * 300;
    color = Colors.primaries[Random().nextInt(Colors.primaries.length)][200];
  }

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5))
          ..forward();

    reset();
    _controller.forward(from: Random().nextDouble());

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        reset();
        _controller.forward(from: 0.0);
      }
    });
    //..repeat();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, child) {
          return Positioned(
              left: x,
              top: 400 * _controller.value,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "$a + $b",
                  style: TextStyle(fontSize: 24),
                ),
              ));
        });
  }
}

//键盘
class KeyPad extends StatelessWidget {
  final _controller;

  KeyPad(this._controller);
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      padding: EdgeInsets.all(0.0),
      physics: NeverScrollableScrollPhysics(),
      childAspectRatio: 2 / 1,
      children: List.generate(9, (index) {
        return FlatButton(
            shape: RoundedRectangleBorder(),
            color: Colors.primaries[index][200],
            onPressed: () {
              _controller.add(index + 1);
            },
            child: Text(
              "${index + 1}",
              style: TextStyle(fontSize: 24),
            ));
      }),
    );
  }
}
