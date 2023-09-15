import 'package:flutter/material.dart';

import '../../../../utils/figma_styles.dart';

class BackgroundWithCircleBlurWidget extends StatelessWidget {
  const BackgroundWithCircleBlurWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: const CircleBlurPainter(
        blurSigma: 388.67,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: FigmaColors.surface,
        ),
      ),
    );
  }
}

class CircleBlurPainter extends CustomPainter {
  const CircleBlurPainter({
    required this.blurSigma,
  });
  final double blurSigma;

  @override
  void paint(Canvas canvas, Size size) {
    final line = Paint()
      ..color = const Color(0xff633BBC).withOpacity(1)
      ..maskFilter = MaskFilter.blur(
        BlurStyle.normal,
        blurSigma,
      );
    final center = Offset(0, size.height / 2);
    final rect = Rect.fromCenter(
      center: center,
      width: size.width,
      height: size.width * 0.53,
    );
    canvas.drawOval(rect, line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
