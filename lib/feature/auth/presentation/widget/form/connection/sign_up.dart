import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_track/config/theme/assets.dart';
import 'package:real_track/config/theme/style.dart';
import 'package:real_track/core/constante/forms/customer_forms.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Column(
            children: [
          
              Expanded(
                child: SvgPicture.asset(AssetsFile.assetsLoginSvg),
              ),
          
              Text("Sign up",style:GoogleFonts.poppins(fontSize: 24.sp) ),
                SizedBox(height: 20.h),
          
                Expanded(
                 child:  Column(
                  children: [
                    const CustomerForm(label: 'Email'),
                     SizedBox(height: 10.h),
                    const CustomerForm(label: 'Passwords'),
          
                     SizedBox(height: 2.h),
          
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.sp),
                          decoration: BoxDecoration(
                            color: MyColors.greens,
                            borderRadius: BorderRadius.circular(8.r)
                          ),
                          child: Text("Validation", style: GoogleFonts.poppins(fontSize: 17.sp),) ,
                        ),
                      ),
                    )
          
                  
          
                              
                  ],
                ),
              ),
          
            ],
          ),
        ) ) ,
    );
  }
}