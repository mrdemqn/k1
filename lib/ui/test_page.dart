import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  final String text;
  const TestPage({required this.text}) : super();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      child: Text(
        '$text',
        style: TextStyle(
          color: Colors.black,
          fontSize: 26
        ),
      ),
    );
  }
}
