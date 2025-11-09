import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedWaveformWidget extends StatefulWidget {
  final Color color;
  final int barCount;
  final double barWidth;
  final double spacing;
  final bool isAnimating;

  const AnimatedWaveformWidget({
    super.key,
    this.color = Colors.white,
    this.barCount = 30,
    this.barWidth = 3,
    this.spacing = 1.5,
    this.isAnimating = true,
  });

  @override
  State<AnimatedWaveformWidget> createState() => _AnimatedWaveformWidgetState();
}

class _AnimatedWaveformWidgetState extends State<AnimatedWaveformWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  List<double> _heights = [];

  @override
  void initState() {
    super.initState();
    _heights = List.generate(widget.barCount, (index) => _getRandomHeight());

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300))
      ..addListener(() {
        if (widget.isAnimating) {
          setState(() {
            _heights = List.generate(widget.barCount, (index) => _getRandomHeight());
          });
        }
      });

    if (widget.isAnimating) {
      _controller.repeat();
    }
  }

  double _getRandomHeight() {
    final heights = [8.0, 12.0, 16.0, 20.0, 24.0];
    return heights[_random.nextInt(heights.length)];
  }

  @override
  void didUpdateWidget(AnimatedWaveformWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimating != oldWidget.isAnimating) {
      if (widget.isAnimating) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.barCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: widget.barWidth,
          height: _heights[index],
          margin: EdgeInsets.symmetric(horizontal: widget.spacing),
          decoration: BoxDecoration(color: widget.color, borderRadius: BorderRadius.circular(2)),
        ),
      ),
    );
  }
}

class StaticWaveformWidget extends StatelessWidget {
  final Color color;
  final int barCount;
  final double barWidth;
  final double spacing;

  const StaticWaveformWidget({
    super.key,
    this.color = Colors.white,
    this.barCount = 40,
    this.barWidth = 2,
    this.spacing = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        barCount,
        (index) => Container(
          width: barWidth,
          height: (index % 3 == 0)
              ? 16
              : (index % 2 == 0)
              ? 12
              : 8,
          margin: EdgeInsets.symmetric(horizontal: spacing),
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(1)),
        ),
      ),
    );
  }
}
