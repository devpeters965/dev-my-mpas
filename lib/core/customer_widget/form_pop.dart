import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_track/core/constante/constant_var/const_var.dart';
import 'package:real_track/core/constante/forms/customer_forms.dart';

class CustomerWidgets {
 CustomerWidgets._();

 static Future popForm(BuildContext context,Widget title, Widget  widget, List<Widget>? action  ){
      return  showDialog(
                 context: context, builder: ((context) => 
                  AlertDialog(
                    title: title,
                    content: SingleChildScrollView(
                      child: widget
                    ),
                    actions: action
                  )
              
                  )
                  );     
                                      
    }
}