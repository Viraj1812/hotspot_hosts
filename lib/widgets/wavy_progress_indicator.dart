import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:hotspot_hosts/config/assets/colors.gen.dart';

class WavyProgressIndicator extends StatelessWidget {
  const WavyProgressIndicator({required this.progress, super.key});

  final double progress; // 0.0 to 1.0

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 4),
      painter: WavyProgressPainter(progress: progress),
    );
  }
}

class WavyProgressPainter extends CustomPainter {
  WavyProgressPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final activePaint = Paint()
      ..color = AppColors.purple
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final inactivePaint = Paint()
      ..color = AppColors.white.withValues(alpha: 0.16)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final waveHeight = 2.5;
    final waveLength = size.width / 15; // 3 waves total
    final y = size.height / 2;

    // Draw active progress (wavy line)
    final activePath = Path();
    activePath.moveTo(0, y);
    for (double x = 0; x <= size.width * progress; x += 2) {
      final normalizedX = (x / waveLength) * (2 * math.pi); // Convert to radians
      final waveY = y + (waveHeight * math.sin(normalizedX));
      activePath.lineTo(x, waveY);
    }
    canvas.drawPath(activePath, activePaint);

    // Draw inactive progress
    if (progress < 1.0) {
      final inactivePath = Path();
      final startX = size.width * progress;
      inactivePath.moveTo(startX, y);
      for (double x = startX; x <= size.width; x += 2) {
        final normalizedX = ((x - startX) / waveLength) * (2 * math.pi);
        final waveY = y + (waveHeight * math.sin(normalizedX));
        inactivePath.lineTo(x, waveY);
      }
      canvas.drawPath(inactivePath, inactivePaint);
    }
  }

  @override
  bool shouldRepaint(covariant WavyProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
