import 'package:flutter/material.dart';

class MyTextFieldWidget extends StatefulWidget {
  MyTextFieldWidget({Key? key,required this.labelText,required this.controller,this.textAlign,this.textInputAction}) : super(key: key);
  String labelText;
  TextEditingController controller;
  TextAlign? textAlign;
  TextInputAction? textInputAction;

  @override
  _MyTextFieldWidgetState createState() => _MyTextFieldWidgetState();
}

class _MyTextFieldWidgetState extends State<MyTextFieldWidget> {
  FocusNode myFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: myFocusNode,
      textAlign: widget.textAlign??TextAlign.end,
      textInputAction: widget.textInputAction??TextInputAction.done,
      validator: (value)=> value!=null && value.isEmpty?'Enter ${widget.labelText}':null,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color:
          myFocusNode.hasFocus ?
          Colors.deepOrangeAccent:
          Colors.grey,
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.elliptical(50, 50)),
            borderSide: BorderSide(color: Colors.deepOrangeAccent)

        ),
        border:const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.elliptical(50, 50)),
            borderSide:BorderSide(color: Colors.white)
        ),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.elliptical(50, 50)),
            borderSide:BorderSide(color: Colors.grey)
        ),
      ),
    );
  }
}
