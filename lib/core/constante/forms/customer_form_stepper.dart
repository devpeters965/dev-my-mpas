import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_track/config/theme/style.dart';
import 'package:real_track/core/constante/constant_var/const_var.dart';
import 'package:real_track/core/constante/forms/customer_forms.dart';
import 'package:real_track/core/constante/forms/customer_selected.dart';
import 'package:real_track/feature/auth/domain/usercase/add_db.dart';
import 'package:real_track/feature/auth/presentation/page/principal_maps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';




// ----------------- Information About User
// ignore: must_be_immutable
class CustomerFormStepper1 extends StatefulWidget {
   CustomerFormStepper1({super.key, required this.formIndex, required this.onFormSubmitted, });
      
      int formIndex;
      final Function(bool) onFormSubmitted;

  @override
  State<CustomerFormStepper1> createState() => _CustomerFormStepper1State();
}

class _CustomerFormStepper1State extends State<CustomerFormStepper1> {

 late   GlobalKey<FormState> userInformation = GlobalKey<FormState>();

  // late Uint8List? image;
  late Uint8List? _image;
  late String _imgesProile = "";
  void selectImages() async{
    XFile? _img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(_img != null){
      File imageFile = File(_img.path);
      Uint8List uint8list = await imageFile.readAsBytes();
      setState(() {
        _imgesProile = imageFile.path;
        _image = uint8list;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       color: Colors.black,
      child: SingleChildScrollView(
        child: Column(
          children: [
                  SingleChildScrollView(
                    child: Container(
                      // height: MediaQuery.sizeOf(context).height, 
                      color: Colors.yellow,
                      child: Form(
                            key: userInformation,
                            child: Column(
                              children: [
                                CustomerForm(
                                label: 'Manager name',
                                textController: managerName,
                                validation: (value) {
                                  return value == null || value.isEmpty? 'Champ obligatoire' : null;
                                }
                                
                                ),
                                CustomerForm(
                                label: 'Business Name',
                                textController: bussinessName,
                                validation: (value) {
                                  return value == null || value.isEmpty? 'Champ obligatoire': null;
                               
                                },
                               
                                ),
                              ],
                            ),
                          ),
                    ),
                  ),
        
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                             if (userInformation.currentState!.validate()) {
                                  bool isValid = true;
                                  widget.onFormSubmitted(isValid);
                             }
                            },
                            child:Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                    color: MyColors.grey,
                                    borderRadius: BorderRadius.circular(8)
                                    ),
                                    child:  Text(
                                    "Next",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 17
                                    ),),
                                    ),
                          ),
                        ],
                      ),
          ],
        ),
      ),
    );
 
  }
}

// --------------------------- cordonnée About Position


// ignore: must_be_immutable
class CustomerFormStepper2 extends StatelessWidget {
   CustomerFormStepper2({super.key, required this.formIndex, required this.onFormSubmitted});
      int formIndex;
  final Function(bool) onFormSubmitted;
  @override
  Widget build(BuildContext context) {
  late   GlobalKey<FormState> userCoordonnee = GlobalKey<FormState>();

    return Column(
      children: [

        Form(
          key: userCoordonnee,
          child: Column(
                children: [
                  CustomerForm(
                  label: 'Phone number',
                  textController: phoneNumber,
                  validation: (value) {
                    return value == null || value.isEmpty? 'Champ obligatoire': null;
                  },
                
                  ),
                  CustomerForm(
                  label: 'Email',
                  textController: mysemail,
                  validation: (value) {
                 return value == null || value.isEmpty? 'Champ obligatoire': null;
                  },  
                  ),
                ],
              ),
        ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [   
                  GestureDetector(
                      onTap: () {
                       if (userCoordonnee.currentState!.validate()) {
                         bool isValid = true;
                        onFormSubmitted(isValid);
                         
                       }
                      },
                      child:Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                  color: MyColors.grey,
                                  borderRadius: BorderRadius.circular(8)
                                  ),
                                  child:  Text(
                                  "Next",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 17
                                  ),),
                                  ),
                    ),
                ],
              ),
            ),
      ],
    );
 
  }
}




// -------------------------- User Descriptions

class CustomerFormStepper3 extends StatefulWidget {
   CustomerFormStepper3({super.key, required this.formIndex, required this.onFormSubmitted,  this.pictureName});
      Uint8List? pictureName;
      int formIndex;
      final Function(bool) onFormSubmitted;

  @override
  State<CustomerFormStepper3> createState() => _CustomerFormStepper3State();
}

class _CustomerFormStepper3State extends State<CustomerFormStepper3> {
  late   GlobalKey<FormState> userDescription = GlobalKey<FormState>();
   
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Form(
          key: userDescription,
          child: Column(
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
                  CustomerForm(
                  label: 'Desciption',
                  textController: desciption,
                  nombreLigne: 1,
                  validation: (value) {
                    return value == null || value.isEmpty ? 'Le Champs est Obligatoire': null;
                  }
                  ),
                ],
              ),
        ),
                 Container(
                  margin: EdgeInsets.symmetric( horizontal: 8),
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       GestureDetector(
                            onTap: ()async{

                              print("______________: Button Upload Data Into FB Is Toggle");
                              final uploadFileTime = DateTime.now();

                              if (userDescription.currentState!.validate()) {
                                 CreatUser().upLoadData(widget.pictureName!);
                                
                              }
                                
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> rincipalView()));    
                                SharedPreferences preferences = await SharedPreferences.getInstance();
                                preferences.setBool('isValidationDone', true);
                              },
                            child: Container(
                            padding:  EdgeInsets.all(5),
                            decoration: BoxDecoration(
                            color: MyColors.greens,
                            borderRadius: BorderRadius.circular(8)
                            ),
                            child:  Text(
                            "Validation",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 17
                            ),),
                            ),
                          ),
                     ],
                   ),
                 ),
      ],
    );
 
  }
}




