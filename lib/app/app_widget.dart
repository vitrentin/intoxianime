import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intoxianime/app/utils/figma_styles.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My Smart App',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: FigmaColors.purplepurple500,
          brightness: Brightness.dark,
        ),
      ),
      routerConfig: Modular.routerConfig,
    ); //added by extension
  }
}
