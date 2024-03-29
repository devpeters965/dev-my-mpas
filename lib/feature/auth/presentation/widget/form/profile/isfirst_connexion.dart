// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isar/isar.dart';
import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';
import 'package:real_track/config/theme/assets.dart';
import 'package:real_track/config/theme/style.dart';
import 'package:real_track/core/constante/constant_var/const_var.dart';
import 'package:real_track/core/constante/forms/customer_forms.dart';
import 'package:real_track/core/constante/forms/customer_selected.dart';
import 'package:real_track/core/notification/local_notification.dart';
import 'package:real_track/feature/auth/data/data_resource/local/local_data.dart';
import 'package:real_track/feature/auth/data/model/user_info.dart';
import 'package:real_track/feature/auth/domain/usercase/add_db.dart';
import 'package:real_track/feature/auth/domain/usercase/update_db.dart';
import 'package:real_track/feature/auth/domain/usercase/usercase.dart';
import 'package:real_track/feature/auth/presentation/page/menu.dart';
import 'package:real_track/feature/auth/presentation/page/my_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateLocalCompte extends StatefulWidget {
   CreateLocalCompte({super.key, this.userModel,  this.listentAllNote, required this.rowBackEditProfile, this.isar, this.takecomptes });
  final UserModel? userModel;
  final bool rowBackEditProfile;
  final LocatData? listentAllNote;
  final Isar? isar;
  DocumentSnapshot? takecomptes;
  
  @override
  State<CreateLocalCompte> createState() => _CreateLocalCompteState();
}

