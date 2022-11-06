import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsheet/controllers/sheet_controller.dart';
import 'package:gsheet/models/user_fields.dart';
import 'package:gsheet/widgets/button_widget.dart';
import 'package:uuid/uuid.dart';
class UserFormWidget extends GetView<SheetController> {
  UserFormWidget({Key? key,this.item}) : super(key: key){
    // if(item!=null){
      for(String mItem in controller.headerRow){
        if(mItem.toLowerCase() == 'id' || mItem.toLowerCase() == 'action') {
          continue;
        }
        textEditControllers.add(TextEditingController(text: item != null?item![mItem]:''));
        textFormFields.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            controller: textEditControllers.last,
            validator: (value)=> value!=null && value.isEmpty?'Enter $mItem':null,
            decoration: InputDecoration(
              labelText: mItem,
              border: const OutlineInputBorder(),
            ),
          ),
        ));
      }
    // }
  }
  final _formKey = GlobalKey<FormState>();
  Map<String,String>? item;
  List<TextEditingController> textEditControllers=[];
  List<Widget> textFormFields=[];
  // TextEditingController nameController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
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
                ...textFormFields,
                SizedBox(height: 8.0,),
                buildSubmit()
              ]
            ),
          ),
        ),
      );
  }
  Widget buildSubmit()=>ButtonWidget(text: 'Save', onTap: (){
    final form = _formKey.currentState;
    final isValid = form!.validate();
    if(isValid){
      if(item == null){
        Map<String,String> itemToSave={};
        int i =0;
        for(String mItem in controller.headerRow){
          if(mItem.toLowerCase() == 'action'){
            continue;
          }
          if(mItem.toLowerCase() == 'id'){
            itemToSave.addEntries({mItem:const Uuid().v4()}.entries);
            continue;
          }
          itemToSave.addEntries({mItem:textEditControllers[i].text}.entries);
          i++;
        }
        // Map<String,dynamic> itemToSave={
        //   'id': const Uuid().v4(),
        // };
        // final user = User(
        //     id: const Uuid().v4(),
        //     name:nameController.text,
        //     email: emailController.text
        // );
        controller.insert(itemToSave);
      }
      else{
        Map<String,String> itemToSave={};
        int i =0;
        for(String mItem in controller.headerRow){
          if(mItem.toLowerCase() == 'action'){
            continue;
          }
          if(mItem.toLowerCase() == 'id'){
            itemToSave.addEntries({mItem:item!['id']!}.entries);
            continue;
          }
          itemToSave.addEntries({mItem:textEditControllers[i].text}.entries);
          i++;
        }
        controller.updateUser(itemToSave);
      }
    }
  });
  // Widget buildName()=>TextFormField(
  //   controller: nameController,
  //   validator: (value)=> value!=null && value.isEmpty?'Enter Name':null,
  //   decoration: const InputDecoration(
  //     labelText: 'Name',
  //     border: OutlineInputBorder(),
  //   ),
  // );
  // Widget buildEmail()=>TextFormField(
  //   controller: emailController,
  //   // validator: (value)=> value!=null?'Enter Email':null,
  //   decoration: const InputDecoration(
  //       labelText: 'Email',
  //       border: OutlineInputBorder()
  //   ),
  // );
}
