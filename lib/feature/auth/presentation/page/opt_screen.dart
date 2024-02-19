import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:real_track/config/theme/assets.dart';
import 'package:real_track/config/theme/style.dart';
import 'package:real_track/core/constante/constant_var/const_var.dart';
import 'package:real_track/core/constante/forms/customer_forms.dart';
import 'package:real_track/feature/auth/data/model/user_info.dart';
import 'package:real_track/feature/auth/domain/usercase/usercase.dart';
import 'package:real_track/feature/auth/presentation/page/principal_maps.dart';
import 'package:real_track/feature/auth/presentation/page/verification_fb_and_google_auth.dart';
import 'package:real_track/feature/auth/presentation/widget/form/profile/isfirst_connexion.dart';
import 'package:pinput/pinput.dart';


class ScreenOtp extends StatefulWidget {
   ScreenOtp({super.key, required  this.userModel, required this. rowBackEditProfile, required this.takecomptes});
    UserModel userModel;
    bool rowBackEditProfile;
    DocumentSnapshot takecomptes;


  @override
  State<ScreenOtp> createState() => _ScreenOtpState();
}

class _ScreenOtpState extends State<ScreenOtp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context){
                return  VerificationUserExiste(
                  userModel: widget.userModel,
                );
            }));
        }, icon: Icon(CupertinoIcons.arrow_left))
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

              CircleAvatar(
                radius: 100,
                backgroundColor: MyColors.greens,
                child: ClipOval(
                  child: Lottie.asset(AssetsFile.opt,
                  height: MediaQuery.sizeOf(context).height/3.h,
                  width: MediaQuery.sizeOf(context).width/3.w
                  ),
                ),
              ),
              SizedBox(height: 10.h),


              Container(
                margin: EdgeInsets.symmetric(horizontal: 12.h),
                child: Text("Le code OTP envoiyé sur le ${widget.takecomptes['phone']} va s'expiré dans 60 seconde ",
                style: GoogleFonts.poppins(),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12.h),
                child: Pinput(
                  length: 6,
                  senderPhoneNumber: widget.takecomptes['phone'],
                  defaultPinTheme: PinTheme(
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: MyColors.grey,
                      borderRadius: BorderRadius.circular(8.r)
                    )
                  ),
                  focusedPinTheme: PinTheme(
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.greens),
                      borderRadius: BorderRadius.circular(8.r)
                    )
                  ),
                  onCompleted: (value) => debugPrint(value),
                ),
              ),
              
              // CustomerForm(
              //   label: 'Entrez code otp reçu',
              //   textController: otpcontroller,
              //   ),

                 

              TextButton(
              onPressed: (){
                final countryPhoneCode = '+225';
                 UserCase.serviceOTP.serviceOtp(countryPhoneCode+widget.takecomptes['phone'], widget.takecomptes['phone'], context, 
                  CreateLocalCompte(rowBackEditProfile: false, userModel: widget.userModel, takecomptes:widget.takecomptes , ));
               
                  }, child: Text("Valider",
                  style: GoogleFonts.poppins(),
                  ), ),

        ],
      ),
    );
  }
}




                  
