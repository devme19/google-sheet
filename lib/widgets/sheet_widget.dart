import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsheet/controllers/sheet_controller.dart';
import 'package:gsheet/models/user_fields.dart';
import 'package:gsheet/widgets/user_form_widget.dart';

// ignore: must_be_immutable
class SheetWidget extends GetView<SheetController> {
  SheetWidget({Key? key,this.name}) : super(key: key){
    // controller.getAllRows();
    if(name != null) {
      controller.createSheet(name!);
    }
  }
  String? name;
  @override
  Widget build(BuildContext context) {
    return 
     SafeArea(
       child: Scaffold(
         body:controller.obx((state) =>
             SingleChildScrollView(
                 scrollDirection: Axis.horizontal,
                 child: DataTable(columns: buildHeader(UserFields.getFields()), rows: buildRows(state!))),
           onLoading:const Center(child: CircularProgressIndicator()),
           onEmpty: const Center(child: Text('No data found')),
           onError:(error)=> const Center(child: Text('No data found')),
         ),
       ),
     );
      // DataTable(columns: buildHeader(UserFields.getFields()), rows: buildRows(users!));
  }


  List<DataColumn> buildHeader(List<String> titles)=>
    titles.map((e) => DataColumn(label: Expanded(child: Text(e,style: TextStyle(fontWeight: FontWeight.bold)),))).toList();

  List<DataRow> buildRows(List<User> users)=>
      users.map((user) => DataRow(cells: buildCells(user))).toList();

  List<DataCell> buildCells(User user){
    List<DataCell> cells = [];
    cells.add(DataCell(
        Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: (){
            print('Delete:'+user.name);
          },
            child: Icon(Icons.delete,size: 30,)),
        SizedBox(width: 20.0,),
        InkWell(
            onTap: (){
              print('Edit:'+user.name);
              Get.bottomSheet(UserFormWidget(user: user,));
            },
            child: Icon(Icons.edit,size: 30)),
      ],
    )));
    cells.add(DataCell(Text(user.id.toString())));
    cells.add(DataCell(Text(user.name)));
    cells.add(DataCell(Text(user.email)));
    return cells;
  }
}
