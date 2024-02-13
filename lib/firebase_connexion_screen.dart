import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_track/config/theme/assets.dart';
import 'package:real_track/feature/auth/presentation/page/principal_maps.dart';

// import 'home.dart';


class AuthGate extends StatelessWidget {
 const AuthGate({super.key});

 @override
 Widget build(BuildContext context) {
   return StreamBuilder<User?>(
     stream: FirebaseAuth.instance.authStateChanges(),
     builder: (context, snapshot) {
       if (!snapshot.hasData) {
         return SignInScreen(
          
           providers: [
             EmailAuthProvider(),
             GoogleProvider(
              clientId: "974168670209-vmud8tdq4isc1h7kt2bgbup3io6spli9.apps.googleusercontent.com",
              iOSPreferPlist: true
              ),  // new
           ],
        
           subtitleBuilder: (context, action) {
             return Padding(
               padding: const EdgeInsets.symmetric(vertical: 8.0),
               child: action == AuthAction.signIn
                   ? const Text('Welcome to FlutterFire, please sign in!')
                   : const Text('Welcome to Flutterfire, please sign up!'),
             );
           },
           footerBuilder: (context, action) {
             return  Padding(
               padding: const EdgeInsets.only(top: 16),
               child: Text(
                 'By signing in, you agree to our terms and conditions.',
                 style: GoogleFonts.poppins(color: Colors.grey),
               ),
             );
           },
      
         );
       }

       return  rincipalView();
     },
   );
 }
}
