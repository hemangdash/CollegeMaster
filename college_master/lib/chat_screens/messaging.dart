import 'package:flutter/material.dart';

import 'home_screen.dart';

void main() {
  runApp(Messaging());
}

var globalcontext;

class Messaging extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    globalcontext = context;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Messaging Feature',
      theme: ThemeData(
        primaryColor: Color(0xFF68c1e7),
      ),
      home: HomeScreen(),
    );
  }
}
