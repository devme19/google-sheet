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
      child: Obx(()=>
          Scaffold(
              floatingActionButton:
              controller.getSheetNamesStatus.value == StateStatus.SUCCESS? DragTarget(
                  onWillAccept: (data) {
                    // print("value");
                    controller.itemWidth.value = 60;
                    controller.itemHeight.value = 60;
                    controller.itemColor.value = Colors.red;

                    return true;
                  },
                  onAccept: (int index){
                    controller.deleteSheet(index);

                    controller.itemColor.value = Colors.green;
                  },
                  builder: (context,__,___)=>
                      const FloatingActionButton.large(
                        onPressed: null,
                        heroTag: "btn1",
                        backgroundColor: Colors.red,
                        child: Icon(Icons.delete,color: Colors.white,),
                      )

              ):Container(),

              body:
              buildView()

          )),
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
                    // Future.delayed(Duration(milliseconds: 400)).then((value) {
                    //
                    // });

                  },

                  onDragEnd: (value){
                    controller.dragStarted.value = false;
                    selectedDragIndex = -1;
                    controller.itemWidth.value = 120;
                    controller.itemHeight.value = 120;
                    controller.itemColor.value = Colors.green;
                  },
                 data: index,
                 childWhenDragging: Container(),
                  feedback:
                  Obx(()=>Material(
                    color: Colors.transparent,
                    child: AnimatedContainer(
                      width: controller.itemWidth.value,
                      height: controller.itemHeight.value,
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color:index == 0?Colors.grey.withOpacity(0.5): controller.itemColor.value,
                          // borderRadius: BorderRadius.circular(15),
                          shape: BoxShape.circle,
                        border: Border.all(color: Colors.green.withOpacity(0.3),width: 4)
                      ),
                      duration: Duration(milliseconds: 300),
                      child: Text(controller.sheetNames[index],textAlign: TextAlign.center,style: TextStyle(fontWeight: index == 0?FontWeight.bold:FontWeight.normal,color:index == 0? Colors.black:Colors.white,fontSize: 10),),
                    ),
                  )),
                  child: InkWell(
                    onTap: (){
                      if(index == 0){
                        Get.bottomSheet(InputNameWidget(title: createSheet,));
                      }
                      else{
                        Get.to(SheetWidget(name: controller.sheetNames[index],));
                      }
                    },
                    child:Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color:index == 0?Colors.grey.withOpacity(0.5): controller.itemColor.value,
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
