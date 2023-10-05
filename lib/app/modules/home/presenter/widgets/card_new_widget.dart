import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

import '../../../../utils/figma_styles.dart';
import '../../data/model/news_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CardNewWidget extends StatelessWidget {
  final NewsModel news;
  final VoidCallback onTap;
  const CardNewWidget({
    Key? key,
    required this.news,
    required this.onTap,
  }) : super(key: key);

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
                news.dateTime,
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
                  'https://corsproxy.io/?${news.urlImage}',
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                news.title,
                style: FigmaTextStyles.title.copyWith(
                  color: FigmaColors.graygray100,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                HtmlUnescape().convert(news.description),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: FigmaTextStyles.about.copyWith(
                  color: FigmaColors.graygray100,
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: onTap,
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
