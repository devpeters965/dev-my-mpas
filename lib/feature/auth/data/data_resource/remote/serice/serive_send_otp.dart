
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:real_track/config/theme/assets.dart';
import 'package:real_track/core/constante/constant_var/const_var.dart';
import 'package:real_track/core/constante/forms/customer_forms.dart';
import 'package:real_track/feature/auth/data/model/user_info.dart';
import 'package:real_track/feature/auth/presentation/page/principal_maps.dart';

class ServiceOTP {
   ServiceOTP();
     Future serviceOtp(String  mobile, String numero, BuildContext context, navigator){
                
                  final time = Duration(seconds: 60);
                  FirebaseAuth _auth = FirebaseAuth.instance;
                  _auth.verifyPhoneNumber(
                    phoneNumber: mobile,
                    timeout: const Duration(seconds: 60),
                    verificationCompleted: (AuthCredential authCredential){
                      _auth.signInWithCredential(authCredential).then((value) =>
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => rincipalView()))));
                    },
                    verificationFailed: (FirebaseAuthException firebaseAuthException){
                      debugPrint(firebaseAuthException.message);
                    },
                    codeSent: ((verificationId, forceResendingToken)async {
                        FirebaseAuth auth = FirebaseAuth.instance;
                                  final smsCode = otpcontroller.text.trim();
                                  final credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode );
                                  print("timer =============== $time");
                                  auth.signInWithCredential(credential).then((value) {
                                   Navigator.push(context, MaterialPageRoute(builder: ((context) => navigator)));
                              }
                              ); 
                
                    }),
                    codeAutoRetrievalTimeout: (verificationId) {
                      verificationId = verificationId;
                      debugPrint("============================== $verificationId =======================================");
                      debugPrint("TimeOut");
                    });
                    return serviceOtp(mobile, numero, context, navigator);
                }
               

 
}



// Column(
//             children: [
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Container(
//                   padding: EdgeInsets.all(1),
//                   decoration: BoxDecoration(
//                     color: Colors.red[400],
//                     shape: BoxShape.circle
//                   ),
//                   child: IconButton(onPressed: (){
//                     Navigator.of(context);
//                     }, icon: Icon(Icons.close),)
//                 )
//               ),            
//    // ===================================== validate otp ==============================================================================                          
//                Column(
//                 children: [
              //     CustomerForm(label: 'label'),
              //   // CustomerInputForm(
              //   //     label: '', textController: controllerPN),
              //   ElevatedButton(onPressed: (){
              //     FirebaseAuth auth = FirebaseAuth.instance;
              //  final smsCode = controllerPN.text.trim();
              //  final credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode );
              //  print("timer =============== $time");
              //   auth.signInWithCredential(credential).then((value) {
              //  Navigator.push(context, MaterialPageRoute(builder: ((context) =>   rincipalView ())));
              //   }
              //   );   
              // }, style: ElevatedButton.styleFrom(
              //   backgroundColor: Colors.green[200],
              //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              //   elevation: 7
              // ),
              //  child: const Text("Valider",style: TextStyle(color: Colors.black),))
              //   ],
              //  )
//             ],
//           )
          
