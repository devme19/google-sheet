import 'package:flutter/material.dart';
import 'package:gsheet/widgets/button_widget.dart';

class InputNewSheetNameWidget extends StatelessWidget {
  InputNewSheetNameWidget({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
              buildName(),
              const SizedBox(height: 16.0,),
              buildSubmit(),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildName()=>TextFormField(
    controller: nameController,
    validator: (value)=> value!=null && value.isEmpty?'Enter Name':null,
    decoration: const InputDecoration(
      labelText: 'Name',
      border: OutlineInputBorder(),
    ),
  );
  Widget buildSubmit()=>ButtonWidget(text: 'Create', onTap: (){
    final form = _formKey.currentState;
    final isValid = form!.validate();
    if(isValid){

    }

  });
}
