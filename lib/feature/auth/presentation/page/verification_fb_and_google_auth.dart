import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart' as syn;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer';
import 'package:isar/isar.dart';
import 'package:lottie/lottie.dart';
import 'package:real_track/config/theme/assets.dart';
import 'package:real_track/config/theme/style.dart';
import 'package:real_track/core/firebase_path/remote_bd_path.dart';
import 'package:real_track/feature/auth/data/data_resource/local/local_service.dart';
import 'package:real_track/feature/auth/data/data_resource/remote/serice/serive_send_otp.dart';
import 'package:real_track/feature/auth/data/model/user_info.dart';
import 'package:real_track/feature/auth/domain/usercase/usercase.dart';
// import 'package:real_track/feature/auth/domain/usercase/usercase.dart ' as cases;
import 'package:real_track/feature/auth/presentation/page/empty_data.dart';
import 'package:real_track/feature/auth/presentation/page/menu.dart';
import 'package:real_track/feature/auth/presentation/page/opt_screen.dart';
import 'package:real_track/feature/auth/presentation/widget/form/profile/isfirst_connexion.dart';

class VerificationUserExiste extends StatefulWidget {
   VerificationUserExiste({super.key,  this.userModel});
   final UserModel? userModel;

  @override
  State<VerificationUserExiste> createState() => _VerificationUserExisteState();
}

class _VerificationUserExisteState extends State<VerificationUserExiste> {

   List<dynamic> userInfo = [];
   late List firebaseResponse = [];

