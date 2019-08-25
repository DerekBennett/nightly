import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nightly',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(title: 'Nightly'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Stopwatch _stopwatch;
  String _status = 'Press button to begin';

  var _activity = [
    'BEGIN',
    'Toilet',
    'Wash',
    'Dental',
    'Dry',
    'Pajamas',
    'Arrange Bed',
    'Reading',
    'DONE'
  ];

  String updateStatusString(Stopwatch _s){
    return 'Time Taken: ${_s.elapsed.inMinutes}\' ${_s.elapsed.inSeconds}\"';
  }

  void _displayElapsedSeconds(Timer timer) {
    setState(() {
        _status = updateStatusString(_stopwatch);
    });
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      if (_counter < _activity.length - 1) _counter++;
      if (_stopwatch == null) {
        _stopwatch = new Stopwatch();
        new Timer.periodic(new Duration(seconds: 1), _displayElapsedSeconds);
        _stopwatch.start();
        _status = updateStatusString(_stopwatch);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _status,
              style: Theme.of(context).textTheme.display1,
            ),
            RaisedButton(
              onPressed: _incrementCounter,
              child: Text(
                _activity[_counter],
                style: Theme.of(context).textTheme.display1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
