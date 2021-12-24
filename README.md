# clean_countdown

An iOS style timer widget based on [cupertino_timer](https://pub.dev/packages/cupertino_timer)
with some extra params added

| param | Description |
| --- | --- |
| showRing | Allow to show/hide animated ring around counter (default: true) |
| startStopOnTap | Set whether or not the widget should stop/start counter onTap (default: true) |
| controller | CleanCountdownController |
| controller.isCounting | Allows to check if counter is running |
| controller.start() | Start counting |
| controller.stop() | Stop counting |
| controller.reset() | Reset counter |
| controller.setNewDuration(Duration duration) | Set new duration |

![Example](https://raw.githubusercontent.com/clean/clean_countdown/master/doc/example.gif)


## Usage

```
CleanCountdown(
    size: 300,
    header: Center(child: Text('Header')),
    footer: Center(child: Text('Footer')),
    duration: Duration(minutes: 1),
    controller: CleanCountdownController(
        onCompleted: () {
            setState({
                ...
            });
        },
    ),
    startOnInit: true,
    timeStyle: TextStyle(
        fontWeight: FontWeight.bold),
    ringColor: Colors.red,
    ringStroke: 10,
    )
```