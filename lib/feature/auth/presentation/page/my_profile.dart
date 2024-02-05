
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
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
import 'package:real_track/feature/auth/presentation/page/menu.dart';
import 'package:real_track/feature/auth/presentation/page/principal_maps.dart';

class MyProfile extends StatefulWidget {
   MyProfile({super.key, this.userModel});
  final UserModel? userModel;
  

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

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

  final newLocalDB = LocatData();
  late  UserModel   userEditing = UserModel(
  id: Isar.autoIncrement,
   managerNames: managerName.text,
   bussiness: bussinessName.text,
   phoneName: phoneNumber.text,
   email: mysemail.text,
   desciption: desciption.text,
   commune: userCommune as String, images: '$_imgesProile' );

  // final mysemail = TextEditingController();
  // final desciption = TextEditingController();


   @override
  void initState() {
    super.initState();
 if (widget.userModel != null) {
      // mysemail.text = widget.userModel!.email;
      // desciption.text = widget.userModel!.desciption;
    }
  }



  @override
  void dispose() async{
    super.dispose();
    log(mysemail.text);
    log(desciption.text);

    if(widget.userModel != null){
      userEditing = widget.userModel!.copyWith(
      managerNames: managerName.text,
      bussiness: bussinessName.text,
      phoneName: phoneNumber.text,
      email: mysemail.text,
      desciption: desciption.text,
      commune: userCommune as String,
      image: '$_imgesProile'
     );
     newLocalDB.saveData(editProfile: userEditing);
     return;
    }
    

    // newLocalDB.saveData(editProfile: userEditing);
    // managerName.dispose();
    // bussinessName.dispose();
    // phoneNumber.dispose();
    // // mysemail.dispose();
    // mysemail.dispose();
    // desciption.dispose();

    // log('-----insert this data in Local Db    ${newLocalDB.saveData(editProfile: userEditing)}');
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(    
            children: [
              
               SizedBox(
                height: MediaQuery.sizeOf(context).height,
                 child: StreamBuilder<List<UserModel>?>(
                   stream: LocatData().allEdit(),
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
                         final userItem = userInfo[index];
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
          
                                     
          
                                      
                                      
                                     
          
                                    Positioned(
                                      bottom: 9.h,
                                      right: 10.h,
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
          
          
          
          
          
                         GestureDetector(
                           onTap: () {
                              showDialog(context: context, builder: ((context) => 
                               AlertDialog(
                                 title: Text("Ajouter le Manager name ",
                                 style: GoogleFonts.poppins(
                                   fontSize: 19
                                 ),),
                                 content: Column(
                                   mainAxisSize: MainAxisSize.min,
                                   children: [
                                     CustomerForm(
                                       label: 'Manager name',
                                       textController: managerName,
                                     ),
                                     SizedBox(height: 4.h),
                                     Text("Voullez vous apporter des modification ? ",
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
                             margin: EdgeInsets.only(left: 5.sp),
                             child: Align(
                               alignment: Alignment.topLeft,
                               child: Text(
                                userItem.managerNames,
                               
                                 style: GoogleFonts.poppins(fontSize: 20.sp)
                                 ),
                             ),
                           ),
                         ),
                 
                         SizedBox(height: 4.sp),
                 
                         Container(
                           margin: EdgeInsets.only(left: 5.sp),
                           child: Align(
                             alignment: Alignment.topLeft,
                             child: Text(userItem.bussiness,
                             // userItem.bussiness
                               style: GoogleFonts.poppins(fontSize: 20.sp)
                               ),
                           ),
                         ),
                 
                 
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
                                 content: Column(
                                   mainAxisSize: MainAxisSize.min,
                                   children: [
                                     CustomerForm(
                                       label: 'Contact',
                                       textController: phoneNumber,
                                     ),
                                     SizedBox(height: 4.h),
                                     Text("Voullez vous apporter des modification ? ",
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
                                   color: MyColors.black12.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(5.sp)
                                 ),
                                 child: const Icon(Icons.phone) ,
                               ),
                               SizedBox(
                                 height: 5.h,
                               ),
                               Text(userItem.phoneName,
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
                                 title: Text("Ajouter un nouveau mail ",
                                 style: GoogleFonts.poppins(
                                   fontSize: 19
                                 ),),
                                 content: Column(
                                   mainAxisSize: MainAxisSize.min,
                                   children: [
                                      CustomerForm(
                                       label: 'Email',
                                       textController: mysemail,
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
                                   color: MyColors.black12.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(5.sp)
                                 ),
                                 child: const Icon(Icons.email) ,
                               ),
                               SizedBox(
                                 height: 5.h,
                               ),
                               Text(userItem.email,
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
                                     inputTitle: "Abidjan", items: communeAbidjan,
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
                                   color: MyColors.black12.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(5.sp)
                                 ),
                                 child: const Icon(Icons.place_sharp) ,
                               ),
                               SizedBox(
                                 height: 5.h,
                               ),
                               Text(userItem.commune,
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
                   onTap: () {
                          showDialog(context: context, builder: ((context) => 
                               AlertDialog(
                                 title: Text("Ajouter une description ",
                                 style: GoogleFonts.poppins(
                                   fontSize: 19
                                 ),),
                                 content: Column(
                                   mainAxisSize: MainAxisSize.min,
                                   children: [
                                     CustomerForm(
                                       label: 'description',
                                       textController: desciption,
                                     ),
                                     SizedBox(height: 4.h),
                                     Text("Voullez vous apporter des modification ? ",
                                       style: GoogleFonts.poppins(
                                         fontSize: 18
                                 ),),
                                   ],
                                 ),
                                 actions: [
                                   TextButton(
                                     onPressed: (){
                                      setState(() {
                                        setState(() {
                                         Navigator.of(context).pop();
                                       });
                                        
                                      });
                                     },
                                     child: const Text("Proceed")
                                     ),
                           
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
                   },
                   child: Text('description',
                   style: GoogleFonts.poppins(fontSize: 23.sp)
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
                           child:  Text(
                             userItem.desciption,
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
                        Lottie.asset(AssetsFile.validerJson),
                        Text("Voullez vous apouver ces modification ?",
                          style: GoogleFonts.poppins(
                            fontSize: 18
                    ),),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: (){
                          // CreatUser().upLoadData(_image!);
                          Navigator.of(context).pop();

                          
                        },
                        child: const Text("Proceed")
                        ),

                      TextButton(
                        onPressed: (){
                          // CreatUser().upLoadData(_image!);
                          Navigator.push(context, MaterialPageRoute(builder: ((context) => 
                           rincipalView()
                          )));
                          //  Navigator.of(context).pop();
                          
                        },
                        child: const Text("Yes")
                        )  
                    ],
                  )

                  )
                  );
        },
        child: Icon(CupertinoIcons.house,color: Colors.white,)
        // Text(
        //   "Modifier",
        //   style: GoogleFonts.poppins(color: MyColors.black, fontSize: 10.sp)),
        )
    );
  }
}