import 'package:get/get.dart';
import 'package:gsheet/models/user_fields.dart';
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
   var _gsheets;
   List<User> users=[];
   List<String> sheetNames=['New Sheet'];
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
      change(null, status: RxStatus.loading());
      _gsheets = GSheets(_credentials);
      // final spreadSheet = _gsheets.worksheetByTitle("user");
      spreadSheet = await _gsheets.spreadsheet(_spreadSheetId);

      for(var item in spreadSheet!.sheets){
        // print('titles:${item.title}');
        sheetNames.add(item.title);
      }
      change(sheetNames, status: RxStatus.success());
      // spreadSheet!.sheets.map((e) => print('titles:${e.title}'));
      // sheet = await _getWorkSheet(spreadSheet!,title:'user');
      // List<String> firstRow = UserFields.getFields();
      // sheet!.values.insertRow(1,firstRow);
    }catch(e){
      print('Init error $e');
    }
  }
  createFirstRow(List<String> titles){
    sheet!.values.insertRow(1,titles);
  }
  createSheet(String name)async{
    change(null, status: RxStatus.loading());
    sheet = await _getWorkSheet(spreadSheet!,title:name);
    getAllRows();
  }
  Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,{required String title})async{
    try{

      return await spreadsheet.addWorksheet(title);
    }catch(e){
      return spreadsheet.worksheetByTitle(title)!;
    }
  }
  Future insert(User user)async{
    if(sheet == null) return;
    try{
      sheet!.values.map.appendRow(user.toJson());
      // Get.snackbar("Success", "Data added to sheet");
      users.add(user);
      change(users, status: RxStatus.success());
      Get.back();
      await Future.delayed(Duration(seconds: 1));
      Get.snackbar("Success", "Data added to sheet");
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
    final usersJson = await sheet!.values.map.allRows();
    if(usersJson == null){
      change(null, status: RxStatus.empty());
    }
    else{
      users = usersJson.map((e) => User.fromJson(e)).toList();
      change(users, status: RxStatus.success());
    }
  }
  Future<bool> updateUser(String id,Map<String,dynamic> user)async{
    if(sheet == null) return false;
    return sheet!.values.map.insertRowByKey(id,user);
  }
  Future<bool> updateCell({required String id,required String key,required dynamic value})async{
    if(sheet == null) return false;
    return sheet!.values.insertValueByKeys(value, columnKey: key, rowKey: id);
  }
  Future<bool> deleteById(int id)async{
    if(sheet == null) return false;
    final index = await sheet!.values.rowIndexOf(id);
    if(index == -1) return false;
    return sheet!.deleteRow(index);
  }
}