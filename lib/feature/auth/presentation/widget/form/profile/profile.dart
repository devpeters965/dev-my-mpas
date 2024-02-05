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
import 'package:real_track/core/constante/forms/customer_form_stepper.dart';
import 'package:badges/badges.dart' as badges;
import 'package:real_track/feature/auth/domain/usercase/add_db.dart';
import 'package:real_track/feature/auth/presentation/page/my_profile.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {

  bool fomSteppers = true;
  bool fomSteppers2 = true;
  int  formCurenteIndex = 0;

  late bool saveInfomationColor = true ;
  late bool saveCoordonneeColor = false ;
  late bool saveSendColor = false;
  late bool showImage = false;

  // bool isHeadChangeColor = false;

  List<bool> listBool = [true,true,false,false];

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
            Future.delayed(Duration(seconds: 3)).then((value) {
              setState(() {
                showImage = true;
              });
            }
            );
        } 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SafeArea(
        child: Column(
              children: [
      
                const SizedBox(height: 15,),
        
                Container(
                  margin: const EdgeInsets.all(7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color:  saveInfomationColor? MyColors.greens :  MyColors.grey.withOpacity(0.5),
                                  shape: BoxShape.circle
                                ),
                                child:   const Icon(Icons.person_pin, color:Colors.white ,),
                              ),
                              const SizedBox(height: 5),
                               const Text('Informations') 
                            ],
                          ),
      
                        Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: saveCoordonneeColor?
                                    MyColors.greens :  MyColors.grey.withOpacity(0.5),
                                  shape: BoxShape.circle
                                ),
                                child:    Icon(Icons.assignment_add,
                                color: saveCoordonneeColor?
                                     Colors.white :  MyColors.black),
                              ),
                              const SizedBox(height: 5),
                               const Text('Coordonnées') 
                            ],
                          ),
      
                        Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: saveSendColor? 
                                  MyColors.greens :  MyColors.grey.withOpacity(0.5),
                                  shape: BoxShape.circle
                                ),
                                child: Icon(Icons.check, color: saveSendColor? Colors.white :  MyColors.black),
                              ),
                              const SizedBox(height: 5),
                               const Text('Terminer') 
                            ],
                          ),
      
      
         
                   
                    ],
                  ),
                ),
      
                const SizedBox(height: 20),
        
        
                formCurenteIndex == 0
                ?
      
                   Expanded(
                     child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                       child: badges.Badge(
                            position: badges.BadgePosition.bottomEnd(bottom: -10, end: 7),
                            showBadge: true,
                            badgeStyle: badges.BadgeStyle(
                              badgeColor: Colors.green.shade300
                            ),
                            badgeContent:  IconButton(
                              onPressed: (){
                                selectImages();
                              }, icon: const Icon(Icons.camera_alt,color: Colors.black,)),
                              child: _imgesProile == ''
                                    ?
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: SvgPicture.asset("assets/icons/Online world-cuate.svg",))
                                       
                                     :
                                     showImage?
                                      ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.file(File(_imgesProile)),
                                     )
                                     :
                                      Center(
                                        child: CircularProgressIndicator(
                                          color: MyColors.greens,
                                        ),
                                      ) 
                          ),
                     ),
                   )
                      :
                formCurenteIndex == 1
                ?
                Expanded(
                  child: SvgPicture.asset("assets/icons/Personal settings-pana.svg",
                  height: MediaQuery.sizeOf(context).height/2,
                  ),
                )
                :
                Container(
                  child: SvgPicture.asset("assets/icons/Location review-bro.svg",
                  height: MediaQuery.sizeOf(context).height/5,
                  width: MediaQuery.sizeOf(context).width/2,
                  ),
                ),              
              //  if(formCurenteIndex == 2)
              //      Container(
              //       color: MyColors.black,
              //        height: 1),
      
                if(formCurenteIndex == 0)
                 Container(
                  //  color: MyColors.black12,
                   height: MediaQuery.sizeOf(context).height/26),    
      
                Expanded(
                  child: Positioned(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    
                      // ----------------- Information About User   
                      if ( formCurenteIndex == 0)
                        CustomerFormStepper1(
                          formIndex:formCurenteIndex , 
                          onFormSubmitted: (isvalide){
                            // saveInfomationColor = true;
                            setState(() {
                               saveCoordonneeColor =! saveCoordonneeColor;
                              listBool[formCurenteIndex] = isvalide;
                              if(isvalide){
                              formCurenteIndex ++;
                             }
                            });
                        }),
                    
                      // --------------------------- cordonnée About Position
                      if (formCurenteIndex == 1 )       
                        CustomerFormStepper2(
                          formIndex: formCurenteIndex,
                           onFormSubmitted: (isvalide){
                            setState(() {
                              saveSendColor =! saveSendColor;
                              listBool[formCurenteIndex] = isvalide;
                            if(isvalide){
                              formCurenteIndex ++;
                            }
                            });
                           }),
                    
                    
                      // -------------------------- User Descriptions 
                       if (formCurenteIndex == 2 )
      
                           CustomerFormStepper3(
                            pictureName: _image,
                            formIndex: formCurenteIndex,
                             onFormSubmitted: (isvalide){
                              setState(() {
                                listBool[formCurenteIndex] = isvalide;
                              if(isvalide){
                                formCurenteIndex ++;
                              }
                              });
                             }),
                                
                      ],
                    ),
                  ),
                ),                
                  ],
            ),
      ),
      
    );
  }
}