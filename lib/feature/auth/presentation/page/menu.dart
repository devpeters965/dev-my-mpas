
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_track/config/theme/assets.dart';
import 'package:real_track/config/theme/style.dart';
import 'package:real_track/feature/auth/data/data_resource/local/local_data.dart';
import 'package:real_track/feature/auth/data/model/user_info.dart';
import 'package:real_track/feature/auth/presentation/page/principal_maps.dart';
import 'package:real_track/feature/auth/presentation/page/profile_view_flow.dart';
import 'package:real_track/feature/auth/presentation/page/verification_fb_and_google_auth.dart';
import 'package:real_track/feature/auth/presentation/widget/form/connection/google_sign.dart';
import 'package:url_launcher/url_launcher.dart';


class UserMenu extends StatefulWidget {
  const UserMenu({super.key, this.userModel});
  final UserModel? userModel;
 
  @override
  State<UserMenu> createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {

  final Uri _uri = Uri.parse('https://dev-y0ca.onrender.com');
  final Uri _uri1 = Uri.parse('mailto:devpeters965@gmail.com');

  late  bool isCreateCompte = true ;
  
 

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(LoginController());
    late  UserModel userItem ;


    return Drawer(
      child:ListView(
        padding: EdgeInsets.zero,
        children: [
            Column(
            children: [
              Container(
                color: Colors.black,
                  height: MediaQuery.sizeOf(context).height/4.h,
                  padding: EdgeInsets.all(1.h),
                  alignment: Alignment.bottomCenter,
                   child: StreamBuilder<List<UserModel>?>(
                    stream:  LocatData().allEdit(),
                      builder: (context , snapshort){
                       if(snapshort.connectionState == ConnectionState.waiting){
                         print("-------- data isSvace into local db ");
                         return SizedBox(
                          height: MediaQuery.sizeOf(context).height,
                          width: MediaQuery.sizeOf(context).width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             CircularProgressIndicator(
                              color: MyColors.greens
                             )
                            ],
                          ),
                         );
                       }
            
                       if(!snapshort.hasData){
                         return Container(
                          // color: Colors.white,
                          child:  Column(
                            children: [
                              UserAccountsDrawerHeader(
                                    accountName:  Text(_controller.googleAccount.value?.displayName?? 'sdkfld',style: GoogleFonts.poppins(fontSize: 12.sp),),
                                    accountEmail: Text(_controller.googleAccount.value?.email?? 'sdlkfsjhdf',style: GoogleFonts.poppins(fontSize: 12.sp),),
                                    currentAccountPicture: CircleAvatar(
                                      child: ClipOval(
                                        child: Image.file(File(userItem.images,),
                                          fit: BoxFit.cover,width:90, height: 90 
                                          )   ),    
                                        ),
                                    decoration:  const BoxDecoration(
                                      color: Colors.black,
                                    ),
                                    ) 
                            ],
                          ),
                         );
                       }
                       print('------------- local db data ${snapshort.data}');
                   
                       final userInfo = snapshort.data;
                   
                       return ListView.builder(
                         itemCount: userInfo!.length,
                         physics: const NeverScrollableScrollPhysics(parent: NeverScrollableScrollPhysics()),
                         itemBuilder: (context, index){
                          userItem = userInfo[index];
                          print('-------------my image ${userItem.images}');
                           
                         return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                            userItem.images.isNotEmpty?
                              Container(
                                height: MediaQuery.sizeOf(context).height/4.h,
                                child: UserAccountsDrawerHeader(
                                accountName:  Text(_controller.googleAccount.value?.displayName?? userItem.managerNames,style: GoogleFonts.poppins(fontSize: 12.sp),),
                                accountEmail: Text(_controller.googleAccount.value?.email?? userItem.email,style: GoogleFonts.poppins(fontSize: 12.sp),),
                                currentAccountPicture: CircleAvatar(
                                  radius: 50.r,
                                  child: ClipOval(
                                    child: Image.file(File(userItem.images,),
                                      fit: BoxFit.cover,width:90, height: 90 
                                      )   ),    
                                    ),
                                 arrowColor: Colors.transparent,   
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  
                                ),
                                ),
                              ) 
                            :
                             Container(
                              margin: EdgeInsets.only(
                                top: 12.h
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 50.w,
                                child: ClipOval(
                                  child: SvgPicture.asset("assets/icons/Online world-cuate.svg", fit: BoxFit.cover,width:90, height: 90 )),
                              )),
                         ]
                         );
                       });
                         })
                  ),
            ], 
          ),

             ListTile(
              title: const Text('Home'),
              leading:  Icon(CupertinoIcons.home,color: Colors.teal.shade300,),
              onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context)=>  rincipalView()))
              ),
          
            ListTile(
              title: const Text('Creer Profile'),
              leading:  Icon(Icons.signpost_rounded,color: Colors.teal.shade300,),
              onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProfileViewFlow()))
              ),

             ListTile(
              title: const Text('Recuper compte'),
              leading:  Icon(CupertinoIcons.person_crop_circle_fill_badge_minus,color: Colors.teal.shade300,),
              onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context)=> VerificationUserExiste(userModel: userItem ,)))
              ),

                 
            ListTile(
              title: const Text('Call back'),
              leading:  Icon(Icons.email,color: Colors.teal.shade300,),
              onTap: urlLuancher1
            ),
          
            ListTile(
              title: const Text('About us'),
              leading:  Icon(Icons.language_rounded,color: Colors.teal.shade300,),
              onTap: urlLuancher,
            ),
          
           const Divider(height: 3,color: Colors.grey,),

            ListTile(
              title:  const Text('Exit'),
              leading:   const Icon(Icons.power_settings_new_rounded,color: Color.fromARGB(255, 255, 41, 41),),
              onTap: () {
                if(Platform.isAndroid){
                  exit(0);
                }
              },
            ),
        ],
        ),);
  }

   Future<void> urlLuancher()async{
    if(!await launchUrl(_uri)){
      throw Exception('Url invalide $_uri');
    }
  }

   Future<void> urlLuancher1()async{
    if(!await launchUrl(_uri1)){
      throw Exception('Url invalide $_uri1');
    }
  }
}



