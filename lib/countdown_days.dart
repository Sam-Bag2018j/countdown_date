// ignore_for_file: prefer_const_constructors, prefer_conditional_assignment

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(TimerApp());

class TimerApp extends StatefulWidget {
  @override
  _TimerAppState createState() => _TimerAppState();
}

//Update the time in 'YYYY-MM-DD HH:MM:SS' format
//var _selected_date = '2022-07-11 07:41:00';
DateTime _selected_date = DateTime.parse('2022-07-11 07:41:00');

class _TimerAppState extends State<TimerApp> {
  static const duration = const Duration(seconds: 1);
  DateTime _selected_date_state = DateTime.now();

  int timeDiff = _selected_date.difference(DateTime.now()).inSeconds;
  //print('the defference is ....$timeDiff');
  bool isActive = false;

  Timer? timer;

  void handleTick() {
    print('the defference is ....$timeDiff');
    if (timeDiff > 0) {
      if (isActive) {
        setState(() {
          if (_selected_date != DateTime.now()) {
            timeDiff = timeDiff - 1;
          } else {
            print('Times up!');
            //Do something
          }
        });
      }
    }
  }

  void _loadDAte() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      //svevedData = (prefs.getString('_selectDate') ?? '') as DateTime;
    });
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selected_date, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.input,
    );
    print("got date $picked");
    // if (picked != null && picked != _selected_date) {
    setState(() {
      this._selected_date_state = picked!;
      _selected_date = picked;
      this.timeDiff = _selected_date_state.difference(DateTime.now()).inSeconds;
    });
    print("new selected date : $_selected_date_state");
    print("new picked date : $picked");
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadDAte();
    //  _selectDate(context);
    // eventTime = DateTime.parse('2022-07-11 07:41:00');
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });
    }

    int days = timeDiff ~/ (60 * 60 * 24); //~/ (24 * 60 * 60) % 24;
    int hours = timeDiff ~/ (60 * 60) % 24;
    int minutes = (timeDiff ~/ 60) % 60;
    int seconds = timeDiff % 60;
    // DateTime _selected_date = DateTime();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.grey[700],
          title: Center(
            child: Text('Countdown Timer'),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '${_selected_date}'.split(':')[0],
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink),
              ),
              SizedBox(
                height: 40,
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text(
                  'pick a date',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                onPressed: () {
                  print("pressed..");
                  _selectDate(context);
                  // _selectDate;
                },
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  LabelText(
                      label: 'DAYS', value: days.toString().padLeft(2, '0')),
                  LabelText(
                      label: 'HRS', value: hours.toString().padLeft(2, '0')),
                  LabelText(
                      label: 'MIN', value: minutes.toString().padLeft(2, '0')),
                  LabelText(
                      label: 'SEC', value: seconds.toString().padLeft(2, '0')),
                ],
              ),
              SizedBox(height: 60),
              Container(
                width: 200,
                height: 47,
                margin: EdgeInsets.only(top: 30),
                child: RaisedButton(
                  color: isActive ? Colors.grey : Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Text(isActive ? 'STOP' : 'START'),
                  onPressed: () {
                    setState(() {
                      isActive = !isActive;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LabelText extends StatelessWidget {
  LabelText({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.black87,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Text(
            '$label',
            style: TextStyle(
                color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
