import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/timer_model.dart';

class CountDownTimer {
  static AudioCache player = new AudioCache();
  final aPath = "alarm.ogg";
  final bPath = "Trickle.ogg";
  double _radious = 1;
  bool _isActive = false;
  Timer _timer;
  Duration _time;
  Duration _fullTime;
  int work;
  int short;
  int long;
  static AudioPlayer p;
  bool _isWork = false;

  Future readSetting() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    work = sharedPreferences.getInt('workTime') == null
        ? 30
        : sharedPreferences.getInt('workTime');
    short = sharedPreferences.getInt('shortBreak') == null
        ? 5
        : sharedPreferences.getInt('shortBreak');
    long = sharedPreferences.getInt('longBreak') == null
        ? 20
        : sharedPreferences.getInt('longBreak');
  }

  Stream<TimerModel> stream(c) async* {
    yield* Stream.periodic(Duration(seconds: 1), (int a) {
      String time;
      if (this._isActive) {
        _time = _time - Duration(seconds: 1);
        _radious = _time.inMilliseconds / _fullTime.inMilliseconds;
        if (_time.inMilliseconds <= 0) {
          _isActive = false;
          alert(c);
          playLocal(bPath);
        }
      }
      time = returnTime(_time);
      return TimerModel(time: time, parcent: _radious);
    });
  }

  String returnTime(Duration t) {
    String minutes = t.inMinutes < 10
        ? '0' + t.inMinutes.toString()
        : t.inMinutes.toString();
    int numSec = t.inSeconds - (t.inMinutes * 60);
    String seconds = numSec < 10 ? '0' + numSec.toString() : numSec.toString();
    String formatedTime = minutes + ':' + seconds;
    return formatedTime;
  }

  void start() async {
    await readSetting();
    _radious = 1;
    _time = Duration(minutes: 0, seconds: 0);
    _fullTime = _time;
  }

  void startWork() {
    _radious = 1;
    _time = Duration(minutes: this.work, seconds: 0);
    _fullTime = _time;
    _isWork = true;
  }

  void startTimer() {
    if (_time.inSeconds > 0) {
      this._isActive = true;
    }
  }

  void stopTimer() {
    this._isActive = false;
  }

  void startBreak(bool isShort) {
    _radious = 1;
    _time = Duration(minutes: (isShort) ? short : long, seconds: 0);
    _fullTime = _time;
    _isWork = false;
  }

  playLocal(path) async {
    p = await player.play(path);
  }

  void alert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Time Over'),
          content: Text(
              'Your ${_isWork ? "Work" : "Break"} time have reached it limit'),
          actions: <Widget>[
            FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  p.stop();
                  return Navigator.of(context).pop();
                })
          ],
        );
      },
    );
  }
}
