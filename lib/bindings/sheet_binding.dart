import 'package:get/get.dart';
import 'package:gsheet/controllers/sheet_controller.dart';

class SheetBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SheetController());
  }

}