import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/screens/tabs.dart';

import 'Theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        appBarTheme: ThemeData().appBarTheme.copyWith(
          foregroundColor: kDarkColorScheme.onPrimaryContainer,
          backgroundColor: kDarkColorScheme.primaryContainer,
        ),
        cardTheme: ThemeData().cardTheme.copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: ThemeData().appBarTheme.copyWith(
          foregroundColor: kColorScheme.onPrimaryContainer,
          backgroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: ThemeData().cardTheme.copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
              fontWeight: FontWeight.normal,
              color: kColorScheme.onSecondaryContainer,
              fontSize: 24),
        ),
      ),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      home: const TabsScreen(),
    );
  }
}
