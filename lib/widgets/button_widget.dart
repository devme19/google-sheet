import 'package:flutter/material.dart';
// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  String text;
  VoidCallback onTap;
  ButtonWidget({Key? key,required this.text,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        shape: const StadiumBorder()
      ),
        onPressed: onTap, child: FittedBox(
      child: Text(text,style: const TextStyle(fontSize: 20,color: Colors.white),),
    ));
  }
}
