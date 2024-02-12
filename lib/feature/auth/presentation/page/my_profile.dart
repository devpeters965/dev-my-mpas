
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:real_track/config/theme/assets.dart';
import 'package:real_track/config/theme/style.dart';
import 'package:real_track/core/constante/constant_var/const_var.dart';
import 'package:real_track/core/constante/forms/customer_forms.dart';
import 'package:real_track/core/constante/forms/customer_selected.dart';
import 'package:real_track/feature/auth/data/data_resource/local/local_data.dart';
import 'package:real_track/feature/auth/data/model/user_info.dart';
import 'package:isar/isar.dart';
import 'package:real_track/feature/auth/domain/usercase/update_db.dart';
import 'package:real_track/feature/auth/domain/usercase/usercase.dart';
import 'package:real_track/feature/auth/presentation/page/empty_data.dart';
import 'package:real_track/feature/auth/presentation/page/menu.dart';
import 'package:real_track/feature/auth/presentation/page/principal_maps.dart';
import 'package:real_track/feature/auth/presentation/widget/form/profile/isfirst_connexion.dart';


class MyProfile extends StatefulWidget {
   MyProfile({super.key, this.userModel});
  final UserModel? userModel;
 

  // final Isar? isa ;
  

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  final listentAllNote = LocatData().allEdit();
  late bool rowBackEditProfile = true;

  final bool passeOfMyprofile = true;
  late bool showImage = false;
  late Uint8List? _image ;
  late String _imgesProile = "";
  void selectImages() async{
    XFile? _img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(_img != null){
      File imageFile = File(_img.path);
      Uint8List uint8list = await imageFile.readAsBytes();
      setState(() {
        _imgesProile = imageFile.path;
        _image = uint8list;
        print('------------------ image name: $_imgesProile');

        if(_imgesProile.isNotEmpty){
            Future.delayed(const Duration(seconds: 3)).then((value) {
              setState(() {
                showImage = true;
              });
            }
            );
        } 
      });
    }
  }



  late  UserModel userItem;
  
 @override
  void dispose() {
    log('<<-----Data Body:[$userItem]');
    super.dispose();
  }

