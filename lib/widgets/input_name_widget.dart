import 'package:flutter/material.dart';
import 'package:gsheet/widgets/button_widget.dart';
import 'package:gsheet/widgets/my_text_field_widget.dart';

class InputNameWidget extends StatefulWidget {
  InputNameWidget({Key? key,this.title}) : super(key: key);
  ValueChanged<String>? title;

  @override
  State<InputNameWidget> createState() => _InputNameWidgetState();
}

class _InputNameWidgetState extends State<InputNameWidget> {
  TextEditingController nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  FocusNode myFocusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    // myFocusNode.addListener(() {
    //   print('1:  ${focusNode.hasFocus}');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // buildName(),
              MyTextFieldWidget(labelText: 'Name', controller: nameController,textAlign: TextAlign.center),
              const SizedBox(height: 16.0,),
              buildSubmit(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget buildName()=>
  //     TextFormField(
  //   controller: nameController,
  //   focusNode: myFocusNode,
  //   textAlign: TextAlign.center,
  //   validator: (value)=> value!=null && value.isEmpty?'Enter Name':null,
  //   decoration: InputDecoration(
  //       filled: true,
  //       fillColor: Colors.white,
  //       labelText: 'Name',
  //       labelStyle: TextStyle(
  //           color:myFocusNode.hasFocus ?
  //           Colors.deepOrangeAccent:
  //           Colors.grey,
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.elliptical(50, 50)),
  //           borderSide: BorderSide(color: Colors.deepOrangeAccent)
  //
  //       ),
  //       border:OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.elliptical(50, 50)),
  //           borderSide:BorderSide(color: Colors.white)
  //       ),
  //     enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.all(Radius.elliptical(50, 50)),
  //         borderSide:BorderSide(color: Colors.grey)
  //     ),
  //   ),
  // );

  Widget buildSubmit()=>ButtonWidget(text: 'Create', onTap: (){
    final form = _formKey.currentState;
    final isValid = form!.validate();
    if(isValid){
      if(widget.title!=null){
        widget.title!(nameController.text);
      }
    }

  });
}
