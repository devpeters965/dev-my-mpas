
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_track/config/theme/style.dart';
import 'package:real_track/feature/auth/presentation/page/principal_maps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/usercase/automate_navigatio.dart';
import '../widget/w_fash_screen/description.dart';


class FlashScreen extends StatefulWidget {
  const FlashScreen({super.key});
  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  bool isFirstTime = true;

@override
  void initState() {
    super.initState();
  }
  Future<bool> checkUserIsRegitre() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isValidationDone = preferences.getBool('isValidationDone')?? false;
    return isValidationDone;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return  FutureBuilder<bool>(
      future: checkUserIsRegitre(), 
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          CircularProgressIndicator.adaptive(
            backgroundColor: MyColors.grey,
          );
        }
        if(snapshot.data == true){
            print("=========== take Home Screen");
             AutomateNavigator.getScreen(2,context,  rincipalView());
        }
        else{
             print("============= take to regitrer logine");
             AutomateNavigator.getScreen(2,context, const FlasedDescritption());
        }
        return Container(
          height: size.height,
          width: size.width,
          color: Colors.white,
          alignment: Alignment.center,
          child: SvgPicture.asset("assets/icons/Directions-bro.svg"),
        );
      });
  }
}
   


// StreamBuilder(
//         stream: FirebsaPath.getUserDataFuture,
//          builder: (context, snapshot) {
//           List<dynamic> geolocator = [];
//           late List<Marker> marker = [];
//           snapshot.data!.docs.forEach((docs) {
//             GeoPoint coordinateLT = docs.data()['latitude'];
//             GeoPoint coordinateLg = docs.data()['longitude'];
//              Marker maker = Marker(
//               position: LatLng(coordinateLT.latitude, coordinateLg.longitude),
//               markerId: MarkerId(coordinateLg.hashCode.toString())
//               );
//              marker.add(maker);
//            },
//            );
//           if(snapshot.connectionState == ConnectionState.waiting){
//             print("= les data sur snaphort============================= $snapshot");
//             return Container(
//               child:  const Column(
//                 children: [
//                     Text("Data loading"),
//                     SizedBox(height: 12,),
//                     CircularProgressIndicator(
//                       color: Colors.grey,
//                     )
//                 ],
//               ),
//             );
//           }
//           if(!snapshot.hasData){
//             return Container(
//               child: const Column(
//                 children: [
//                     Text("No data"),
//                     SizedBox(height: 12,),
//                     CircularProgressIndicator(
//                       color: Colors.grey,
//                     )
//                 ],
//               ),
//             );
//           }
//           return Container(
//             height: 100,
//             width: 100,
//             alignment: Alignment.center,
//             // color: Colors.red,
//             child: GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(0, 0),
//                 zoom: 15,
//                 ),
//                 markers: Set<Marker>.of(marker),
//                 onMapCreated:(controller){
//                 }
//                 )
//           );
//          },)
      
     