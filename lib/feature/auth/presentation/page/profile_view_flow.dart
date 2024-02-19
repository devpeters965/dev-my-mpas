import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:real_track/config/theme/assets.dart';
import 'package:real_track/config/theme/style.dart';
import 'package:real_track/feature/auth/presentation/page/my_profile.dart';
import 'package:real_track/feature/auth/presentation/widget/form/profile/isfirst_connexion.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/usercase/automate_navigatio.dart';


class ProfileViewFlow extends StatefulWidget {
  const ProfileViewFlow({super.key});
  @override
  State<ProfileViewFlow> createState() => _ProfileViewFlowState();
}

class _ProfileViewFlowState extends State<ProfileViewFlow> {
  bool isFirstTime = true;
  bool rowBackEditProfile = false;

@override
  void initState() {
    super.initState();
  }
  Future<bool> isCreateCompte() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isValidationDone = preferences.getBool('isValidationDone')?? false;
    return isValidationDone;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return  FutureBuilder<bool>(
      future: isCreateCompte(), 
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          CircularProgressIndicator.adaptive(
            backgroundColor: MyColors.grey,
          );
        }
        if(snapshot.data == true){
            print("=========== take Home Screen");
             AutomateNavigator.getScreen(2,context,  MyProfile());
        }
        if (!snapshot.hasData) {
             print("============= take to regitrer logine");
             AutomateNavigator.getScreen(2,context,    CreateLocalCompte(rowBackEditProfile: false,));
          
        }{
           
        }
        return Container(
          height: size.height,
          width: size.width,
          color: Colors.white,
          alignment: Alignment.center,
          child: SvgPicture.asset(AssetsFile.groupSvg),
        
        );
    
      });
  }
}