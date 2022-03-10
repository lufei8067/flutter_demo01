import 'package:flutter/material.dart';
import 'package:flutter_demo01/Common/SkinMgr.dart';

//圆形checkbox
class RoundCheckBox extends StatefulWidget {
  var value = false;

  Function(bool) onChanged;

  RoundCheckBox({Key key, @required this.value, this.onChanged})
      : super(key: key);

  @override
  _RoundCheckBoxState createState() => _RoundCheckBoxState();
}

class _RoundCheckBoxState extends State<RoundCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          onTap: () {
            widget.value = !widget.value;
            widget.onChanged(widget.value);
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: widget.value
                ? Icon(
                    Icons.check_circle,
                    size: 18,
                    color: SkinMgr.Orange,
                  )
                : Icon(
                    Icons.panorama_fish_eye_outlined,
                    size: 18,
                    color: SkinMgr.MinorFont,
                  ),
          )),
    );
  }
}
