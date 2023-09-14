import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intoxianime/app/modules/home/presenter/stores/news_store.dart';
import 'package:intoxianime/app/modules/home/presenter/widgets/card_new_widget.dart';
import 'package:intoxianime/app/utils/figma_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final store = Modular.get<NewsStore>();

  @override
  void initState() {
    super.initState();
    store.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          foregroundPainter: const CircleBlurPainter(
            blurSigma: 388.67,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: FigmaColors.surface,
            ),
          ),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Intoxi Anime'),
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: LayoutBuilder(
                  builder: (context, constrains) {
                    return ListView.separated(
                      itemCount: constrains.maxHeight ~/ 1,
                      itemBuilder: (context, index) => Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 10,
                          margin: const EdgeInsets.only(left: 4),
                          child: const Divider(
                            height: 1,
                            color: Color.fromRGBO(255, 255, 255, 0.10),
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 6),
                    );
                  },
                ),
              ),
              ListView.separated(
                itemCount: 10,
                itemBuilder: (context, index) => const CardNewWidget(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 40),
              ),
            ],
          ),
        ),
      ],
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
