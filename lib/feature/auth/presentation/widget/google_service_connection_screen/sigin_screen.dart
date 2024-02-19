import 'package:awesome_icons/awesome_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:firebaseapis/cloudfunctions/v1.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:real_track/config/theme/assets.dart';
import 'package:real_track/config/theme/style.dart';
import 'package:real_track/feature/auth/presentation/page/principal_maps.dart';
import 'package:real_track/feature/auth/presentation/widget/google_service_connection_screen/reset_password.dart';
import 'package:real_track/feature/auth/presentation/widget/google_service_connection_screen/signup_screen.dart';
import 'package:real_track/feature/auth/presentation/widget/google_service_connection_screen/widget/util_widget.dart';
import 'package:real_track/feature/auth/presentation/widget/form/connection/google_sign.dart';
import 'package:real_track/gen/assets.gen.dart';

class SignInScreens extends StatefulWidget {
  const SignInScreens({Key? key,}) : super(key: key);

  @override
  _SignInScreensState createState() => _SignInScreensState();
}

class _SignInScreensState extends State<SignInScreens> {
    TextEditingController _passwordTextController = TextEditingController();
   TextEditingController _emailTextController = TextEditingController();
    final _controller = Get.put(LoginController());
   late String  myEmail;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
   FirebaseFirestore _firestore = FirebaseFirestore.instance;
   

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
      final String idf ='SgJv9to8PvUSPToyZzu4';
         DocumentSnapshot _database = await _firestore.collection('Userinfo').doc(idf).get();
          // final String mails = _database.docs.f 
          for (DocumentSnapshot document in _database.get("Userinfo") ) {
              myEmail = document['email'];
             
          }

           print('<<---------------- Les données distant: $myEmail ');
            
       

        if(_database.exists){
          if( myEmail == user?.email){
             print('<<---------------- Les données correspondent.');

            //  await Navigator.push(context, MaterialPageRoute(builder: (context)=>  rincipalView()));

          }
        }



      // Récupérer les données du document Firestore correspondant à l'utilisateur
      DocumentSnapshot userSnapshot = await _firestore.collection('Userinfo').doc(user!.uid).get();

      // Vérifier si le document existe
      // if (userSnapshot.exists) {
      //   // Comparer les données dans Firestore avec les informations de l'utilisateur authentifié
      //   if (
      //     // userSnapshot['managerName'] == user.displayName &&
      //       userSnapshot['email'] == user.email) {
      //     print('<<----------------[ Les données correspondent.');
      //   } else {
      //     print(' <<----------------[ Les données ne correspondent pas.');
      //   }
      // } else {
      //   print('Le document n\'existe pas.');
      // }

      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _auth.setPersistence(Persistence.LOCAL);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
         builder: (context, snaphort){
          if(!snaphort.hasData){
                return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration:  BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                    Colors.white.withOpacity(0.2),
                    MyColors.greens,
                    MyColors.black                  
                  ],
              begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                  child: Column(
                    children: <Widget>[
                      SvgPicture.asset(AssetsFile.assetsLoginSvg,
                      height: MediaQuery.sizeOf(context).height/3.h,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      reusableTextField(
                        "Enter email",
                        Icons.person_outline,
                         false,
                          _emailTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField(
                        "Enter Password",
                        Icons.lock_outline, true,
                          _passwordTextController),
                      const SizedBox(
                        height: 5,
                      ),

                      forgetPassword(context),

                      firebaseUIButton(context, "Sign In", () {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _emailTextController.text,
                                password: _passwordTextController.text)
                            .then((value) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => rincipalView()));
                        });
                        // .onError((error, stackTrace) {
                        //   print("Error ${error.toString()}");
                        // });
                      }),
                      signUpOption(),

                      SizedBox(height: 5.h),

                     Obx(() {
                      if(_controller.googleAccount.value == null){
                          return  GestureDetector(
                            onTap: () async {

                                    User? user = await _handleSignIn();
                                    if (user != null) {
                                      print('<<--------------------Connecté avec succès : ${user.email}');
                                    }
                                 await  _controller.login();
                                 
                                  // ignore: use_build_context_synchronously
                                  // await Navigator.push(context, MaterialPageRoute(builder: (context)=>  rincipalView()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  const Icon(FontAwesomeIcons.googlePlus,color: Colors.red ,),
                                  SizedBox(width: 3.w,),
                                  Text("Google authentification",style: GoogleFonts.poppins(color: Colors.white),)
                              ],
                                ),
                          );
                      }
                      else{
                        return  GestureDetector(
                          onTap: () async {
                               User? user = await _handleSignIn();
                                if (user != null) {
                                  User? user = await _handleSignIn();
                                if (user != null) {
                                  print('<<--------------------Connecté avec succès : ${user.displayName}');
                                }
                                }

                               await  _controller.login();
                                // ignore: use_build_context_synchronously
                                await Navigator.push(context, MaterialPageRoute(builder: (context)=>  rincipalView()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                const Icon(FontAwesomeIcons.googlePlus,color: Colors.red ,),
                                SizedBox(width: 3.w,),
                          
                                Text("Google authentification",style: GoogleFonts.poppins(color: Colors.white),)
                            ],
                              ),
                        );
                      }
                     })
                    ],
                  ),
                ),
              ),
            );
        
          }
           
          return rincipalView();
          //  SignInScreens();
          //  SignInScreen();
          // 
      
        }),
    );
  }

   signUpOption() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have account?",
                style: TextStyle(color: Colors.white70)),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignUpScreen()));
              },
              child: const Text(
                " Sign Up",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => const ResetPassword())),
      ),
    );
  }
}