import 'package:flutter/material.dart';
// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  String text;
  VoidCallback onTap;
  Color? color;
  Color? textColor;
  ButtonWidget({Key? key,required this.text,required this.onTap,this.color = Colors.deepOrange,this.textColor = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        primary: color,
        shape: const StadiumBorder()
      ),
        onPressed: onTap, child: FittedBox(
      child: Text(text,style: TextStyle(fontSize: 20,color: textColor),),
    ));
  }
}
