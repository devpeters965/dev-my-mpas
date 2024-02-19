import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:real_track/config/theme/assets.dart';
import 'package:real_track/config/theme/style.dart';
import 'package:real_track/feature/auth/presentation/widget/google_service_connection_screen/sigin_screen.dart';
import 'package:real_track/feature/auth/presentation/widget/google_service_connection_screen/widget/util_widget.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Reset Password",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.2),
                    MyColors.greens,
                    MyColors.black
                   
          ],
           begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                SvgPicture.asset(AssetsFile.assetsLoginSvg,
                      height: MediaQuery.sizeOf(context).height/3.h,
                      ),
                 SizedBox(
                  height: 20.h,
                ),
                reusableTextField("Enter Email", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Reset Password", () {

                     showDialog(context: context, builder: ((context) => 
                                            AlertDialog(
                                              title: Text( 'Vérifier votre boite email'  ,style: GoogleFonts.poppins(fontSize: 15.sp),),
                                              content:  Column(
                                                         mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Lottie.asset(AssetsFile.emptyImage1,
                                                          height: MediaQuery.sizeOf(context).height/4.h
                                                          ),
                                                          
                                                        ],
                                                      ),
                                                actions: [
                                                    TextButton(
                                                          onPressed: (){
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                          const  SignInScreens()
                                                          ));
                                                          FirebaseAuth.instance
                                                          .sendPasswordResetEmail(email: _emailTextController.text)
                                                          .then((value) => Navigator.of(context).pop());
                                                            
                                                          }, child: Text("Ok",style: GoogleFonts.poppins(),),
                                                    ),
                                                ],
                                            )
                                        
                                            )
                                            );









                  
                })
              ],
            ),
          ))),
    );
  }
}