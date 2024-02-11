import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:real_track/feature/auth/presentation/page/principal_maps.dart';

class LoginController extends GetxController{

  var _googleSingIn = GoogleSignIn();
  var googleAccount = Rx<GoogleSignInAccount?>(null);
  

  login() async{
     googleAccount.value =  await _googleSingIn.signIn();
     return rincipalView();
  }

 
}