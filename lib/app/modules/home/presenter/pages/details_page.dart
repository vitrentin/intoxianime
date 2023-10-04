import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart' as dom;
import 'package:flutter_html_audio/flutter_html_audio.dart';
import 'package:flutter_html_iframe/flutter_html_iframe.dart';
import 'package:flutter_html_svg/flutter_html_svg.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:flutter_html_video/flutter_html_video.dart';
import 'package:html/dom.dart' as html;
import '../../../../utils/figma_styles.dart';
import '../../data/model/news_model.dart';

class DetailsPage extends StatefulWidget {
  final NewsModel news;
  const DetailsPage({super.key, required this.news});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  NewsModel get news => widget.news;

  html.Document get document {
    final doc = html.Document.html(news.aboutAnime);

    return doc;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width - 64;
    final container = Directionality(
      textDirection: TextDirection.ltr,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            width: width,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              color: Color.fromARGB(202, 245, 245, 245),
              boxShadow: [BoxShadow()],
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        news.dateTime,
                        style: FigmaTextStyles.label
                            .copyWith(color: const Color(0xff2E0505)),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        news.title,
                        style: FigmaTextStyles.about2
                            .copyWith(color: const Color(0xff2E0505)),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'By: ${news.author}',
                        style: FigmaTextStyles.label
                            .copyWith(color: const Color(0xff2E0505)),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
    final size = MeasureUtil.measureWidget(container);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.network(
                news.urlImage,
                height: 400,
                width: double.infinity,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
            Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(top: 52, left: 16),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      Navigator.of(context).maybePop();
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        color: FigmaColors.purplepurple500,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 1),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: FigmaColors.graygray50,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 400 - 32),
                child: Stack(
                  fit: StackFit.passthrough,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        minHeight: max(
                          MediaQuery.sizeOf(context).height + 32 - 400,
                          400,
                        ),
                      ),
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(32),
                          topLeft: Radius.circular(32),
                        ),
                        color: Color(0xff09090A),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: size.height / 2 + 32,
                          left: 16,
                          right: 16,
                          bottom: 20,
                        ),
                        child: dom.Html.fromDom(
                          document: document,
                          extensions: const [
                            AudioHtmlExtension(),
                            IframeHtmlExtension(),
                            SvgHtmlExtension(),
                            TableHtmlExtension(),
                            VideoHtmlExtension(),
                          ],
                          style: {
                            '*': dom.Style(
                              direction: TextDirection.ltr,
                              alignment: Alignment.center,
                              verticalAlign: dom.VerticalAlign.middle,
                            ),
                            'img': dom.Style(
                              // width: Width.auto(),
                              width: dom.Width(300),
                              height: dom.Height(400),
                            ),
                            'iframe': dom.Style(
                              direction: TextDirection.ltr,
                              verticalAlign: dom.VerticalAlign.middle,
                              alignment: Alignment.center,
                              textAlign: TextAlign.center,
                              width: dom.Width(
                                MediaQuery.sizeOf(context).width - 52,
                              ),
                            ),
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: FractionalTranslation(
                        translation: const Offset(0, -0.5),
                        child: container,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MeasureUtil {
  static Size measureWidget(
    Widget widget, [
    BoxConstraints constraints = const BoxConstraints(),
  ]) {
    final pipelineOwner = PipelineOwner();
    final rootView = pipelineOwner.rootNode = _MeasurementView(constraints);
    final buildOwner = BuildOwner(focusManager: FocusManager());
    final element = RenderObjectToWidgetAdapter<RenderBox>(
      container: rootView,
      debugShortDescription: '[root]',
      child: widget,
    ).attachToRenderTree(buildOwner);
    try {
      rootView.scheduleInitialLayout();
      pipelineOwner.flushLayout();
      return rootView.size;
    } finally {
      // Clean up.
      element
          .update(RenderObjectToWidgetAdapter<RenderBox>(container: rootView));
      buildOwner.finalizeTree();
    }
  }
}

class _MeasurementView extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  final BoxConstraints boxConstraints;
  _MeasurementView(this.boxConstraints);

  @override
  void performLayout() {
    // ignore: prefer_asserts_with_message
    assert(child != null);
    child!.layout(boxConstraints, parentUsesSize: true);
    size = child!.size;
  }

  @override
  void debugAssertDoesMeetConstraints() => true;
}
