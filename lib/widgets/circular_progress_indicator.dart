import 'package:flutter/material.dart';
class MyCircularProgressIndicator extends StatelessWidget {
  const MyCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),strokeWidth: 7.0,);
  }
}
