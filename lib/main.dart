import 'package:flutter/material.dart';
import 'package:every_mart/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
                    primarySwatch: Colors.green,
        ).copyWith(primary: const Color(0xFF2E8B57), secondary: const Color(0xFFFF8C00), ),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

