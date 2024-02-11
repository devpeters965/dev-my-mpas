
import 'package:real_track/feature/auth/data/model/user_info.dart';

abstract class RepositoryUserIfo {
  
   // add user
  Future<void> addUserInfo(UserModel userModel)async {}
  
    // read user
  Stream<List<UserModel>> getUserInfo()async*{}

  // update user 
  Future<void> updateUserInfo( UserModel userModel)async{}
}