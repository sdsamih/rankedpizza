import 'package:flutter/material.dart';
import 'home.dart'; // Importando HomePage

void main() {
  runApp(MyApp()); // Remova o 'const' aqui
}

class MyApp extends StatelessWidget {
  MyApp({super.key}); // Construtor sem 'const'

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ranked Pizza',
      theme: ThemeData(primarySwatch: Colors.red),
      home:  HomePage(), // 'HomePage' pode manter 'const' se o construtor dela for const
    );
  }
}
