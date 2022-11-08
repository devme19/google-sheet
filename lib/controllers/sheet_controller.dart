import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsheet/models/user_fields.dart';
import 'package:gsheet/utils/state_status.dart';
import 'package:gsheets/gsheets.dart';

class SheetController extends GetxController with StateMixin{
  final _spreadSheetId='123E5iCIhQ5viigvWOevw-0ldA7nvC1nJUScuq-kabXU';
  final _credentials = r'''
  {
    "type": "service_account",
    "project_id": "uplifted-kit-367109",
    "private_key_id": "cb94dbb3b722f2b9acebd108864c485fecc8aae3",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCXy8EvWV8ylFTi\nY6wwwHd2bMcRWddoy40GFJEgstpijKl66T2hLvCEzss6ii0b61+G1mrWiAtY1U5G\n3q1ltdMkengfh9tO6r3iVaN4MxlzdoVM8Gyj+SngkKphWLArHR08M0/rbNjkaFcg\nL6wpOJqN8jECDnZb8Yu73mvZFYVZPUtrZLdkXFV+6eiu19h5rK4KqljZMUIvx4n6\nZvtAdyob9ktmWVVtYZzvnH0ZFPgQSwMhPxJr/PDP/SrurF7pvcKvPucHPW86w9DL\nTBUrZXkJ78MnVrcgXVjPu+drQetaBryP22HAK2iVC0+xRtAw1N1mp2tI66ovXi2f\nbpnegl3lAgMBAAECggEAFwXDFp8w9kG+FW9gRIKke8nSxXnBVzZsJ1cY4y3ikR4x\nbvVk21ynA8A+MvJAa410OcYCgpLerwn8ayOchqJ1qYDeVYtBmBi3/6sqdcbA85yv\nFLTFssxNwtleJhE7+EYG/ZmbY6MTdaJc+II9KSwEcPFMko8b+iT1TbirKyEoTkOR\nrla9gaVGFotzlvhDg1PwqduJ8dE1WHS7LF2jhANhGwy+I/EOR7RIrOiGVZyx7tG3\nVVwJVRn5dnJYJCrs/nVt2G9hLsWIZT3OXRvQ3NXr75cDAeUQb56X5i/ZJ5z/5WE+\nxYMu58mNMdjPOXnf1zAx5jQJHm+h4CWjMODSEVHFvwKBgQDH++Xf0A9xvLcwJTvt\nDVvhgyTapTNGh3btLESqFlpxO7cOiViRUXIVck+2d03j/Tr8FienQ6IPQ8p5PPvM\n7R3qujsmyeKvb5gq3qGFtTxA19y+aP9FaLZZAOn+qgiRQGhD6xlW0a+jVk6QMJ50\ngcxcps9IJfLDcsvKZeZzgUS8hwKBgQDCUHirUFJOGefW0Z14O1BQabEnGWefE7lW\nYmW2Vau7a0Ac4ST9LgFihH5GZPyR/6k2zc+XdhElsWkLHFf0xvhfahzDub7R8ITB\n8ZtIvj3oGO4iikWUM+2HWnLJjtSaRHIlujnUxQgv3nGVrGd5JmteoqGZ9k6EAaEO\nD68cI+N5MwKBgDu20rgW11W95PFCXPd2orXew/VpmLr5niBJtKMZE552Fz4G8uRJ\nbohK3tR8IUzvg1pcfzCpuE1Yj6/N7t4M+37oZts5My/xYX2DhrV3HWu7SRWuInMm\nRjSjWjuJqA8/LSMCo0lSSWC7V7AkZFwjmdMcmA5SDoAf2gwwizR4J/8nAoGBAJtA\nRElMEZaJKC0AqXoImfDFoV8F8z6sOaaFU5LM/DrwQ/dPA4itmzmldma0BQB5bi91\nXOk80hJ1nuHbsYLG/mbtlzHiVE3Uh52VdmY2aavpT0qVg2YX3y4H3DKiRcdD7Jes\nJMyU6Cem6MWXS80GHz8rXUZv/ueFjbJ4YYZwPiz1AoGAUaOkmY6eUCNRrNp+nD6W\nJBkik8xI4/LsuyqH7Bgp/w7iZfbx/ZFrKytqfI9uB7KkZL5HRpngMpSsg1tuosKS\nWaLkaMKcVjYL/OhGb9/RBtnGfHoIqTRL/E5hSzpBLtYtg0/vqIcL/5ZR6mOXTLtL\nr6Dsd/mpeD8oT43jxuMDBXI=\n-----END PRIVATE KEY-----\n",
    "client_email": "gsheet@uplifted-kit-367109.iam.gserviceaccount.com",
    "client_id": "106988779838805799266",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheet%40uplifted-kit-367109.iam.gserviceaccount.com"
  }
  ''';

