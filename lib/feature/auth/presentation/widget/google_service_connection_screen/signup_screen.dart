import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:isar/isar.dart';
import 'package:real_track/config/theme/assets.dart';
import 'package:real_track/config/theme/style.dart';
import 'package:real_track/feature/auth/data/data_resource/local/local_service.dart';
import 'package:real_track/feature/auth/data/model/user_info.dart';
import 'package:real_track/feature/auth/domain/entities/google_entities.dart';
import 'package:real_track/feature/auth/domain/usercase/usercase.dart';
import 'package:real_track/feature/auth/presentation/page/principal_maps.dart';
import 'package:real_track/feature/auth/presentation/widget/google_service_connection_screen/sigin_screen.dart';
import 'package:real_track/feature/auth/presentation/widget/google_service_connection_screen/widget/util_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
   FirebaseFirestore _firestore = FirebaseFirestore.instance;

@override
  void initState() {
    super.initState();
    _auth.setPersistence(Persistence.LOCAL);
  }
  

  
  Future<User?> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      // Récupérer les données du document Firestore correspondant à l'utilisateur
      DocumentSnapshot userSnapshot = await _firestore.collection('Userinfo').doc(user!.uid).get();

      // Vérifier si le document existe
      if (userSnapshot.exists) {
        // Comparer les données dans Firestore avec les informations de l'utilisateur authentifié
        if (
          // userSnapshot['managerName'] == user.displayName &&
            userSnapshot['email'] == user.email) {
          print('<<----------------[ Les données correspondent.');
        } else {
          print(' <<----------------[ Les données ne correspondent pas.');
        }
      } else {
        print('Le document n\'existe pas.');
      }

      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }
  
   late UserModel googleAuthenInfo = UserModel(
    id: Isar.autoIncrement,
    managerNames: '',
    images: '',
    bussiness: '',
    phoneName: '',
    email: '',
    desciption: '',
    commune: '',
    authEmail: _emailTextController.text,
    authPassword: _passwordTextController.text
   );
  
  
  
  // late  UserCase userCase = UserCase.usercaseGoogle.addUserGoogleInfo(googleAuthenInfo);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
         builder: (context, snaphort){
          
          if(!snaphort.hasData){
            return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                Colors.white.withOpacity(0.2),
                    MyColors.greens,
                    MyColors.black
                   
               
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                 SvgPicture.asset(AssetsFile.assetsLoginSvg,
                      height: MediaQuery.sizeOf(context).height/3.h,
                      ),
               
                

                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter UserName", Icons.person_outline, false,
                    _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email ", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Sign Up", ()async {

                    
                    _auth.createUserWithEmailAndPassword(
                     email: _emailTextController.text,
                     password: _passwordTextController.text)
                      .then((value) {
                    print("Created New Account");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => rincipalView()));
                    
                     UserCase.usercase.addUserInfo(googleAuthenInfo);
                    //  print('----- google information ${UserCase.usercase.addUserInfo(googleAuthenInfo)}');
                     print('----- google information ${_passwordTextController.text}');
                     
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
              ],
            ),
          )));
    
          }

          return rincipalView();
         })
      );
  }
}
