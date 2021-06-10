library clean_countdown;

import 'dart:ui';
import 'package:flutter/material.dart';
import 'src/timer_painter.dart';

class CleanCountdownController {
  AnimationController controller;
  final Function onCompleted;
  CleanCountdownController({
    this.onCompleted,
  });

  void start() => controller.forward();
  void stop() => controller.stop();
  void reset() => controller.reset();
}

class CleanCountdown extends StatefulWidget {
  CleanCountdown({
    Key key,

    // The controller
    @required this.controller,

    // The duration of time the widget should countdown from.
    @required this.duration,

    // The size of the widget
    @required this.size,

    // Function listener for current value.
    this.valueListener,

    // Whether or not the widget should start countdown after appearing.
    this.startOnInit = false,

    // Custom style of time string.
    this.timeStyle,

    // Custom header widget
    this.header,

    // Custom footer widget
    this.footer,

    // Color for timer circle, default is green.
    this.ringColor = Colors.green,

    // Width of the timer circle.
    this.ringStroke = 6.0,
  }) : super(key: key);

  final Duration duration;

  final double size;

  final CleanCountdownController controller;

  final void Function(Duration timeElapsed) valueListener;

  final bool startOnInit;

  final Widget header;
  final Widget footer;

  final TextStyle timeStyle;

  final Color ringColor;

  final double ringStroke;

  @override
  State<StatefulWidget> createState() {
    return _CleanCountdownState();
  }
}

class _CleanCountdownState extends State<CleanCountdown>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  CleanCountdownController _controller;

  bool running = false;

  @override
  void initState() {
    animationController = AnimationController(vsync: this);
    _controller = widget.controller;
    _controller.controller = animationController;
    animationController.duration = widget.duration;
    animationController.addListener(_animationValueListener);
    animationController.addStatusListener(_animationStatusListener);
    if (widget.startOnInit) {
      animationController.forward();
      running = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!running) {
          animationController.forward();
          running = true;
        } else if (running) {
          animationController.stop();
          running = false;
        }
      },
      child: Container(
          width: widget.size,
          height: widget.size,
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                // circle
                AnimatedBuilder(
                  animation: animationController,
                  builder: (context, _) {
                    return CustomPaint(
                      size: MediaQuery.of(context).size,
                      painter: TimerPainter(
                          animation: animationController,
                          ringColor: widget.ringColor,
                          ringStroke: widget.ringStroke),
                    );
                  },
                ),
                // countdown text
                Container(
                  height: widget.size / 3,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: AnimatedBuilder(
                        animation: animationController,
                        builder: (context, child) {
                          return Text(getText(),
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width,
                                fontFeatures: [FontFeature.tabularFigures()],
                              ).merge(widget.timeStyle));
                        }),
                  ),
                ),
                if (widget.header is Widget)
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        height: widget.size / 3, child: widget.header),
                  ),
                if (widget.footer is Widget)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: widget.size / 3,
                      child: widget.footer,
                    ),
                  ),
              ],
            ),
          )),
    );
  }

  @override
  void didUpdateWidget(CleanCountdown oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _animationValueListener() {
    if (widget.valueListener != null) {
      widget.valueListener(
          animationController.duration * animationController.value);
    }
  }

  void _animationStatusListener(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.forward:
        running = true;
        break;
      case AnimationStatus.dismissed:
        running = false;
        break;
      case AnimationStatus.completed:
        running = false;
        if (_controller.onCompleted is Function) _controller.onCompleted();
        break;
      default:
    }
  }

  String getText() {
    Duration duration =
        animationController.duration * animationController.value;

    duration = Duration(
        seconds: animationController.duration.inSeconds - duration.inSeconds);

    if (duration.inHours > 0) {
      return "${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, "0")}:${(duration.inSeconds % 60).toString().padLeft(2, "0")}";
    } else {
      return "${duration.inMinutes.toString().padLeft(2, "0")}:${(duration.inSeconds % 60).toString().padLeft(2, "0")}";
    }
  }

  @override
  void dispose() {
    animationController.stop();
    animationController.removeStatusListener(_animationStatusListener);
    animationController.dispose();
    super.dispose();
  }
}