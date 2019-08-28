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
  String _status = 'Press button to';

  var _activity = <String>[
    'BEGIN',
    'Toilet',
    'Washing',
    'Dental',
    'Dry',
    'Medical',
    'Dressing',
    'Bedding',
    'Entertainment',
    'Reflection',
    'Extra',
    'DONE'
  ];
  var _durations = <Duration>[];

  GlobalKey<AnimatedListState> _completedTasksKey =
      GlobalKey<AnimatedListState>();

  Widget completedTasksItemBuilder(
      BuildContext context, int index, Animation<double> animation) {
    Duration d = index == 0
        ? _durations[index] - Duration.zero
        : _durations[index] - _durations[index - 1];
    int _minutes = d.inMinutes;
    int _secondsThisMinute = d.inSeconds % Duration.secondsPerMinute;
    String _took = '${_minutes}\' ${_secondsThisMinute}\"';
    return new Text(
      '${_activity[index + 1]} took ${_took}',
      style: Theme.of(context).textTheme.display1,
    );
  }

  String updateStatusString(Stopwatch _s) {
    int _secondsThisMinute = _s.elapsed.inSeconds % Duration.secondsPerMinute;
    return 'Time Taken:\t${_s.elapsed.inMinutes}\' ${_secondsThisMinute}\"';
  }

  void _displayElapsedSeconds(Timer timer) {
    setState(() {
      _status = updateStatusString(_stopwatch);
    });
  }

  void _pressDoneButton() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      if (_counter < _activity.length - 1) {
        _counter++;
      } else {
        _stopwatch.stop();
        _status = updateStatusString(_stopwatch);
        return;
      }
      if (_stopwatch == null) {
        _stopwatch = new Stopwatch();
        new Timer.periodic(new Duration(seconds: 1), _displayElapsedSeconds);
        _stopwatch.start();
        _status = updateStatusString(_stopwatch);
      } else {
        _completedTasksKey.currentState.insertItem(0);
        _durations.add(_stopwatch.elapsed);
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              _status,
              style: Theme.of(context).textTheme.display2,
            ),
            RaisedButton(
              onPressed: _pressDoneButton,
              child: Text(
                _activity[_counter],
                style: Theme.of(context).textTheme.display3,
              ),
            ),
            AnimatedList(
              key: _completedTasksKey,
              itemBuilder: completedTasksItemBuilder,
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
