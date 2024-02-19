
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_track/config/route/default_root.dart';
import 'package:real_track/core/constante/object_list/list.dart';
import 'package:real_track/feature/auth/presentation/widget/form/profile/profile.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class FlasedDescritption extends StatefulWidget {
  const FlasedDescritption({super.key});
  @override
  State<FlasedDescritption> createState() => _FlasedDescritptionState();
}

class _FlasedDescritptionState extends State<FlasedDescritption> {
   final  controller = PageController();
   late int currentIndex = 0;
   bool isFirstTime = true;
   
   bool fomSteppers = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        margin: const EdgeInsets.only(top: 12,bottom: 5),
         alignment: Alignment.center,
        child: PageView.builder(
          itemCount: flasPageItem.length,
          controller: controller,
          onPageChanged: (value){
             setState(() {
               currentIndex = value;
              //  if(currentIndex ==2 ){
              //   Navigator.push(context, MaterialPageRoute(
              //     builder: (context)=>
              //     const SignUpForm()
              //   ));
              //  }
              // print('==============${currentIndex}');
             });
          },
          itemBuilder: (context, index) =>
            Column(
              children: [
                Expanded(
                  child: SvgPicture.asset(flasPageItem[index]['image'])
                ),

                  Expanded(
                  child:  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(flasPageItem[index]['titile']),
                         Text(
                          flasPageItem[index]['subtitile'],
                        style:  GoogleFonts.poppins(
                          color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                  ),
                  ),

                 currentIndex == 2
                 ? 
                  GestureDetector(
                    onTap: (){

                      MyRoot.nextNavigation(context,  UserForm());

                        // Dialorge box
                      // showDialog(context: context,
                      //  builder: (context)=>
                      //  AlertDialog(
                      //   content: SingleChildScrollView(
                      //     child: Expanded(
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //       const Text("Registre form",
                      //       style: GoogleFonts.poppins(
                      //       color: Colors.black,
                      //       fontSize: 20
                      //       ),
                      //                 ), 
                      //       Column(
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //        children: [
                      //        fomSteppers 
                      //        ?
                      //          Column(
                      //            children: [
                      //              CustomerForm(
                      //               label: 'Full name',
                      //               textController: fullName,
                      //               ),
                      //              CustomerForm(
                      //               label: 'Phone Number',
                      //               textController: phoneNumber,
                      //               ),
                      //            ],
                      //          )
                      //         :
                      //          Column(
                      //            children: [
                      //              CustomerForm(
                      //               label: 'Matricule',
                      //               textController: matricule,
                      //               ),
                      //              CustomerForm(
                      //               label: 'Marque',
                      //               textController: marque,),
                      //            ],
                      //          ),
                      //        ],
                      //       ),
                      //        fomSteppers 
                      //        ?
                      //           GestureDetector(
                      //             onTap: () {
                      //                setState(() {
                      //                  fomSteppers = !fomSteppers;
                      //                  print('-----------------------$fomSteppers');
                      //                });
                      //             },
                      //              child: Container(
                      //               padding: const EdgeInsets.all(5),
                      //               decoration: BoxDecoration(
                      //                 color: Colors.black,
                      //                 borderRadius: BorderRadius.circular(8)
                      //               ),
                      //               child: const Text(
                      //                 "Annuler",
                      //                 style: GoogleFonts.poppins(
                      //                   color: Colors.white,
                      //                   fontSize: 17
                      //                 ),),
                      //               ),
                      //            )
                      //         :
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //            GestureDetector(
                      //             onTap: () {},
                      //              child: Container(
                      //               padding: const EdgeInsets.all(5),
                      //               decoration: BoxDecoration(
                      //                 color: Colors.black,
                      //                 borderRadius: BorderRadius.circular(8)
                      //               ),
                      //               child: const Text(
                      //                 "Annuler",
                      //                 style: GoogleFonts.poppins(
                      //                   color: Colors.white,
                      //                   fontSize: 17
                      //                 ),),
                      //                           ),
                      //            ),            
                      //           GestureDetector(
                      //             onTap: ()async{
                      //              print("_________________ au cune donneé applode");
                      //               await CreatUser.createUser(
                      //                 flullname: fullName.value.text,
                      //                 phone: phoneNumber.value.text,
                      //                 matricule: matricule.value.text,
                      //                 marque: marque.value.text,
                      //                 // latitude: position?.altitude ,
                      //                 // longitude: position?.longitude.,
                      //                 );                                                   
                      //                 Navigator.push(context, MaterialPageRoute(builder: (context)=> PrinciapleView()));    
                      //                 SharedPreferences preferences = await SharedPreferences.getInstance();
                      //                 preferences.setBool('isValidationDone', true);
                      //             },
                      //             child: Container(
                      //             padding: const EdgeInsets.all(5),
                      //             decoration: BoxDecoration(
                      //             color: MyColors.grey,
                      //             borderRadius: BorderRadius.circular(8)
                      //             ),
                      //             child: const Text(
                      //             "Validation",
                      //             style: GoogleFonts.poppins(
                      //               color: Colors.black,
                      //               fontSize: 17
                      //             ),),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      //  )
                      //  ); 

                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFCFD8DC),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: const Icon(Icons.arrow_forward_ios)
                    ),
                  )
                 : Container()
            



             
              ]
              
            ),
          )
      ),
      floatingActionButton: SmoothPageIndicator(
        controller: controller,
        effect: WormEffect(
          activeDotColor:Colors.blueAccent.shade100 ,
           strokeWidth: 5,
            dotWidth: 10,
             dotHeight: 5,
             radius: 8,
              spacing: 2,
              //  paintStyle:PaintingStyle.stroke ,
                dotColor: Colors.teal.shade200),
        count: 3),
    );
  }
}