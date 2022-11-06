import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsheet/controllers/sheet_controller.dart';
import 'package:gsheet/models/user_fields.dart';
import 'package:gsheet/widgets/button_widget.dart';
import 'package:gsheet/widgets/circular_progress_indicator.dart';
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
         floatingActionButton: FloatingActionButton(
           child: Icon(Icons.add),
           backgroundColor: Colors.deepOrange,
           onPressed: () {
           Get.bottomSheet(UserFormWidget());
         },),
         body:
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: controller.obx((state) =>
               SingleChildScrollView(
                   scrollDirection: Axis.horizontal,
                   child: DataTable(
                     dataRowColor: MaterialStateColor.resolveWith((states) => Colors.grey.shade300),
                       headingRowColor:
                       MaterialStateColor.resolveWith((states) => Colors.deepOrange),
                       columns: buildHeader(controller.headerRow), rows: buildRows(state!))),
             onLoading:const Center(child: MyCircularProgressIndicator()),
             onEmpty: const Center(child: Text('No data found')),
             onError:(error)=> const Center(child: Text('No data found')),
           ),
         ),
       ),
     );
      // DataTable(columns: buildHeader(UserFields.getFields()), rows: buildRows(users!));
  }


  List<DataColumn> buildHeader(List<String> titles)=>
    titles.map((e) => DataColumn(

        label: Expanded(child: Container(
          // color: Colors.blue,
            child: Center(child: Text(e.toLowerCase() == 'id'?'Action':e,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white.withOpacity(0.9),fontSize: 19)))),))).toList();

  List<DataRow> buildRows(List<Map<String,String>> items)=>
      items.map((item) => DataRow(
        color: MaterialStateColor.resolveWith((states) => items.indexOf(item)%2 == 0?Colors.white:Colors.grey.shade200),
          cells: buildCells(item))).toList();

  List<DataCell> buildCells(Map<String,String> item){
    List<DataCell> cells = [];
    cells.add(
        DataCell(
        Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: (){

            Get.defaultDialog(
              content: Text("Are you sure to delete this item?"),
              title: 'Delete item',
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width:100,
                        child: ButtonWidget(text: "No",color: Colors.grey.shade100,textColor: Colors.black87, onTap: (){
                          Get.back();
                        }),
                      ),
                      SizedBox(
                        width:100,
                        child: ButtonWidget(text: "Yes", onTap: (){
                          Get.back();
                          controller.deleteById(item["id"]!);
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            );
            // print('Delete:'+user.name);
          },
            child: Icon(Icons.delete,size: 30,)),
        SizedBox(width: 20.0,),
        InkWell(
            onTap: (){
              // print('Edit:'+user.name);
              Get.bottomSheet(UserFormWidget(item: item,));
            },
            child: Icon(Icons.edit,size: 30)),
      ],
    )));
    // cells.add(DataCell(Text(user.id.toString())));
    for(var mItem in item.keys.toList()){
      if(mItem == 'id') {
        continue;
      }
      cells.add(DataCell(Text(item[mItem]!)));
      print(item[mItem]);
    }
    // item.keys.toList().map((key) {
    //   cells.add(DataCell(Text(item[key])));
    //   print(item[key]);
    // });
    // cells.add(DataCell(Text(user.name)));
    // cells.add(DataCell(Text(user.email)));
    return cells;
  }
}