class _CreateLocalCompteState extends State<CreateLocalCompte> {
  late bool isSelectImage = true;
  late bool showImage = false;
  late Uint8List? _image  ;
  late String _imgesProile = "";
  void selectImages() async{
    XFile? _img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(_img != null){
      File imageFile = File(_img.path);
      Uint8List uint8list = await imageFile.readAsBytes();
      setState(() {
        _imgesProile = imageFile.path;
        _image = uint8list;
        isSelectImage = false;
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

  NotificationService localPushNotification = NotificationService();
  final formkey = GlobalKey<FormState>();

  final managerkey = GlobalKey<FormState>();
  final bussinesKey = GlobalKey<FormState>();
  final phoneKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormState>();
  final descriptionKey = GlobalKey<FormState>();

   

  //  List<UserModel> user_info = [];

   final newLocalDB = LocatData();
   late  UserModel   userEditing = UserModel(
   id: 1,
   managerNames: managerName.text,
   bussiness: bussinessName.text,
   phoneName: phoneNumber.text,
   email:  mysemail.text ,
   desciption: desciption.text,
   commune: userCommune as String,
   images:  '$_imgesProile',
   authEmail: '',
   authPassword: ''
    );

  late  UserModel   userUpdate = UserModel(
   id: widget.userModel!.id,
   managerNames: managerName.text,
   bussiness: bussinessName.text,
   phoneName: phoneNumber.text,
   email: mysemail.text,
   desciption: desciption.text,
   commune: userCommune as String,
   images:  '$_imgesProile',
   authEmail: '',
   authPassword: ''
    );

  // late Isar isar;
  String informaton =  'Creer';
   @override
  void initState() {
    super.initState();
    informaton = widget.takecomptes != null? "Mdifier" : 'Creer';
    
 if (widget.userModel != null) {
      informaton =  'Modifier' ;
      managerName.text = widget.userModel!.managerNames;
      bussinessName.text = widget.userModel!.bussiness;
      phoneNumber.text = widget.userModel!.phoneName;
      mysemail.text = widget.userModel!.email;
      desciption.text = widget.userModel!.desciption;
      userCommune = widget.userModel!.commune;
      _imgesProile = widget.userModel!.images;
    }

    // newLocalDB.saveData(editProfile: userEditing);
   
  }

  // @override
  // void dispose() async{
  //   super.dispose();
  //   log(mysemail.text);
  //   log(desciption.text);
    
  //   if(widget.userModel != null){
  //     final userEditing = widget.userModel!.copyWith(
  //     managerNames: managerName.text,
  //     bussiness: bussinessName.text,
  //     phoneName: phoneNumber.text,
  //     email: mysemail.text,
  //     desciption: desciption.text,
  //     commune: userCommune as String,
  //     image: '$_imgesProile'
  //    );
  //   //  newLocalDB.saveData(editProfile: userEditing);
     
  //    return;
  //   }
    
  //   // newLocalDB.saveData(editProfile: userEditing);
  //   managerName.dispose();
  //   bussinessName.dispose();
  //   phoneNumber.dispose();
  //   mysemail.dispose();
  //   // emailControler.dispose();
  //   desciption.dispose();
  // }
   

  @override
  Widget build(BuildContext context) {
   
    return  Scaffold(
      drawer:  const UserMenu(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: widget.rowBackEditProfile == true ? GestureDetector(
          onTap: () {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context){
                return  MyProfile();
            }));
          },
          child: const Icon(CupertinoIcons.back,color: Colors.white,),
        )
        :IconButton(
          onPressed: (){
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
           icon: const Icon(CupertinoIcons.arrow_left,color: Colors.white,)),
        title: Text("Edit Profile", style: GoogleFonts.poppins(color: Colors.white),),
       
      ),
      body: SafeArea(
        child: Container(
          
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Column(
                    children: [
                 SizedBox(
                   height: 13.h,
                  ),
      
                  Expanded(
                  // sinli scrole view
                    child: SingleChildScrollView(
                      child: Column(
                      children: [            
                      Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children:[
                          _imgesProile == ''?
                            Container(
                                 height: MediaQuery.sizeOf(context).height/4.h,
                                  width: MediaQuery.sizeOf(context).width/2.w,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle
                                  ),
                              child: CircleAvatar(
                                radius: 100.r,
                                backgroundColor: Colors.white,
                                child: ClipOval(
                                  child: SvgPicture.asset("assets/icons/Online world-cuate.svg",
                                   height: MediaQuery.sizeOf(context).height.h,
                                   width: MediaQuery.sizeOf(context).width.w
                                  ),
                                ),
                              ),
                            )
                          :
      
                        Container(
                              height: MediaQuery.sizeOf(context).height/4.h,
                             width: MediaQuery.sizeOf(context).width/2.w,
                              decoration: const BoxDecoration(
                                // color: Colors.red,
                                shape: BoxShape.circle
                                ),
                                child: CircleAvatar(
                                  // radius: 1,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                    child: Image.file(File(_imgesProile),
                                    height: MediaQuery.sizeOf(context).height/2.h,
                                    width: MediaQuery.sizeOf(context).width/2.w,
                                    fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                             ),
                             
                        Positioned(
                          bottom: 2.h,
                          right: 0.h,
                          // left: 10.h,
                          child: Align(
                            alignment: const Alignment(0.3, 0.5 ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: MyColors.greens,
                                shape: BoxShape.circle
                              ),
                              child: IconButton(
                                      onPressed: (){
                                        selectImages();
                                      }, icon: const Icon(Icons.camera_alt,color: Colors.white,)),
                            ),),
                        )
                       ]
                      )
                    ),
      
                    SizedBox(height: 15.h),
      
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                             GestureDetector(
                    onTap: () {
                    showDialog(
                          context: context, builder: ((context) => 
                      AlertDialog(
                        title: Text("Ajouter le Manager name ",
                        style: GoogleFonts.poppins(
                          fontSize: 19
                        ),),
                        content: SingleChildScrollView(
                          child: Form(
                            key: managerkey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomerForm(
                                  label: 'Manager name',
                                  textController: managerName,
                                  validation: (value) => value == null || value.isEmpty? 'Le champs est requis' : null,
                                ),
                                SizedBox(height: 4.h),
                                Text("Voullez vous apporter des modification ? ",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18
                            ),),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                                setState(() {
                                  managerName.clear();
                                });
                            },
                            child: const Text("Proceed")
                            ),
                                                        
                          TextButton(
                            onPressed: (){
                              if(managerkey.currentState!.validate()){
                                    setState(() {
                                Navigator.of(context).pop();
                              });            
                              }
                            },
                            child: const Text("Yes")
                            )  
                        ],
                      )
                                                        
                      )
                      );     
                                      
                      },
                    child: Container(
                    margin: EdgeInsets.only(left: 5.sp),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Text(
                            managerName.text.isEmpty?
                                'Manager name'
                            :  managerName.text
                            ,
                            style: GoogleFonts.poppins(fontSize: 20.sp)
                            ),
                              SizedBox(width: 3.w),
                              managerName.text.isEmpty?
                              Icon(CupertinoIcons.pen,color: MyColors.grey,)
                              : Container() 
                        ],
                      ),
                    ),
                    ),
                  ),
                        
                    SizedBox(height: 4.h),
                                           
                    GestureDetector(
                                     onTap:() {
                                           showDialog(context: context, builder: ((context) => 
                                          AlertDialog(
                                            title: Text("Ajouter le nom du Business ",
                                            style: GoogleFonts.poppins(
                                              fontSize: 19
                                            ),),
                                            content: SingleChildScrollView(
                                              child: Form(
                                                key: bussinesKey,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    CustomerForm(
                                                      label: 'Business name',
                                                      textController: bussinessName,
                                                      validation: (value) => value == null || value.isEmpty? 'Le champs est requis' : null,
                                                    ),
                                                    SizedBox(height: 4.h),
                                                    Text("Voullez vous apporter des modification ? ",
                                                      style: GoogleFonts.poppins(
                                                        fontSize: 18
                                                ),),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: (){
                                                  setState(() {
                                                     Navigator.pop(context);
                                                      bussinessName.clear();
                                                  });
                                                },
                                                child: const Text("Proceed")
                                                ),
                                      
                                              TextButton(
                                                onPressed: (){
      
                                                if(bussinesKey.currentState!.validate()){
                                                       setState(() {
                                                    Navigator.of(context).pop();
                                                  });            
                                                  }
                                 
                                                },
                                                child: const Text("Yes")
                                                )  
                                            ],
                                          )
                                          )
                                          );                       
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5.sp),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Row(
                                            children: [
                                              Text(
                                                bussinessName.text.isEmpty?
                                                 'bussines'
                                                 : bussinessName.text,
                                                style: GoogleFonts.poppins(fontSize: 20.sp)
                                                ),
                                                 bussinessName.text.isEmpty?
                                                 Icon(CupertinoIcons.pen,color: MyColors.grey,)
                                                 : Container()
      
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                          ],
                        )
                      ],
                    ),
              
      
                   
                    SizedBox(height: 5.h),
                                           
                                           
                     Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                 GestureDetector(
                                      onTap: () {
                                         showDialog(context: context, builder: ((context) => 
                                          AlertDialog(
                                            title: Text("Ajouter un contact ",
                                            style: GoogleFonts.poppins(
                                              fontSize: 19
                                            ),),
                                            content: SingleChildScrollView(
                                              child: Form(
                                                key: phoneKey,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    CustomerForm(
                                                      label: 'Contact',
                                                      textController: phoneNumber,
                                                      textInputType: TextInputType.phone,
                                                      validation: (value) {
                                                        if(value == null || value.isEmpty){
                                                          return 'Champs est requis';
                                                        }
                                                        if (value.length != 10) {
                                                          return 'nous somme a dix chiffre';
                                                        }
                                                        if (value.contains(RegExp('r[0-9]'))) {
                                                        }
                                                        return null;
                                                      }
                                                    ),
                                                    SizedBox(height: 4.h),
                                                    Text("Voullez vous apporter des modification ? ",
                                                      style: GoogleFonts.poppins(
                                                        fontSize: 18
                                                ),),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: (){
                                                 setState(() {
                                                   Navigator.of(context).pop();
                                                   phoneNumber.clear();
                                                 });
                                                },
                                                child: const Text("Proceed")
                                                ),
                                      
                                              TextButton(
                                                onPressed: (){
                                                   if(phoneKey.currentState!.validate()){
                                                       setState(() {
                                                    Navigator.of(context).pop();
                                                  });            
                                                  }
                                                },
                                                child: const Text("Yes")
                                                )  
                                            ],
                                          )
                                      
                                          )
                                          );
                                      },
                                      
                                      child: Container(
                                        margin: EdgeInsets.symmetric(vertical: 9.h, horizontal: 5.w),
                                        child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(9.sp),
                                            decoration: BoxDecoration(
                                              color: MyColors.grey,
                                             borderRadius: BorderRadius.circular(5.sp)
                                            ),
                                            child: const Icon(Icons.phone) ,
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            phoneNumber.text.isEmpty?
                                             'phoneName'
                                            : phoneNumber.text
                                            ,
                                          style: GoogleFonts.poppins(
                                            fontSize: 11.sp
                                          ),)
                                        ],
                                      ),
                                      ),
                                    ),
                                      
