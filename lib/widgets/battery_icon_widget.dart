import 'package:flutter/material.dart';

/// A simple battery glyph whose fill level visually represents
/// [percentage], drawn with a [CustomPainter] so it scales cleanly at any
/// size without needing an image asset.
class BatteryIconWidget extends StatelessWidget {
  final int percentage;
  final Color color;
  final double width;
  final double height;

  const BatteryIconWidget({
    super.key,
    required this.percentage,
    required this.color,
    this.width = 40,
    this.height = 66,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _BatteryPainter(
          percentage: percentage.clamp(0, 100),
          color: color,
        ),
      ),
    );
  }
}

class _BatteryPainter extends CustomPainter {
  final int percentage;
  final Color color;

  const _BatteryPainter({required this.percentage, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final bodyTop = size.height * 0.1;
    final bodyRect = Rect.fromLTWH(
      0,
      bodyTop,
      size.width,
      size.height - bodyTop,
    );
    const bodyRadius = Radius.circular(8);

    // Terminal "nub" at the top of the battery.
    final nubWidth = size.width * 0.4;
    final nubRect = Rect.fromLTWH(
      (size.width - nubWidth) / 2,
      0,
      nubWidth,
      bodyTop + 2,
    );
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        nubRect,
        topLeft: const Radius.circular(3),
        topRight: const Radius.circular(3),
      ),
      Paint()..color = color,
    );

    // Filled portion, clipped to the rounded battery body.
    final clampedPercent = percentage.clamp(0, 100);
    final maxFillHeight = bodyRect.height - 8;
    final fillHeight = maxFillHeight * (clampedPercent / 100);
    final fillRect = Rect.fromLTWH(
      4,
      bodyRect.bottom - 4 - fillHeight,
      size.width - 8,
      fillHeight,
    );

    canvas.save();
    canvas.clipRRect(RRect.fromRectAndRadius(bodyRect, bodyRadius));
    if (fillHeight > 0) {
      canvas.drawRect(fillRect, Paint()..color = color);
    }
    canvas.restore();

    // Battery body outline, drawn on top of the fill.
    canvas.drawRRect(
      RRect.fromRectAndRadius(bodyRect, bodyRadius),
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
  }

  @override
  bool shouldRepaint(covariant _BatteryPainter oldDelegate) {
    return oldDelegate.percentage != percentage || oldDelegate.color != color;
  }
}
