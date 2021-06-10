# clean_countdown

An iOS style timer widget based on cupertino_timer


![Example](https://raw.githubusercontent.com/clean/clean_countdown/master/doc/example.gif)


## Usage

```
CleanCountdown(
    size: 300,
    header: Center(child: Text('Header')),
    footer: Center(child: Text('Footer')),
    duration: Duration(minutes: 1),
    controller: CleanCountdownController(onCompleted: () {
        setState({
            ...
        });
    }),
    startOnInit: true,
    timeStyle: TextStyle(
        fontWeight: FontWeight.bold),
    ringColor: Colors.red,
    ringStroke: 10,
    )
```