import 'dart:typed_data';

abstract class LocalDataBaseImage{

  Future<void> localStoreImage(Uint8List imageBytes);

  Future<List<Uint8List>> getImage();


}