
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:isar/isar.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:real_track/core/constante/constant_var/const_var.dart';
import 'package:real_track/feature/auth/data/model/user_info.dart';
import 'package:real_track/feature/auth/data/repository/image.dart';
import 'package:real_track/feature/auth/presentation/page/my_profile.dart';



class LocatData extends ChangeNotifier{

  late Future<Isar> db;
  late List<UserModel> currentUsers = [];
  LocatData(){
    db = openDB();
    
  }

  // -------------------- Open Db
  Future<Isar> openDB()async{
    if(Isar.instanceNames.isEmpty){
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open([UserModelSchema], inspector: true, directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }

   // ------------------- Sava Data
  Future<void> saveData({required UserModel editProfile})async{
    final isar = await db;
    isar.writeTxnSync(() => isar.userModels.putSync(editProfile));
  }

   // ---------------- Update 
  Stream<void> updateBD( int id, UserModel userModel)async*{
    final isar = await db;
    isar.userModels.get(1);
    await isar.writeTxn(()async => await  isar.userModels.putSync(userModel));
  }

  Future<void> updateInfo(int id, String _imgesProile)async{
    final isar = await db; 
    final userInfoExit = isar.userModels.get(id);
    if(userInfoExit != null ){
     final UserModel updated  =    UserModel(
            id: Isar.autoIncrement,
            managerNames: managerName.text,
            bussiness: bussinessName.text,
            phoneName: phoneNumber.text,
            email: mysemail.text,
            desciption: desciption.text,
            commune: userCommune as String,
            images: '$_imgesProile' ); 
            await isar.writeTxn(() => isar.userModels.put(updated));
            await saveData(editProfile: updated);
    }
  }



  // ------------------ Resade Note

   Stream<List<UserModel>> fectAllNote()async*{
    final isar = await db; 
    List<UserModel> fectAllNotes = await isar.userModels.where().findAll();
      currentUsers.clear();
      currentUsers.addAll(fectAllNotes);
      notifyListeners();

  }







  
  // 
  // Future<void> insertDb(BuildContext context, UserModel userModel) async{
  //   final isar = await db;
  //   isar.writeTxnSync(() async => await isar.userModels.putSync(userModel));
  //   print("<<---------- Update user In Db");
  //   // Navigator.push(
  //   //   context, MaterialPageRoute(builder: (context)=>
  //   //   MyProfile(isa: isar,)
  //   //   ));
  // }









    // managerNames: managerName.text,
    //   bussiness: bussinessName.text,
    //   phoneName: phoneNumber.text,
    //   email: mysemail.text,
    //   desciption: desciption.text,
    //   commune: userCommune as String,
    //   image: '$_imgesProile'
 


  

  // ------------------ Filtre
  Stream<List<UserModel>> allEdit() async*{
  final isar = await db;
   yield*  isar.userModels.where().watch(fireImmediately: true);
   currentUsers.clear();
   isar.userModels.where().watch(fireImmediately: true);
   
}




  @override
  Future<List<Uint8List>> getImage() {
    // TODO: implement getImage
    throw UnimplementedError();
  }

  @override
  Future<void> localStoreImage(Uint8List imageBytes) {
    // TODO: implement localStoreImage
    throw UnimplementedError();
  }
}
