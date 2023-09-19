import 'package:flutter/material.dart';
import 'package:intoxianime/app/utils/figma_styles.dart';

class CardNewWidget extends StatelessWidget {
  const CardNewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            height: 1,
            width: 20,
            color: FigmaColors.graygray50,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '13 de Abril de 2022',
                style: FigmaTextStyles.label,
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                height: 120,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  'https://picsum.photos/500/800',
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '''
At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque lorem ipsun dolor, lorem ipsum doooolor aaa''',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: FigmaTextStyles.about.copyWith(
                  color: FigmaColors.graygray100,
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {},
                splashFactory: NoSplash.splashFactory,
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Ler mais',
                      style: FigmaTextStyles.more
                          .copyWith(color: FigmaColors.graygray100),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: FigmaColors.graygray200,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 32),
      ],
    );
  }
}
