
import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_track/config/theme/assets.dart';
import 'package:real_track/config/theme/style.dart';
import 'package:real_track/core/constante/forms/customer_forms.dart';
import 'package:real_track/feature/auth/presentation/page/principal_maps.dart';
import 'package:real_track/feature/auth/presentation/widget/form/bloc/bloc_sign_in/auth%20_state.dart';
import 'package:real_track/feature/auth/presentation/widget/form/bloc/bloc_sign_in/auth_bloc.dart';
import 'package:real_track/feature/auth/presentation/widget/form/bloc/bloc_sign_in/auth_event.dart';
import 'package:real_track/feature/auth/presentation/widget/form/connection/google_sign.dart';
import 'package:real_track/feature/auth/presentation/widget/form/connection/sign_ins.dart';

class SignIn extends StatefulWidget {
  
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // static String id = 'login_screen';

  final _controller = Get.put(LoginController());


  final emailControler = TextEditingController();
  final passwordControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Column(
              children: [
                Expanded(
                  child: SvgPicture.asset(AssetsFile.assetsLoginSvg),
                ),
                Text("Sign Up",style:GoogleFonts.poppins(fontSize: 24.sp) ),
                  SizedBox(height: 20.h),
                  Expanded(
                   child:  Column(
                    children: [
                       CustomerForm(
                        label: 'Email',
                        textController: emailControler,
                        ),
                       SizedBox(height: 10.h),
          
                       CustomerForm(
                        label: 'Passwords',
                        textController: passwordControler,
          
                       ),
                       SizedBox(height: 2.h),
                      Align(
                        alignment: Alignment.topRight,
                        child:  BlocConsumer<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is AuthenticationSuccessState) {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    rincipalView()
                    ));
                  } else if (state is AuthenticationFailureState) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            content: Text('error'),
                          );
                        });
                  }
                },
                builder: (context, state) {
                  return Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                           BlocProvider.of<AuthenticationBloc>(context).add(
                          SignUpUser(
                            emailControler.text.trim(),
                            emailControler.text.trim())
                        );
                      },
                      child:  Container(
                        padding: EdgeInsets.all(4.sp),
                        child: state is AuthenticationLoadingState
                        ? CircularProgressIndicator(
                          color: MyColors.greens,
                        )
                        :
                         Text('Signup',
                          style: GoogleFonts.poppins(
                            fontSize: 20 ),
                            ),
                      ),
                        ),
                  );
                    },
                 ), 
                      ),

                      const SizedBox(height: 6),
                      // const GoogleSignInScreen()

                         Container(
                      margin: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        

                        Obx(() {

                          if(_controller.googleAccount.value == null){
                            return bottondevalidation();
                          }
                          else {
                              return  bottondevalidation();
                          }
                        }),



                          const SizedBox(width: 10,),
                          // IconButton(onPressed: (){}, icon: const FaIcon(FontAwesomeIcons.facebook,color: Color.fromARGB(255, 6, 94, 188),),),
                          // IconButton(onPressed: (){}, icon: const FaIcon(FontAwesomeIcons.phone,color: Color.fromARGB(255, 6, 94, 188),),),
                          const SizedBox(width: 10,),
                          // IconButton(onPressed: (){}, icon: const FaIcon(FontAwesomeIcons.twitter,color: Color.fromARGB(255, 87, 181, 209),),),
                        ],
                      ),
                    ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ) ) ,
    );
  }
    bottondevalidation(){
        return  Container(
          padding: const EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)
          ),
          child:  Row(
             
             mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: ()async{
                 await  _controller.login();
                  // ignore: use_build_context_synchronously
                  await Navigator.push(context, MaterialPageRoute(builder: (context)=>  rincipalView()));
                }, icon: const Icon(FontAwesomeIcons.googlePlus,color: Color.fromARGB(255, 255, 21, 21),) ,),

               const  Text("Google authentification",style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),)
            ],

          
          )
        );
  }
}