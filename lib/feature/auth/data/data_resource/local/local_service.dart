

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:real_track/feature/auth/data/model/user_info.dart';
import 'package:real_track/feature/auth/domain/respository/entities_repository.dart';

class LocalService implements RepositoryUserIfo{
 late Future<Isar> db;

 LocalService(){
  db = openDB();
 }



  // open db
  Future<Isar> openDB()async{
    if(Isar.instanceNames.isEmpty){
      final dir = await getApplicationDocumentsDirectory();
       final isar = await Isar.open( [UserModelSchema], directory: dir.path, inspector: true );
       return isar;
    }
    return Future.value(Isar.getInstance()); 
  }
  

  // add user
  @override
  Future<void> addUserInfo(UserModel userModel)async {
    final isar = await openDB();
     isar.writeTxnSync(() => isar.userModels.putSync(userModel));
  }


  //  read user
  @override
  Stream<List<UserModel>> getUserInfo() async*{
    final isar = await openDB();
    yield* isar.userModels.where().watch(fireImmediately: true);
   
  }
  
   // updat usr
  @override
  Future<void> updateUserInfo( UserModel userModel) async{
    final isar = await openDB();
    await isar.writeTxnSync(() async{
      // final userIdExite = await isar.userModels.get(id);
      if(userModel.id != null){
        await isar.userModels.putSync(userModel);
      }
      else{
        debugPrint("_________ user id not found _________");
      }
    });
  
  }

 

}