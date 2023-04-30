import 'package:flutter/material.dart';
import 'package:tictacotoe/firstscreen.dart';
import 'dart:math';

import 'package:tictacotoe/gamingscreen.dart';

void main() {
  runApp((MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: FirstScreen());
  }
}
