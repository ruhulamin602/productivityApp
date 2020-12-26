import 'package:flutter/material.dart';

typedef CallBack = Function(String, int);

class SettingButton extends StatefulWidget {
  final Color color;
  final int value;
  final double minWidth;
  final String text;
  final CallBack callback;
  final String setting;

  SettingButton(this.color, this.value, this.minWidth, this.text, this.callback,
      this.setting);
  @override
  _SettingButtonState createState() => _SettingButtonState();
}

class _SettingButtonState extends State<SettingButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => widget.callback(widget.setting, widget.value),
      color: widget.color,
      child: Text(
        widget.text,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
