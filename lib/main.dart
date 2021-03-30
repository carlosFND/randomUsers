import 'package:api_personas/src/pages/api_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ramdom Users: Carlos Soto Zepeda',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ApiPage(),
    );
  }
}
