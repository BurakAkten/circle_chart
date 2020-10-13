[![pub package](https://img.shields.io/pub/v/circle_chart.svg)](https://pub.dartlang.org/packages/circle_chart)

# circle_chart

This is a library for creating an animated circle chart widget and add given other widget under the chart.

<p>
<img src="https://raw.githubusercontent.com/BurakAkten/circle_chart/main/gifs/circle-chart.gif" alt="drawing"/> 
</p>

## Installation

Install the latest version [from pub](https://pub.dev/packages/circle_chart/install).

## Getting Started

Import the package:

```dart
import 'package:circle_chart/circle_chart.dart';
```
Create a CircleChart widget and use in your build method:

```dart
Widget chart = CircleChart(
      progressNumber: 4, 
      maxNumber: 10, 
      children: 
      [
          Icon(Icons.arrow_upward),
          Text('This is kind of circle chart.',),
          Text("This is kind of description",
               style: Theme.of(context).textTheme.headline4),
       ]);
```
```dart
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
              child: chart
            )
          ],
        ),
      ),
    );
  }
```