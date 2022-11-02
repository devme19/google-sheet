import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsheet/bindings/sheet_binding.dart';
import 'package:gsheet/pages/home_page.dart';
import 'package:gsheet/widgets/sheet_widget.dart';
import 'package:get/get.dart';
import 'package:gsheet/widgets/user_form_widget.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // SheetsApi.init();
  SheetBinding().dependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      // initialBinding: SheetBinding(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:HomePage()
      // SafeArea(
      //   child: Scaffold(
      //     floatingActionButton: FloatingActionButton(
      //       child: const Icon(Icons.add),
      //       onPressed: ()=> Get.bottomSheet(UserFormWidget()),
      //     ),
      //     body: Padding(
      //       padding: const EdgeInsets.all(32.0),
      //       child: Center(
      //         child: SheetWidget()
      //
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