   late bool showWidget = true;
   late List<dynamic> checkIfEmailExist = [];

      
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: UserMenu(),
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).height,
        alignment: Alignment.center,
        // color: Colors.amber,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 4.w),
          height: MediaQuery.sizeOf(context).height/1.h,
          width: MediaQuery.sizeOf(context).width,
          // color: Colors.blue,
          child: FutureBuilder(  
            future: RemoteBDPath.remoteRequestUserInfoFuture.where('email',isEqualTo: widget.userModel!.authEmail).get(),
             builder: (context, snaphort){    
               snaphort.data?.docs.forEach((data) {
               firebaseResponse.add(data);
                // String   checkIfEmailExist = data['email'];
               }
               );  
             
              if(snaphort.connectionState == ConnectionState.waiting){
                 showWidget = false;
                
                return  Container(
                  height: MediaQuery.sizeOf(context).width,
                  width: MediaQuery.sizeOf(context).width,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('email'), 
                      CircularProgressIndicator(
                        color: MyColors.greens,
                      ),
                    ],
                  ),
                );
              }
              else if (snaphort.hasData) {
              print('-------------- new : hos ${widget.userModel!.authEmail}  fb:  ${widget.userModel!.authEmail}');
              }

              else if(!snaphort.hasData){
                print('-------------- aucun resultat');
               return  const EmptyView();  
              }
             
                print('<<----- check email existe : $checkIfEmailExist');
               
            return   Container(
                 height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,

               margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 4.w),
              //  color: Colors.amber,
              // checkIfEmailExist.isEmpty ?
               child:   ListView.builder(
                physics: const NeverScrollableScrollPhysics(parent: NeverScrollableScrollPhysics()),
                  itemCount: firebaseResponse.length,
                  itemBuilder: (context, index){
                   final  profile = firebaseResponse[index];
                       UserModel   userEditing = UserModel(
                                  id: widget.userModel!.id,
                                  managerNames: profile['managerNames'],
                                  bussiness: profile['bussinessNames'],
                                  phoneName: profile['phone'],
                                  email:  profile['email'],
                                  desciption: profile['description'],
                                  commune: profile ['communes'],
                                  images:  profile['images'],
                                  authEmail: widget.userModel!.authEmail,
                                  authPassword:widget.userModel!.authPassword
                                    );
                    //  checkIfEmailExist = profile['email'];
                            
                    return  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        SvgPicture.asset(AssetsFile.thinksSvg,
                        height: MediaQuery.sizeOf(context).height/4.h,
                         width: MediaQuery.sizeOf(context).width/4.h,
                        ),
                         SizedBox(height: 18.h),
                         Text('Nous avons trouver un compte sous le nom de ${profile['managerNames']} est ce bien le votre ? ', 
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          color: Colors.black
                        ),
                        textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20.h),
                        CircleAvatar(
                          radius: MediaQuery.sizeOf(context).height/10.r,
                          child: ClipOval(
                            child: Image.network(profile['images'],
                            height: MediaQuery.sizeOf(context).height,
                            width: MediaQuery.sizeOf(context).width,
                            fit: BoxFit.cover,
                            ),
                          ),
                        ), 
                        SizedBox(height: 12.h), 
                        Text(profile['managerNames'], 
                        style: GoogleFonts.poppins(
                          fontSize: 19.sp,
                          color: Colors.black
                        ),),
                       Text(profile['email'], 
                        style: GoogleFonts.poppins(
                          fontSize: 15.sp,
                        ),),
                        SizedBox(height: 10.h),
                        GestureDetector(
                          onTap: () {

                             final countryPhoneCode = '+225';
                               UserCase.serviceOTP.serviceOtp(countryPhoneCode+profile['phone'], profile['phone'], context, 
                               Navigator.push(context, MaterialPageRoute(builder: (context)=> ScreenOtp(
                               rowBackEditProfile: false, userModel: userEditing,  takecomptes: profile))));

                             // -------------- insert authentification data in local db
                             UserCase.usercase.updateUserInfo(userEditing);

                            // Navigator.push(context, MaterialPageRoute(builder: (context)=> ScreenOtp(
                            //  rowBackEditProfile: false, userModel: userEditing,  takecomptes: profile)));

                         
                            // final countryPhoneCode = '+225';
                            // ServiceOTP.serviceOtp(countryPhoneCode+profile['phone'],profile['phone'],context,



                            //  CreateLocalCompte(rowBackEditProfile: false, userModel: userEditing,  takecomptes: profile, ) );
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            // CreateLocalCompte(rowBackEditProfile: false, userModel: userEditing,  takecomptes: profile, )
                            // ));

                            
                           
                            // debugPrint('<<-- user create local profile: ${UserCase.usercase.addUserInfo(userEditing)}');  
                          },
                          child: Container(
                            padding: const EdgeInsets.all(2).r,
                            decoration: BoxDecoration(
                              color: MyColors.greens,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(4)
                            ),
                            child: Text("Continuer",
                            style: GoogleFonts.poppins(fontSize: 13.sp),),
                          ),
                        )
                      ],
                    );
                    }),
                    // :
                    //    Container(
                    //   margin: EdgeInsets.only(top: 12.h),
                    //   child: Column(
                    //     children: [
                    //        SvgPicture.asset(AssetsFile.thinksSvg,
                    //       height: MediaQuery.sizeOf(context).height/3.h,
                    //        width: MediaQuery.sizeOf(context).width/4.w,
                    //       ),
                      
                    //       SizedBox(height: 18.h),
                      
                    //        Text('Oooohs Nous avons trouver aucun compte qui  correspond a votre profile  ',   style: GoogleFonts.poppins(
                    //         fontSize: 16.sp,
                    //         color: Colors.black
                    //       ),
                    //       textAlign: TextAlign.center,
                    //       ),

                    //       SizedBox(height: 18.h),

                    //        GestureDetector(
                    //       onTap: () {
                    //         Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    //         CreateLocalCompte(rowBackEditProfile: false)
                    //         ));

                    //         // -------------- insert authentification data in local db
                    //         // UserCase.usercase.updateUserInfo(userEditing);
                    //         // debugPrint('<<-- user create local profile: ${UserCase.usercase.addUserInfo(userEditing)}');  
                    //       },
                    //       child: Container(
                    //         padding: const EdgeInsets.all(2).r,
                    //         decoration: BoxDecoration(
                    //           color: MyColors.greens,
                    //           shape: BoxShape.rectangle,
                    //           borderRadius: BorderRadius.circular(4)
                    //         ),
                    //         child: Text("Créer un Compte",
                    //         style: GoogleFonts.poppins(fontSize: 13.sp),),
                    //       ),
                    //     )

                          
                      
                      
                      
                         
                    //     ],
                    //   ),
                    // )
                  
             );
             
             }),
        ),
      )
      );
  }
}

