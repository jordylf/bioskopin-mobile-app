// Flutter imports:
import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme(),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF277FBF),
    ),
    useMaterial3: true,
    fontFamily: 'Poppins',
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    scrolledUnderElevation: 0.0,
    shape: Border(
      bottom: BorderSide(
        width: 1.0,
        color: Color.fromRGBO(224, 224, 224, 1),
      ),
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
    ),
    centerTitle: true,
  );
}
