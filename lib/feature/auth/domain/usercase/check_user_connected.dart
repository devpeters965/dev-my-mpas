import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_track/config/route/default_root.dart';
import 'package:real_track/feature/auth/presentation/page/flash_screen.dart';

class CheckConnectionState {
  static Future checkConnectionState( BuildContext context) async {
   final connectionResul = await Connectivity().checkConnectivity();
   if(connectionResul == ConnectivityResult.mobile || connectionResul == ConnectivityResult.wifi){
    //  defaultPosition();
     
    //  return Future.delayed(Duration(seconds: 3)).then((value) =>MyRoot.nextNavigation(context, const FlasedDescritption()));
   }
   else {
    Future.delayed(Duration(seconds: 3)).then((value) =>AwesomeDialog(
            context: context,
            dialogType: DialogType.noHeader,
            animType: AnimType.leftSlide,
            title: "Hooooooooos",
            titleTextStyle:  GoogleFonts.poppins(color: Colors.black),
            desc: "Activé Google Postion et Connecter vous à internet",
              // GoogleFonts.poppins(color: Colors.black),
            btnCancelOnPress: () {
              MyRoot.nextNavigation(context, const FlashScreen());
            },
            btnCancelText: 'Relancer',
              // GoogleFonts.poppins(color: Colors.black),
            btnCancelColor: const Color.fromARGB(255, 182, 215, 241).withOpacity(0.3)
            
        ).show());
   }

  }



}