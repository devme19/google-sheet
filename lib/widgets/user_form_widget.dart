import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsheet/controllers/sheet_controller.dart';
import 'package:gsheet/models/user_fields.dart';
import 'package:gsheet/widgets/button_widget.dart';

class UserFormWidget extends GetView<SheetController> {
  UserFormWidget({Key? key,this.user}) : super(key: key){
    if(user!=null){
      nameController.text = user!.name;
      emailController.text = user!.email;
    }
  }
  final _formKey = GlobalKey<FormState>();
  User? user;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
      Container(
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
                buildEmail(),
                const SizedBox(height: 16.0,),
                buildSubmit(),
              ],
            ),
          ),
        ),
      );
  }
  Widget buildSubmit()=>ButtonWidget(text: 'Save', onTap: (){
    final form = _formKey.currentState;
    final isValid = form!.validate();
    if(isValid){
      final user = User(
        name:nameController.text,
        email: emailController.text
      );
      controller.insert(user);
      // Get.back();
    }

  });
  Widget buildName()=>TextFormField(
    controller: nameController,
    validator: (value)=> value!=null && value.isEmpty?'Enter Name':null,
    decoration: const InputDecoration(
      labelText: 'Name',
      border: OutlineInputBorder(),
    ),
  );
  Widget buildEmail()=>TextFormField(
    controller: emailController,
    // validator: (value)=> value!=null?'Enter Email':null,
    decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder()
    ),
  );
}