     void seachStudio(String query)async{
      final resultat = await FirebaseFirestore.instance.collection('Userinfo').where("communes", isEqualTo: query).get();
       searcResulat = await  resultat.docs.map((e)  =>e.data()).toList();
      setState(()  {
          if(searcResulat.isNotEmpty){
              setState(()  {
                 toogleSearchBar =  true;
                 isSearchInformation = false;
              });
              print('------------------- isSearch: $toogleSearchBar');
          } 
          if(searcResulat.isEmpty){
            const Text("aucune valeur");
          } 
          print(searcResulat);
      }); 
      // return seachStudio(query);
    }
  




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: const UserMenu(),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Colors.black,
        actions: [
         GestureDetector(
          onTap: () {
             setState(() {
             });
              Navigator.push(context, MaterialPageRoute(builder: ((context) => 
              CreateLocalCompte(
                rowBackEditProfile: true,
                userModel: userItem,
                )
              )));
          },
           child: Container(
            padding: EdgeInsets.all(2.h),
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: BoxDecoration(
              color: MyColors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(5.w)
            ),
            child: const Icon(CupertinoIcons.pencil,color: Colors.white,),
           ),
         )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(    
            children: [
              
               SizedBox(
                height: MediaQuery.sizeOf(context).height,
                 child: StreamBuilder<List<UserModel>?>(
                  stream:  UserCase.usercase.getUserInfo(),
                  //  stream:  LocatData().allEdit(),
                  // stream: LocatData().fectAllNote(),
                    builder: (context , snapshort){
                     if(snapshort.connectionState == ConnectionState.waiting){
                       print("-------- data isSvace into local db ");
                       return SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                        width: MediaQuery.sizeOf(context).width,
                        child: Column(
                          children: [
                           CircularProgressIndicator(
                            color: MyColors.greens,
                           )
                          ],
                        ),
                       );
          
                     }
          
                     if(!snapshort.hasData){
                       return SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                        width: MediaQuery.sizeOf(context).width,
                        child: const Column(
                          children: [
                           Text("aucune donnee")
                          ],
                        ),
                       );
                     }
                     print('------------- local db data ${snapshort.data}');
                 
                     final userInfo = snapshort.data;
                 
                     return ListView.builder(
                       itemCount: userInfo!.length,
                       itemBuilder: (context, index){
                          userItem = userInfo[index];
                         print('-------------my image ${userItem.images}');
                       return Column(
                       children: [
          
                               Align(
                                  alignment: Alignment.center,
                                  child: Stack(
                                    children:[
                                      userItem.images.isNotEmpty?
          
                                      Container(
                                            decoration: const BoxDecoration(
                                              // color: Colors.red,
                                              shape: BoxShape.circle
                                            ),
                                        child: ClipRRect(
                                        child: Image.file(File(userItem.images))),
                                       )
          
                                      :
                                        Container(
                                            height: 200.h,
                                            width: 200.w,
                                            decoration: const BoxDecoration(
                                              // color: Colors.red,
                                              shape: BoxShape.circle
                                            ),
                                        child: SvgPicture.asset("assets/icons/Online world-cuate.svg"),
                                      ),
          
                                    // Positioned(
                                    //   bottom: 9.h,
                                    //   right: 10.h,
                                    //   // left: 10.h,
                                    //   child: Align(
                                    //     alignment: const Alignment(0.3, 0.5 ),
                                    //     child: Container(
                                    //       decoration: BoxDecoration(
                                    //         color: MyColors.greens,
                                    //         shape: BoxShape.circle
                                    //       ),
                                    //       child: IconButton(
                                    //               onPressed: (){
                                    //                 selectImages();
                                    //               }, icon: const Icon(Icons.camera_alt,color: Colors.white,)),
                                    //     ),),
                                    // )
                                    ]
                                  )
                                ),
          
                         GestureDetector(
                           child: Container(
                             margin: EdgeInsets.only(left: 5.sp),
                             child: Align(
                               alignment: Alignment.topLeft,
                               child: Text(
                                 userItem.managerNames.isNotEmpty?
                                 userItem.managerNames
                                : "Info non valide",
                                 style: GoogleFonts.poppins(fontSize: 20.sp)
                                 ),
                             ),
                           ),
                         ),
                 
                         SizedBox(height: 4.sp),
                 
                         SizedBox(
                           child: GestureDetector(
                             child: Container(
                               margin: EdgeInsets.only(left: 5.sp),
                               child: Align(
                                 alignment: Alignment.topLeft,
                                 child: Text(
                                  userItem.bussiness.isNotEmpty?
                                   userItem.bussiness
                                  : "Aucune Activé",

                                   style: GoogleFonts.poppins(fontSize: 20.sp)
                                   ),
                               ),
                             ),
                           ),
                         ),
                 
                 
                           Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                      GestureDetector(                           
                           child: Container(
                             margin: EdgeInsets.symmetric(vertical: 9.h, horizontal: 5.w),
                             child: Column(
                             children: [
                               Container(
                                 padding: EdgeInsets.all(9.sp),
                                 decoration: BoxDecoration(
                                   color: MyColors.black12.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(5.sp)
                                 ),
                                 child: const Icon(Icons.phone) ,
                               ),
                               SizedBox(
                                 height: 5.h,
                               ),
                               Text(userItem.phoneName.isNotEmpty?
                                userItem.phoneName
                               : 'numéro invalide'
                               ,
                               style: GoogleFonts.poppins(
                                 fontSize: 11.sp
                               ),)
                             ],
                           ),
                           ),
                         ),
                           
                          GestureDetector(
                           child: Container(
                             margin: EdgeInsets.symmetric(vertical: 9.h, horizontal: 5.w),
                             child: Column(
                             children: [
                               Container(
                                 padding: EdgeInsets.all(9.sp),
                                 decoration: BoxDecoration(
                                   color: MyColors.black12.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(5.sp)
                                 ),
                                 child: const Icon(Icons.email) ,
                               ),
                               SizedBox(
                                 height: 5.h,
                               ),
                               Text(userItem.email.isNotEmpty?
                                userItem.email
                               : 'adresse email invalide'
                               ,
                               style: GoogleFonts.poppins(
                                 fontSize: 11.sp
                               ),)
                             ],
                           ),
                           ),
                         ),
                           
                           
                          GestureDetector(
                           child: Container(
                             margin: EdgeInsets.symmetric(vertical: 9.h, horizontal: 5.w),
                             child: Column(
                             children: [
                               Container(
                                 padding: EdgeInsets.all(9.sp),
                                 decoration: BoxDecoration(
                                   color: MyColors.black12.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(5.sp)
                                 ),
                                 child: const Icon(Icons.place_sharp) ,
                               ),
                               SizedBox(
                                 height: 5.h,
                               ),
                               Text(userItem.commune.isNotEmpty?
                                 userItem.commune
                               : 'aucune commune',
                                
                               style: GoogleFonts.poppins(
                                 fontSize: 11.sp
                               ),)
                             ],
                           ),
                           ),
                         )
                   
                   ],
                 ),
                 
                 GestureDetector(
                   child: Text('description',
                   style: GoogleFonts.poppins(fontSize: 23.sp)
                 ),),
                 
                 
                 SizedBox(
                    height: 14.h,
                   ),
                   
                   userItem.desciption.isNotEmpty?
                     Container(
                   padding:  EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.h),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                        SizedBox(
                           width: MediaQuery.sizeOf(context).width/2,
                           child:  Text(
                             userItem.desciption
                             ,
                             style: GoogleFonts.poppins(
                               fontSize: 16.sp
                             ),
                               textAlign: TextAlign.start,
                               )
                         ),
                       Expanded(
                         child: SvgPicture.asset(AssetsFile.socialMediasvg,
                         width: MediaQuery.sizeOf(context).width/2,
                         ),
                       )
                     ],
                   ),
                 )
                   : const EmptyView()         
                       ],
                     );
                 
                     });
                       }),
               ),
                SizedBox(
                 height: 9.h,
                )
             ],
          ),
        ),
      ),
      floatingActionButton:  FloatingActionButton(
        backgroundColor: MyColors.greens,
        onPressed: (){
          Future.delayed(Duration(seconds: 1)).then((value) {
                  Navigator.push(context, MaterialPageRoute(builder: ((context) => 
                    rincipalView()
                  )));
        });

        },
        child: const Icon(CupertinoIcons.house,color: Colors.white,)
        )
    );
  }
}