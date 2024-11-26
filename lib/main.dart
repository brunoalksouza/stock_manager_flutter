import 'package:flutter/material.dart';
import 'package:stock_manager_flutter/pages/spash_screen.dart';
import 'package:stock_manager_flutter/utils/globals/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: backgroundColor,
      debugShowCheckedModeBanner: false,
      title: 'Estoque De Cones',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(), // Define o SplashScreen como a tela inicial
    );
  }
}
