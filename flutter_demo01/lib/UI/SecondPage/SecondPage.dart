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
  final _controller = StreamController.broadcast();
  final _scoreController = StreamController.broadcast();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: _scoreController.stream.transform(TallyTransformer()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("答对: ${snapshot.data[0]}"),
                  Text("💪🏻走读生加油💪🏻"),
                  Text("答错: ${snapshot.data[1]}")
                ],
              );
            }
            return Text("请陆雨萱答题");
          },
        ),
      ),
      body: Stack(
        children: [
          Puzzle(_controller.stream, _scoreController),
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
    _scoreController.close();
  }
}

//汇总
class TallyTransformer implements StreamTransformer {
  int iCorrect = 0;
  int iMistake = 0;
  StreamController _controller = StreamController();

  @override
  Stream bind(Stream stream) {
    stream.listen((event) {
      //sum += event;
      if (event == 5) {
        iCorrect += 1;
      } else {
        iMistake += 1;
      }

      _controller.add([iCorrect, iMistake]);
    });

    return _controller.stream;
  }

  @override
  StreamTransformer<RS, RT> cast<RS, RT>() => StreamTransformer.castFrom(this);
}

//数字
class Puzzle extends StatefulWidget {
  final inputStream;
  final scoreStream;

  Puzzle(this.inputStream, this.scoreStream);
  @override
  _PuzzleState createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> with SingleTickerProviderStateMixin {
  int a, b;
  Color color;
  double x;

  AnimationController _controller;

  reset([from = 0.0]) {
    a = Random().nextInt(5) + 1;
    b = Random().nextInt(5);
    x = Random().nextDouble() * 300; //MediaQuery.of(context).size.width
    color = Colors.primaries[Random().nextInt(Colors.primaries.length)][200];
    _controller.duration =
        Duration(milliseconds: Random().nextInt(5000) + 10000);
    _controller.forward(from: from);
  }

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10))
          ..forward();
    reset();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        reset();
        //-
        widget.scoreStream.add(-5);
      }
    });

    widget.inputStream.listen((input) {
      if (input == a + b) {
        reset();
        //+
        widget.scoreStream.add(5);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //MediaQuery.of(context).size.height
    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, child) {
          return Positioned(
              left: x,
              top: 700 * _controller.value - 100,
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
