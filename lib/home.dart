// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime _selected_date = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selected_date, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.input,
    );
    if (picked != null && picked != _selected_date)
      setState(() {
        _selected_date = picked;
      });
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    // to = DateTime.parse(date2Controller.text);
    return (to.difference(from).inHours / 24).round();
  }

  TextEditingController _controller = new TextEditingController();
  TextEditingController date2Controller = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  int days = 0;
  /* int differentDaysResult() {
    setState(() {
      if (dateController.text != '' && date2Controller.text != '') {
        days = (daysBetween(DateTime.parse(dateController.text),
            DateTime.parse(date2Controller.text)));
      }
    });
    return days;
  }*/
  int theDifferentDaysResult() {
    setState(() {
      if (_selected_date != '') {
        days = (daysBetween(today, _selected_date));
      }
    });
    return days;
  }

  DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('CountDown Date'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(
            // height: 50,
            //),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 15,
                crossAxisSpacing: 20,
                shrinkWrap: true,
                children: [
                  Text('$days'),
                  Text('$days'),
                  Text('$days'),
                  Text('$days'),
                  Text('$days'),
                  Text('$days')
                ],
              ),
            ),
            Text('${today.toLocal()}'.split('.')[0]),
            FlatButton(
              onPressed: () {
                _selectDate(context);
              },
              child: Text('Select date'),
            ),
            Text('${_selected_date.toLocal()}'.split(' ')[0],
                // ignore: prefer_const_constructors
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black)),
            FlatButton(
                onPressed: () {
                  theDifferentDaysResult();
                },
                child: Text('$days'))
          ],
        ),
      ),
    );
  }
}
