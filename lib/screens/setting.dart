import 'package:flutter/material.dart';
import 'package:productivity_timer/main.dart';
import 'package:productivity_timer/screens/countdowntimer.dart';
import 'package:productivity_timer/widgets/setting_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  SharedPreferences sharedPreferences;
  TextEditingController txtWork;
  TextEditingController txtShort;
  TextEditingController txtLong;

  static const String WORKTIME = 'workTime';
  static const String SHORTBREAK = 'shortBreak';
  static const String LONGBREAK = 'longBreak';

  int workTime;
  int shortBreak;
  int longBreak;

  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    settingReader();

    super.initState();
  }

  String dropdownValue = '1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Container(
          padding: EdgeInsets.all(20),
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 3,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Text(
                'Work',
                style: TextStyle(fontSize: 20),
              ),
              Text(""),
              Text(""),
              SettingButton(Colors.cyan, -1, 50, "-", updateSetting, WORKTIME),
              TextField(
                controller: txtWork,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 20),
              ),
              SettingButton(
                  Colors.lightBlueAccent, 1, 50, "+", updateSetting, WORKTIME),
              Text(
                'Short Break',
                style: TextStyle(fontSize: 20),
              ),
              Text(""),
              Text(""),
              SettingButton(Colors.deepPurple[300], -1, 50, "-", updateSetting,
                  SHORTBREAK),
              TextField(
                controller: txtShort,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 20),
              ),
              SettingButton(
                  Colors.green[300], 1, 50, "+", updateSetting, SHORTBREAK),
              Text(
                'Long Break',
                style: TextStyle(fontSize: 20),
              ),
              Text(""),
              Text(""),
              SettingButton(
                  Colors.lime[300], -1, 50, "-", updateSetting, LONGBREAK),
              TextField(
                controller: txtLong,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 20),
              ),
              SettingButton(
                  Colors.purple[300], 1, 50, "+", updateSetting, LONGBREAK),
              Text(''),
              Text(''),
              Text(''),
              Text(''),
              Text(''),
              RaisedButton(
                color: Colors.redAccent,
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MyApp()));
                },
              )
            ],
          )),
    );
  }

  settingReader() async {
    sharedPreferences = await SharedPreferences.getInstance();
     workTime = sharedPreferences.getInt(WORKTIME);
    if (workTime == null) {
      await sharedPreferences.setInt(WORKTIME, 30);
    }
     shortBreak = sharedPreferences.getInt(SHORTBREAK);
    if (shortBreak == null) {
      await sharedPreferences.setInt(SHORTBREAK, 5);
    }
     longBreak = sharedPreferences.getInt(LONGBREAK);
    if (longBreak == null) {
      await sharedPreferences.setInt(LONGBREAK, 20);
    }

    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }

  void updateSetting(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          int work = sharedPreferences.getInt(WORKTIME);
          work += value;
          if (work >= 1 && work <= 180) {
            sharedPreferences.setInt(WORKTIME, work);
            setState(() {
              txtWork.text = work.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          int short = sharedPreferences.getInt(SHORTBREAK);
          short += value;
          if (short >= 1 && short <= 180) {
            sharedPreferences.setInt(SHORTBREAK, short);
            setState(() {
              txtShort.text = short.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          int long = sharedPreferences.getInt(LONGBREAK);
          long += value;
          if (long >= 1 && long <= 180) {
            sharedPreferences.setInt(LONGBREAK, long);
            setState(() {
              txtLong.text = long.toString();
            });
          }
        }
        break;
    }
  }
}
