
import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:real_track/feature/auth/data/model/user_info.dart';
import 'package:real_track/feature/auth/data/repository/image.dart';



class LocatData extends LocalDataBaseImage{

  late Future<Isar> db;
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
  

  // ------------------ Filtre

  Stream<List<UserModel>> allEdit() async*{
  final isar = await db;
   yield*  isar.userModels.where().watch(fireImmediately: true);
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
