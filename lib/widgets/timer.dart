import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:speaking_app/pages/reader_page.dart';

class TimerS extends StatefulWidget {
  final Stopwatch stopwatch;
  TimerS( this.stopwatch);
  @override
  _TimerSState createState() => _TimerSState();
}

class _TimerSState extends State<TimerS> {
  String formatTime(int milliseconds) {
    var secs = milliseconds ~/ 1000;
    var hours = (secs ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (secs % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  void initState() {


    super.initState();
    Timer _timer;

    _timer = new Timer.periodic(new Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }



  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(formatTime(widget.stopwatch.elapsedMilliseconds),
            style: TextStyle(fontSize: 20.0,color: widget.stopwatch.isRunning ? Colors.red : Colors.white)

            ));
  }
}
