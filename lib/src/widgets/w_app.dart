import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../service/w_service_provider.dart';
import 'w_home_page.dart';

class WApp extends StatefulWidget {
  const WApp({Key? key}) : super(key: key);

  @override
  WAppState createState() => WAppState();
}

class WAppState extends State<WApp> {
  ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    platform: defaultTargetPlatform,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.windows: ZoomPageTransitionsBuilder(),
    }),
    colorScheme: ColorScheme.dark(
      primary: Colors.purple.shade300,
      secondary: Colors.pinkAccent.shade200,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.focused)) {
          return Colors.pinkAccent.shade200;
        }
        if (states.contains(MaterialState.hovered)) {
          return Colors.purple.shade400;
        }
        return Colors.purple.shade300;
      }),
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.pinkAccent.shade700,
    ),
    typography: Typography.material2018(platform: defaultTargetPlatform),
    inputDecorationTheme: InputDecorationTheme(
      focusColor: Colors.pinkAccent.shade200,
      hoverColor: Colors.purple.shade400,
    ),
    textButtonTheme: const TextButtonThemeData(),
    popupMenuTheme: const PopupMenuThemeData(),
    scrollbarTheme: const ScrollbarThemeData(
      crossAxisMargin: 0,
      interactive: true,
      isAlwaysShown: true,
      mainAxisMargin: 0,
      minThumbLength: 32,
      radius: Radius.zero,
      showTrackOnHover: true,
    ),
    dividerTheme: const DividerThemeData(
      indent: 0,
      endIndent: 0,
      thickness: 0,
      space: 0,
    ),
  );

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: const Locale('ru'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('ru')],
        color: Colors.purple.shade400,
        theme: theme,
        home: const WHomePage(),
      );

  @override
  void dispose() {
    WServiceProvider.of(context).dispose();
    super.dispose();
  }
}
