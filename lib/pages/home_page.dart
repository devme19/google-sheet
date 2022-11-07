import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsheet/controllers/sheet_controller.dart';
import 'package:gsheet/utils/state_status.dart';
import 'package:gsheet/widgets/circular_progress_indicator.dart';
import 'package:gsheet/widgets/input_name_widget.dart';
import 'package:gsheet/widgets/sheet_widget.dart';
import 'package:progress_dialog/progress_dialog.dart';
class HomePage extends GetView<SheetController> {
  HomePage({Key? key}) : super(key: key);
  int selectedDragIndex = -1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: DragTarget(
          onWillAccept: (data) {
            // print("value");
            return true;
          },
          onAccept: (int index){
            controller.deleteSheet(index);
          },
          builder: (context,__,___)=>
          FloatingActionButton.large(
            onPressed: (){},
            backgroundColor: Colors.red,
            child: Icon(Icons.delete,color: Colors.white,),
          )

        ),
        body:
            Obx(()=>
            buildView()
            )

      ),
    );
  }
  createSheet(String title)async{
    Get.back();
    ProgressDialog pr = ProgressDialog(Get.context,type: ProgressDialogType.Normal, isDismissible:false,);
    pr.style(
        message: 'Creating sheet ...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: const Padding(
          padding: EdgeInsets.all(8.0),
          child: MyCircularProgressIndicator(),
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progressTextStyle: const TextStyle(
            color: Colors.black, fontSize: 15.0,),
        messageTextStyle: const TextStyle(
            color: Colors.black, fontSize: 15.0,)
    );
    pr.show();
    // await Future.delayed(Duration(seconds: 3));
    await controller.createSheet(title);
    pr.update(
      message: "Sheet created Successfully",
      progressWidget: const Padding(
        padding: EdgeInsets.all(8.0),
        child: MyCircularProgressIndicator(),
      ),
        progressTextStyle: const TextStyle(
          color: Colors.black, fontSize: 15.0,),
        messageTextStyle: const TextStyle(
          color: Colors.black, fontSize: 15.0,)
    );
    await Future.delayed(Duration(seconds: 1));
    pr.hide();
  }
  Widget buildView(){
    if(controller.getSheetNamesStatus.value == StateStatus.LOADING){
      return const Center(child: MyCircularProgressIndicator());
    }else if(controller.getSheetNamesStatus.value == StateStatus.SUCCESS){
      return 
        Padding(
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
               index !=0? Draggable<int>(
                  onDragStarted: (){
                    controller.dragStarted.value = true;
                    selectedDragIndex = index;

                  },
                  onDragEnd: (value){
                    controller.dragStarted.value = false;
                    selectedDragIndex = -1;
                  },
                 data: index,
                 childWhenDragging: Container(),
                  feedback: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: 100,
                      height: 50,
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color:index == 0?Colors.grey.withOpacity(0.5): Colors.deepOrange,
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(controller.sheetNames[index],textAlign: TextAlign.center,style: TextStyle(fontWeight: index == 0?FontWeight.bold:FontWeight.normal,color:index == 0? Colors.black:Colors.white,fontSize: 10),),
                    ),
                  ),
                  child: InkWell(
                    onTap: (){
                      if(index == 0){
                        Get.bottomSheet(InputNameWidget(title: createSheet,));
                      }
                      else{
                        Get.to(SheetWidget(name: controller.sheetNames[index],))!.then((value) =>controller.init());
                      }
                    },
                    child:Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color:index == 0?Colors.grey.withOpacity(0.5): Colors.deepOrange,
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(controller.sheetNames[index],textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,color:index == 0? Colors.black:Colors.white,fontSize: 14,)),
                    ),
                  ),
                ):
               InkWell(
                 onTap: (){
                     Get.bottomSheet(InputNameWidget(title: createSheet,));
                 },
                 child:Container(
                   alignment: Alignment.center,
                   decoration: BoxDecoration(
                       color:index == 0?Colors.grey.withOpacity(0.5): Colors.deepOrange,
                       borderRadius: BorderRadius.circular(15)),
                   child: Text(controller.sheetNames[index],style: TextStyle(fontWeight: index == 0?FontWeight.bold:FontWeight.normal,color:index == 0? Colors.black:Colors.white),),
                 ),
               );
            }),
      );
    }
    return Container();
  }
}
