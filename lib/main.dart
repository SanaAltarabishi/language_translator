import 'package:flutter/material.dart';
import 'package:language_translator/language_transtion.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:LanguageTranstionPage() ,
    );
  }
}

