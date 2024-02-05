
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_track/config/theme/assets.dart';
import 'package:real_track/config/theme/style.dart';
import 'package:real_track/core/constante/forms/customer_forms.dart';
import 'package:real_track/feature/auth/presentation/page/principal_maps.dart';
import 'package:real_track/feature/auth/presentation/widget/form/bloc/bloc_sign_in/auth%20_state.dart';
import 'package:real_track/feature/auth/presentation/widget/form/bloc/bloc_sign_in/auth_bloc.dart';
import 'package:real_track/feature/auth/presentation/widget/form/bloc/bloc_sign_in/auth_event.dart';

class SignIn extends StatefulWidget {
  
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // static String id = 'login_screen';

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
                    alignment: Alignment.center,
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
                        
                        
          
                      )           
                    ],
                  ),
                ),
              ],
            ),
          ),
        ) ) ,
    );
  }
}