  RxDouble itemWidth = (120.0).obs;
  RxDouble itemHeight = (120.0).obs;
  Rx<Color> itemColor = Colors.green.obs;
   var _gsheets;
   List<Map<String,String>> items=[];
   // List<User> users=[];
   RxList sheetNames = ['New sheet'].obs;
   var getSheetNamesStatus = StateStatus.INITIAL.obs;
   List<String> headerRow=[];
   int delay = 200;
  RxBool dragStarted = false.obs;
  @override
  void onInit() async{
    super.onInit();
    await init();
    // getAllRows();
  }

  Worksheet? sheet;
  Spreadsheet? spreadSheet;
  Future init() async{
    try{
      getSheetNamesStatus.value = StateStatus.LOADING;
      _gsheets = GSheets(_credentials);
      spreadSheet = await _gsheets.spreadsheet(_spreadSheetId);

      for(var item in spreadSheet!.sheets){
        sheetNames.add(item.title);
      }
      getSheetNamesStatus.value = StateStatus.SUCCESS;
      // spreadSheet!.sheets.map((e) => print('titles:${e.title}'));
      // sheet = await _getWorkSheet(spreadSheet!,title:'user');
      // List<String> firstRow = UserFields.getFields();
      // sheet!.values.insertRow(1,firstRow);
    }catch(e){
      print('Init error $e');
      getSheetNamesStatus.value = StateStatus.ERROR;
    }
  }
  createFirstRow(List<String> titles){
    sheet!.values.insertRow(1,titles);
  }
  Future createSheet(String name)async{
    try{
      sheet = await _getWorkSheet(spreadSheet!,title:name);
      await sheet!.values.appendColumn(['id']);
      sheetNames.add(name);
    }catch(e){
    }
  }
  getSheet(String name)async{
      try{
        change(null, status: RxStatus.loading());
        sheet = await _getWorkSheet(spreadSheet!,title:name);
      }catch(e){}
  }
  Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,{required String title})async{
    try{

      return await spreadsheet.addWorksheet(title);
    }catch(e){
      return spreadsheet.worksheetByTitle(title)!;
    }
  }
  Future insert(Map<String,String> item)async{
    if(sheet == null) return;
    try{
      sheet!.values.map.appendRow(item);
      items.add(item);
      change(items, status: RxStatus.success());
      Get.back();
      await Future.delayed(Duration(milliseconds: delay));
      Get.snackbar("Success", "Data added to sheet",backgroundColor: Colors.black45,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
    }catch(e){
      print(e);
    }
  }

  Future<User?> getById(int id)async{
    if(sheet == null) return null;
    final json = await sheet!.values.map.rowByKey(id,fromColumn: 1);
    return json == null ? null:User.fromJson(json);
  }
   getAllRows()async{
    change(null, status: RxStatus.loading());
    if(sheet == null) {
      change(null, status: RxStatus.error());
      return;
    }
    headerRow = [];
    // headerRow.add('Action');
    headerRow.addAll(await sheet!.values.row(1));

    final usersJson = await sheet!.values.map.allRows();
    if(usersJson == null){
      change(null, status: RxStatus.empty());
    }
    else{
      items = usersJson;
      // users = usersJson.map((e) => User.fromJson(e)).toList();
      change(items, status: RxStatus.success());
    }
  }
  Future<bool> updateUser(Map<String,String> item)async{
    if(sheet == null) return false;
    int index = items.indexWhere((element) => element['id'] == item['id']);
    items[index] = item;
    change(items, status: RxStatus.success());
    sheet!.values.map.insertRowByKey(item['id']!, item);
    Get.back();
    await Future.delayed(Duration(milliseconds: delay));
    Get.snackbar("Success", "Data edited successfully",backgroundColor: Colors.black45,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
    return true;
  }
  Future<bool> updateCell({required String id,required String key,required dynamic value})async{
    if(sheet == null) return false;

    return sheet!.values.insertValueByKeys(value, columnKey: key, rowKey: id);
  }
  Future<bool> appendColumn(List<String> titles)async{
    if(sheet == null) return false;
    bool result= await sheet!.values.appendColumn(titles);
    if(result){
      getAllRows();
      Get.back();
      await Future.delayed(Duration(milliseconds: delay));
      Get.snackbar("Success", "Column added successfully",backgroundColor: Colors.black45,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
    }
    return result;

  }
  Future<bool> deleteById(String id)async{
    if(sheet == null) return false;
    items.remove(items.where((element) => element['id'] == id).first);
    // update(items);
    change(items, status: RxStatus.success());
    final index = await sheet!.values.rowIndexOf(id);
    if(index == -1) return false;
    await Future.delayed(Duration(milliseconds: delay));
    Get.snackbar("Success", "Data deleted successfully",backgroundColor: Colors.black45,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
    return sheet!.deleteRow(index);
    // return true;
  }
  bool deleteSheet(int index){
    if(spreadSheet == null) return false;
    try{
      Worksheet? worksheet = spreadSheet!.worksheetByTitle(sheetNames[index]);
      if(worksheet == null) return false;
      spreadSheet!.deleteWorksheet(worksheet);
      sheetNames.removeAt(index);
      Get.snackbar("Success", "Sheet deleted successfully",backgroundColor: Colors.black45,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
    }catch(e){
      return false;
    }
    return true;
  }
}