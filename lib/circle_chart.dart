library circle_chart;

import 'package:flutter/material.dart';
import 'circle_painter.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CircleChart extends StatefulWidget {
  final double progressNumber;
  final int maxNumber;
  final bool showRate;
  final double width;
  final double height;
  final TextStyle rateTextStyle;
  final Duration animationDuration;
  final Color progressColor;
  final Color backgroundColor;
  final List<Widget> children;
  CircleChart(
      {@required this.progressNumber,
      @required this.maxNumber,
      this.children,
      this.showRate = true,
      this.rateTextStyle,
      this.animationDuration = const Duration(seconds: 1),
      this.backgroundColor,
      this.progressColor,
      this.width = 128,
      this.height = 128}) {
    assert(progressNumber > 0 && maxNumber > 0 && progressNumber < maxNumber);
  }

  @override
  State<StatefulWidget> createState() => CircleChartState();
}

class CircleChartState extends State<CircleChart> with SingleTickerProviderStateMixin {
  CirclePainter _painter;
  Animation<double> _animation;
  AnimationController _controller;
  double _fraction = 0.0;

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

  double get scaledWidth => MediaQuery.of(context).size.width / 1024;
  double get scaledHeight => MediaQuery.of(context).size.height / 1024;

  TextStyle get _defaultTextStyle => TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
  AutoSizeText get rateView =>
      AutoSizeText("${widget.progressNumber} / ${widget.maxNumber}", maxLines: 1, style: widget.rateTextStyle ?? _defaultTextStyle);

  @override
  Widget build(BuildContext context) {
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
                    builder: (BuildContext context, Widget child) {
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
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: widget.children ?? []),
        ),
      ],
    );
  }
}
