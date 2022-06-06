// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';

class CountDwonTimer extends StatefulWidget {
  const CountDwonTimer({Key? key}) : super(key: key);

  @override
  State<CountDwonTimer> createState() => _CountDwonTimerState();
}

class _CountDwonTimerState extends State<CountDwonTimer> {
  Timer? myTimer;
  Duration myDuration = Duration();
  @override
  void initState() {
    super.initState();
    resetTimer();
  }

  void resetTimer() {
    setState(() => myDuration = Duration(days: 7, hours: 3, minutes: 5));
  }

  void startTimer() {
    myTimer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      resetTimer();
    }
    setState(() => myTimer?.cancel());
  }

  void addTime() {
    final addSeconds = -1;
    setState(() {
      final seconds = myDuration.inSeconds + addSeconds;
      if (seconds < 0) {
        myTimer?.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  Widget displayTimer() {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = strDigits(myDuration.inHours);
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    final days = strDigits(myDuration.inDays.remainder(24));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      displayTimerUI(time: days, header: 'DAYS'),
      SizedBox(
        width: 8,
      ),
      displayTimerUI(time: hours, header: 'HOURS'),
      SizedBox(
        width: 8,
      ),
      displayTimerUI(time: minutes, header: 'MINUTES'),
      SizedBox(
        width: 8,
      ),
      displayTimerUI(time: seconds, header: 'SECONDS'),
    ]);
  }

  Widget displayTimerUI({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Text(time,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 45)),
          ),
          SizedBox(height: 30),
          Text(header, style: TextStyle(fontSize: 18, color: Colors.white)),
        ],
      );

  Widget displayTimerButtons() {
    final isTimerRunning = myTimer == null ? false : myTimer?.isActive;
    final isTimerCompleted = myDuration.inSeconds == 0;
    return isTimerRunning! || isTimerCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
                  onPressed: () {
                    if (isTimerRunning) {
                      stopTimer(resets: false);
                    }
                  },
                  child: Text(
                    'STOP',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
              SizedBox(
                width: 12,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
                  onPressed: stopTimer,
                  child: Text(
                    'RESET',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
            ],
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            onPressed: startTimer,
            child: Text(
              'Start Timer',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(title: Text('Flutter Count Down Timer Sample')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          displayTimer(),
          SizedBox(height: 100),
          displayTimerButtons()
        ],
      ),
    );
  }
}
