import 'package:flutter/material.dart';
import 'home.dart'; 

void main() {
  runApp(MyApp()); 
}

class MyApp extends StatelessWidget {
  MyApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ranked Pizza',
      theme: ThemeData(primarySwatch: Colors.red),
      home:  HomePage(),
    );
  }
}
