

import 'package:real_track/feature/auth/data/model/user_info.dart';
import 'package:real_track/feature/auth/domain/entities/google_entities.dart';

abstract class RepositoryUserIfon {
  
   // add user
  Future<void> addUserInfo(UserModel userModel)async {}
  
    // read user
  Stream<List<UserModel>> getUserInfo()async*{}

  // update user 
  Future<void> updateUserInfo( UserModel userModel)async{}
}


abstract class RepositoryGoogleAuthEntities{

   // add user
  Future<void> addUserGoogleInfo(GoogleEntites googleAuthEntites)async{} 
   // read user
  Stream<List<GoogleEntites>> getUserAuthInfo()async*{}


}