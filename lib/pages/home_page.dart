import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsheet/controllers/sheet_controller.dart';
import 'package:gsheet/widgets/circular_progress_indicator.dart';
import 'package:gsheet/widgets/input_new_sheet_name_widget.dart';
import 'package:gsheet/widgets/sheet_widget.dart';
import 'package:gsheet/widgets/user_form_widget.dart';
class HomePage extends GetView<SheetController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
        controller.obx((state) => Padding(
          padding: const EdgeInsets.only(left:8.0,right: 8.0,bottom: 8.0,top: 16.0),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  childAspectRatio: 4 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: controller.sheetNames.length,
              itemBuilder: (BuildContext ctx, index) {
                return
                  InkWell(
                    onTap: (){
                      if(index == 0){
                        Get.bottomSheet(InputNewSheetNameWidget());
                      }
                      else{
                        Get.to(SheetWidget(name: controller.sheetNames[index],));
                      }
                    },
                    child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color:index == 0?Colors.grey.withOpacity(0.5): Colors.deepOrange,
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(controller.sheetNames[index],style: TextStyle(fontWeight: index == 0?FontWeight.bold:FontWeight.normal,color:index == 0? Colors.black:Colors.white),),
                ),
                  );
              }),
        ),
          onLoading:const Center(child: MyCircularProgressIndicator()),
          onEmpty: const Center(child: Text('No data found')),
          onError:(error)=> const Center(child: Text('No data found')),
        )

      ),
    );
  }
}
