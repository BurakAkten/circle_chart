library circle_chart;

import 'package:flutter/material.dart';
import 'circle_painter.dart';
import 'package:auto_size_text/auto_size_text.dart';

/// This [CircleChart] chart widget kind of StatefulWidget widget that create animated
/// circle chart.

class CircleChart extends StatefulWidget {
  final double progressNumber;
  final int maxNumber;
  final bool showRate;
  final double width;
  final double height;
  final TextStyle? rateTextStyle;
  final Duration animationDuration;
  final Color? progressColor;
  final Color? backgroundColor;
  final List<Widget> children;

  /// The [CirclePainter] constructor has two required parameters that are [progressNumber] and
  /// [maxNumber]. Also have some default parameter and optional parameters.
  CircleChart({
    required this.progressNumber,
    required this.maxNumber,
    this.children = const [],
    this.showRate = true,
    this.rateTextStyle,
    this.animationDuration = const Duration(seconds: 1),
    this.backgroundColor,
    this.progressColor,
    this.width = 128,
    this.height = 128,
  }) {
    assert(progressNumber > 0 && maxNumber > 0 && progressNumber < maxNumber);
  }

  @override
  State<StatefulWidget> createState() => CircleChartState();
}

/// This [CircleChartState] class k'nd of class that handle animation and state of [CircleChart] widget.
class CircleChartState extends State<CircleChart> with SingleTickerProviderStateMixin {
  late CirclePainter _painter;
  late Animation<double> _animation;
  late AnimationController _controller;
  double _fraction = 0.0;

  /// Animation controller and animation initialized in this method called [initState]
  initState() {
    super.initState();
    _controller = AnimationController(duration: widget.animationDuration, vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _fraction = _animation.value;
        });
      });
    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// [scaledHeight] and [scaledWidth] get with and height values
  double get scaledWidth => MediaQuery.of(context).size.width / 1024;
  double get scaledHeight => MediaQuery.of(context).size.height / 1024;

  TextStyle get _defaultTextStyle => TextStyle(color: Colors.black, fontWeight: FontWeight.bold);

  /// [rateView] gets the view that show [widget.progressNumber] / [widget.maxNumber]
  AutoSizeText get rateView =>
      AutoSizeText("${widget.progressNumber} / ${widget.maxNumber}", maxLines: 1, style: widget.rateTextStyle ?? _defaultTextStyle);

  @override
  Widget build(BuildContext context) {
    /// [CirclePainter] object created here for using as painter.
    _painter = CirclePainter(
        animation: _controller,
        fraction: _fraction,
        progressNumber: widget.progressNumber,
        maxNumber: widget.maxNumber,
        backgroundColor: widget.backgroundColor,
        progressColor: widget.progressColor);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: widget.width * scaledWidth,
          height: widget.height * scaledHeight,
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (BuildContext context, Widget? child) {
                      return CustomPaint(painter: _painter);
                    },
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: rateView,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: widget.children),
        ),
      ],
    );
  }
}
