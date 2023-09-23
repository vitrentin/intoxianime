import 'package:flutter/material.dart';

class TracesWidget extends StatelessWidget {
  const TracesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: LayoutBuilder(
        builder: (context, constrains) {
          return ListView.separated(
            itemCount: constrains.maxHeight ~/ 1,
            physics: const NeverScrollableScrollPhysics(),
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
            separatorBuilder: (context, index) => const SizedBox(height: 6),
          );
        },
      ),
    );
  }
}
