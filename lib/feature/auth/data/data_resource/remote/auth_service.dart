
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_track/feature/auth/domain/entities/user_info.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;



  // ------- Create user
  Future<UserModel?> signUp(String email, String password) async{
    final UserCredential userCredential = await
     firebaseAuth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());

     final User? firebaseUser = userCredential.user;
     if(firebaseUser != null){
      return UserModel(
        id: firebaseUser.uid,
        email: firebaseUser.email?? '',
        displayname: firebaseUser.displayName?? ''
      );
     }
     return null;


  }

  // ----------------- Sign out 
  Future<void> signOut()async{
    final User? firebaseUser = firebaseAuth.currentUser;
    if(firebaseUser != null){
      await FirebaseAuth.instance.signOut();
    }
  }
}