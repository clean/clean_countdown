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
  late CleanCountdownController controller;
  bool completed = false;
  Color ringColor = Colors.green;
  var buttonStyles = ButtonStyle(
    foregroundColor: MaterialStateProperty.all(Colors.white),
    backgroundColor: MaterialStateProperty.all(Colors.grey),
  );

  @override
  void initState() {
    controller = CleanCountdownController();
    controller.addListener(() {
      setState(() {
        print(controller.isCounting);
      });
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
                  showRing: true,
                  ringColor: ringColor,
                  startOnInit: true,
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
                  TextButton(
                    style: buttonStyles,
                    onPressed: () {
                      controller.start();
                    },
                    child: Text('start'),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    style: buttonStyles,
                    onPressed: () {
                      controller.stop();
                    },
                    child: Text('stop'),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    style: buttonStyles,
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
              TextButton(
                style: buttonStyles,
                onPressed: () {
                  setState(() {
                    controller.controller!.duration = Duration(minutes: 20);
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