                                     GestureDetector(
                                      onTap: () {
                                         showDialog(context: context, builder: ((context) => 
                                          AlertDialog(
                                            title: Text("Ajouter le même Email que avotre connexion ",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                              fontSize: 19.sp
                                            ),),
                                            content: SingleChildScrollView(
                                              child: Form(
                                                key: emailKey,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                     CustomerForm(
                                                      label: 'Email',
                                                      textController: mysemail,
                                                      textInputType: TextInputType.emailAddress,
                                                      validation: (value) {
                                                         if(value == null || value.isEmpty){
                                                          return 'Champs est requis';
                                                        }
                                                        if (value.contains(RegExp('r[@]'))) {
                                                          return 'le champs est requis @';
                                                        }
                                                        return null;
                                                              
                                                      }
                                                      ),
                                                    Text("Voullez vous apporter des modification ?",
                                                      style: GoogleFonts.poppins(
                                                        fontSize: 18
                                                ),),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: (){
                                                 setState(() {
                                                   Navigator.of(context).pop();
                                                   mysemail.clear();
                                                 });
                                                },
                                                child: const Text("Proceed")
                                                ),
                                      
                                              TextButton(
                                                onPressed: (){
                                                   if(emailKey.currentState!.validate()){
                                                       setState(() {
                                                    Navigator.of(context).pop();
                                                  });            
                                                  }
                                                },
                                                child: const Text("Yes")
                                                )  
                                            ],
                                          )
                                      
                                          )
                                          );
                                        },
                                      
