import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:real_track/config/theme/assets.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Lottie.asset(AssetsFile.emptyJson),

         Text(
          "Aucune information disponible",
           style:GoogleFonts.poppins(fontSize: 18) ,)

      ],
    );
  }
}