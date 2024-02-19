import 'package:real_track/core/firebase_path/remote_bd_path.dart';

class SearchUser{
      SearchUser();

    static  void getMyProfile(String itemSearch)async{
     final firebaseRequest =  await RemoteBDPath.remoteRequestUserInfoFuture.where('email',isEqualTo: itemSearch).get();
     final firebaseResponse = firebaseRequest.docs.map((data) => data.data()).toList();
     if(firebaseResponse.isNotEmpty){
      print('<<---------- profile exist');
     }
     
     else{
      print('<<---------- profile no exist');
     }

   }
}