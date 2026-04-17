import 'package:flutter/material.dart';
import '../nav/main_navigation.dart';

class PrimalLogApp extends StatelessWidget {
  const PrimalLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PrimalLog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF8C00)),
        useMaterial3: true,
      ),
      home: const MainNavigation(),
    );
  }
}
