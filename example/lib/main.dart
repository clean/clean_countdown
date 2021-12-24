import 'package:flutter/material.dart';
import 'package:clean_countdown/clean_countdown.dart';

const String TITLE = 'Clean Countdown Demo';

void main() {
  runApp(DemoApp());
}

class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  CleanCountdownController controller;
  bool completed = false;
  Color ringColor = Colors.green;

  @override
  void initState() {
    controller = CleanCountdownController();
    controller.addListener(() {
      print(controller.isCounting);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: TITLE,
      home: Scaffold(
        appBar: AppBar(
          title: Text(TITLE),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: CleanCountdown(
                  size: 200,
                  showRing: false,
                  ringColor: ringColor,
                  header: Center(
                    child: Text(
                      'Header',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  footer: Center(
                    child: Text('Footer'),
                  ),
                  controller: controller,
                  duration: Duration(seconds: 3),
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    color: Colors.grey,
                    onPressed: () {
                      controller.start();
                    },
                    child: Text('start'),
                  ),
                  SizedBox(width: 10),
                  FlatButton(
                    color: Colors.grey,
                    onPressed: () {
                      controller.stop();
                    },
                    child: Text('stop'),
                  ),
                  SizedBox(width: 10),
                  FlatButton(
                    color: Colors.grey,
                    onPressed: () {
                      setState(() {
                        completed = false;
                        controller.reset();
                      });
                    },
                    child: Text('reset'),
                  ),
                ],
              ),
              FlatButton(
                color: Colors.grey,
                onPressed: () {
                  setState(() {
                    controller.controller.duration = Duration(minutes: 20);
                    ringColor = Colors.amber;
                    controller.reset();
                    controller.start();
                  });
                },
                child: Text('set new duration'),
              ),
              Divider(),
              (completed)
                  ? Text('COMPLETED')
                  : SizedBox(
                      height: 18,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