                                      child: Container(
                                        margin: EdgeInsets.symmetric(vertical: 9.h, horizontal: 5.w),
                                        child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(9.sp),
                                            decoration: BoxDecoration(
                                              color: MyColors.grey,
                                             borderRadius: BorderRadius.circular(5.sp)
                                            ),
                                            child: const Icon(Icons.email) ,
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                             mysemail.text.isEmpty?
                                            'Email'
                                            : mysemail.text
                                            ,
                                          style: GoogleFonts.poppins(
                                            fontSize: 11.sp
                                          ),)
                                        ],
                                      ),
                                      ),
                                    ),
                                      
                                      
                                     GestureDetector(
                                      onTap: () { 
                                       showDialog(context: context, builder: ((context) => 
                                        AlertDialog(
                                          title: Text("Selectioner un Commune",
                                          style: GoogleFonts.poppins(
                                            fontSize: 19
                                          ),),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                                CustomerSelected(
                                                label: '',
                                                inputTitle: "Ville", items: communeAbidjan,
                                                onChanged: (value) {
                                                  setState(() {
                                                    userCommune = value;
                                                    print("___________ ${userCommune}");
                                                  });
                                                },
                                                ),
                                              Text("Voullez vous apporter des modification ?",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 18
                                          ),),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: (){
                                                Navigator.pop(context);
                                                // Navigator.pop(context);
                                              },
                                              child: const Text("Proceed")
                                              ),
                                      
                                            TextButton(
                                              onPressed: (){
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Yes")
                                              )  
                                          ],
                                        )
                                      
                                        )
                                        );
                                      },
                                      
                                      child: Container(
                                        margin: EdgeInsets.symmetric(vertical: 9.h, horizontal: 5.w),
                                        child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(9.sp),
                                            decoration: BoxDecoration(
                                              color: MyColors.grey,
                                             borderRadius: BorderRadius.circular(5.sp)
                                            ),
                                            child: const Icon(Icons.place_sharp) ,
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text('${userCommune}'
                                            ,
                                          style: GoogleFonts.poppins(
                                            fontSize: 11.sp
                                          ),)
                                        ],
                                      ),
                                      ),
                                    )
                                       ],
                                    ),
      
                        SizedBox(height: 10.h),
                                                         
                     GestureDetector(
                                    onTap: () {
                                     showDialog(context: context, builder: ((context) => 
                                          AlertDialog(
                                            title: Text("Ajouter une description ",
                                            style: GoogleFonts.poppins(
                                              fontSize: 19
                                            ),),
                                            content: SingleChildScrollView(
                                              child: Form(
                                                key: descriptionKey,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    CustomerForm(
                                                      label: 'description',
                                                      textController: desciption,
                                                      validation: (value) => value == null || value.isEmpty ? 'Champs est requis': null  ,
                                                    ),
                                                    SizedBox(height: 4.h),
                                                    Text("Voullez vous apporter des modification ? ",
                                                      style: GoogleFonts.poppins(
                                                        fontSize: 18
                                                ),),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: (){
                                                setState(() {
                                                    Navigator.pop(context);
                                                    desciption.clear();
                                                });
                                                },
                                                child: const Text("Proceed")
                                                ),
                                      
                                              TextButton(
                                                onPressed: (){
                                                 if(descriptionKey.currentState!.validate()){
                                                    setState(() {
                                                    Navigator.of(context).pop();
                                                  });            
                                                  }
                                                },
                                                child: const Text("Yes")
                                                )  
                                            ],
                                          )
                                      
                                          )
                                          );     
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("Description",
                                            style: GoogleFonts.poppins(fontSize: 23.sp)
                                            ),
      
                                            SizedBox(width: 3.h),
                                               desciption .text.isEmpty?
                                               Icon(CupertinoIcons.pen,color: MyColors.grey,)
                                              : Container()
                                            
                                          ],
                                        ),),
                                      
                                      
                    SizedBox(
                      height: 14.h,
                      ),
                    Container(
                            padding:  EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              SizedBox(
                                  width: MediaQuery.sizeOf(context).width/2,
                                  child:   SingleChildScrollView(
                                    child:  ReadMoreText(
                                      desciption.text,
                                      trimLines: 3,
                                      textAlign: TextAlign.start,
                                      trimCollapsedText: "Show More",
                                      trimExpandedText: "Show Less",
                                      moreStyle: TextStyle(color: MyColors.greens),
                                      lessStyle: TextStyle(color: MyColors.greens),
                                      style: GoogleFonts.poppins(),
                                      
                                      
                                    ),
                              
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
                      ],
                       ),
                       ),
                      )    
                     ],
                    ),
                  ),
                  ),
                floatingActionButton:  FloatingActionButton(
                      backgroundColor: MyColors.greens,
                      onPressed: (){
                      
                        if(_imgesProile.isNotEmpty){
                           showDialog(context: context, builder: ((context) => 
                                AlertDialog(
                                  title: Text("Enregister votre modification.",
                                  style: GoogleFonts.poppins(
                                    fontSize: 19
                                  ),),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // LottieBuilder.asset(AssetsFile.deletedJson),
                                      isSelectImage == true?
                                      Lottie.asset(AssetsFile.emptyImage1)
                                     : Lottie.asset(AssetsFile.validerJson),
                                     
                                     isSelectImage == true?
                                      Text(
                                        "Oooohs Ajouter une images !",
                                        style: GoogleFonts.poppins(
                                          fontSize: 18
                                       ),)
                                    :
                                      Text(
                                        "Assurer vous d'ajouter une image ?",
                                        style: GoogleFonts.poppins(
                                          fontSize: 18
                                  ),),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: (){
                                        Navigator.pop(context);    
                                        setState(() {
                                             isSelectImage = false;
                                          });
                          
                                      },
                                      child: const Text("Proceed")
                                      ),
                                      
                                     isSelectImage == true?
                                      TextButton(
                                        onPressed: ()async{
                                          setState(() {
                                             isSelectImage = false;
                                          });
                                            
                                        if(informaton == "Creer"){

                                           Navigator.of(context).pop();
                                             setState(() {
                                             isSelectImage = false;
                                          });
                                          
                                        }

                                        if(informaton == "Modifier"){
                                        
                                           Navigator.of(context).pop();
                                        }
                                        }, child: const Text("Ok"))
                                    :  
                                       TextButton(
                                      onPressed: ()async{

                                        if(informaton == "Creer"){

                                                   UserCase.usercase.updateUserInfo(userEditing) ;
                                                    CreatUser().upLoadData(_image!);
                                                  // // :  
                                                  // UserCase.usercase.addUserInfo(userEditing);
                                                  //  widget.userModel != null?
                                                  //    AddUser().upLoadData(_image!)
                                                  //  :
                                                     
                                                 
                                                 SharedPreferences preferences = await  SharedPreferences.getInstance();
                                                 preferences.setBool('isValidationDone', true);

                                                   // ignore: use_build_context_synchronously
                                                   Navigator.push(context, MaterialPageRoute(builder: ((context) => 
                                                   MyProfile())));
                                                // await   localPushNotification.showNotification(title: "Studio track", body: "Votre compte a été crée avec success!");
                                        }
                                         if(informaton == "Modifier"){

                                                  // widget.userModel == null? 
                                                  // UserCase.usercase.addUserInfo(userEditing)
                                                // : 
                                                 UserCase.usercase.updateUserInfo(userUpdate);
                                                 AddUser().upLoadData(_image!);
                                                 
                                                  // widget.userModel == null?
                                                    //  CreatUser().upLoadData(_image!)
                                                  // : 
                                                   
                                            
                                                  //  UserCase.usercase.updateUserInfo(userUpdate);
                                                    // AddUser().upLoadData(_image!);

                                                  
                                                    Navigator.push(context, MaterialPageRoute(builder: ((context) => 
                                                    MyProfile())));

                                              SharedPreferences preferences = await  SharedPreferences.getInstance();
                                                preferences.setBool('isValidationDone', true);
                                              // await  localPushNotification.showNotification(title: "Studio track", body: "Votre profile a été modifié avec success!");
                                        }
                                      },
                                      child:   const Text("Yes")
                                      )  
                                  ],
                                )
                                )
                                );
                         }
                         
                        if(_imgesProile.isEmpty ){
                           print('------------- update Local data');
                            showDialog(context: context, builder: ((context) => 
                               AlertDialog(
                                 title: Text("Ajouter une Image avant de valider ",
                                 style: GoogleFonts.poppins(
                                   fontSize: 19
                                 ),),
                                 content: Column(
                                   mainAxisSize: MainAxisSize.min,
                                   children: [
                                    Lottie.asset(AssetsFile.emptyImage1),
                                     SizedBox(height: 4.h),
                                   ],
                                 ),
                                 actions: [
                                   TextButton(
                                     onPressed: (){
                                       setState(() {
                                         Navigator.of(context).pop();
                                       });
                                     },
                                     child: const Text("Yes")
                                     )  
                                 ],
                               )
                           
                               )
                               );     
                          }
                       
                      },
                      child:Text(
                        "$informaton",
                        style: GoogleFonts.poppins(color: MyColors.black, fontSize: 10.sp)),
                      )
    );
                 
  }
}