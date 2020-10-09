import 'package:flutter/material.dart';
import 'package:circle_chart/circle_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circle chart Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Circle chart Demo'),
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
            Container(
              child: CircleChart(progressNumber: 4, maxNumber: 10, children: [
                Icon(Icons.arrow_upward),
                Text(
                  'This is kind of circle chart.',
                ),
                Text(
                  "This is kind of description",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
