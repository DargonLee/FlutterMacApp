import 'package:flutter/material.dart';

class CenterText extends StatelessWidget {
  final String title;

  const CenterText({super.key, required this.title});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$title',
        style: TextStyle(fontSize: 38.0),
      ),
    );
  }
}
