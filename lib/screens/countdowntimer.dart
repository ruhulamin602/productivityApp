import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:productivity_timer/model/timer_model.dart';
import 'package:productivity_timer/screens/setting.dart';
import 'package:productivity_timer/widgets/worktimer.dart';

class MyWorkTimer extends StatelessWidget {
  final String title;
  MyWorkTimer({this.title});

  final CountDownTimer timer = CountDownTimer();

  @override
  Widget build(BuildContext context) {
    final double defaultPadding = 5;
    final List<PopupMenuItem<String>> menuItems = List<PopupMenuItem<String>>();
    menuItems.add(PopupMenuItem(
      value: 'Setting',
      child: Text('Setting'),
    ));

    timer.start();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          PopupMenuButton(onSelected: (s) {
            if (s == 'Setting') {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SettingScreen()));
            }
          }, itemBuilder: (BuildContext context) {
            return menuItems.toList();
          })
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              UpperButtons(defaultPadding: defaultPadding, timer: timer),
              Spacer(),
              PercentageView(timer: timer),
              Spacer(),
              LowerButtons(
                defaultPadding: defaultPadding,
                timer: timer,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class LowerButtons extends StatefulWidget {
  LowerButtons({
    Key key,
    @required this.defaultPadding,
    @required this.timer,
  }) : super(key: key);

  final double defaultPadding;
  final CountDownTimer timer;

  @override
  _LowerButtonsState createState() => _LowerButtonsState();
}

class _LowerButtonsState extends State<LowerButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(widget.defaultPadding),
          ),
          Expanded(
            child: RaisedButton(
              onPressed: () => widget.timer.stopTimer(),
              child: Text('Stop'),
              color: Colors.cyan,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(widget.defaultPadding),
          ),
          Expanded(
            child: RaisedButton(
              onPressed: () {
                widget.timer.startTimer();
              },
              color: Colors.amberAccent,
              child: Text('Start'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(widget.defaultPadding),
          )
        ]);
  }
}

class UpperButtons extends StatelessWidget {
  const UpperButtons({
    Key key,
    @required this.defaultPadding,
    @required this.timer,
  }) : super(key: key);

  final double defaultPadding;
  final CountDownTimer timer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(defaultPadding),
        ),
        Expanded(
          child: RaisedButton(
            onPressed: () => timer.startWork(),
            child: Text('Work'),
            color: Colors.redAccent[400].withAlpha(100),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(defaultPadding),
        ),
        Expanded(
          child: RaisedButton(
            onPressed: () => timer.startBreak(true),
            child: Text('Short'),
            color: Colors.purpleAccent.withAlpha(100),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(defaultPadding),
        ),
        Expanded(
          child: RaisedButton(
            onPressed: () => timer.startBreak(false),
            color: Colors.lime[300],
            child: Text('Long'),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(defaultPadding),
        ),
      ],
    );
  }
}

class PercentageView extends StatelessWidget {
  const PercentageView({
    Key key,
    @required this.timer,
  }) : super(key: key);

  final CountDownTimer timer;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: '00:00',
        stream: timer.stream(context),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          TimerModel timer = (snapshot.data == '00:00')
              ? TimerModel(time: '00:00', parcent: 1)
              : snapshot.data;
          return Expanded(
            flex: 6,
            child: GestureDetector(
              onTap: () => CountDownTimer.p.stop(),
              child: CircularPercentIndicator(
                radius: MediaQuery.of(context).size.width * 0.6,
                backgroundColor: Colors.amberAccent,
                percent: timer.parcent,
                lineWidth: 10,
                progressColor: Colors.cyanAccent,
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                  timer.time,
                  style: TextStyle(fontSize: 50),
                ),
              ),
            ),
          );
        });
  }
}
