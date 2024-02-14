import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:real_track/core/notification/local_notification.dart';
import 'package:real_track/core/notification/push_notification.dart';
import 'package:real_track/feature/auth/data/data_resource/local/local_data.dart';
import 'package:real_track/feature/auth/domain/usercase/check_service_map_state.dart';
import 'package:real_track/firebase_connexion_screen.dart';

 Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   NotificationPush.initPushNotification();
   NotificationService().initNotification();
   defaultPosition(); 
   LocatData().db;
   await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [( DeviceOrientation.portraitUp )]
    );
    return  ScreenUtilInit(
      designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return   const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home:  AuthGate()
        
        // AuthenticationFlowScreen()
          );
          
      
        } 
      );
  }
 
}




// WillPopScope(
//           child: AuthGate(), 
//           onWillPop: ()async{ 
//            final value =     await showDialog<bool>(
//             context: context,
//              builder: (context){
//               return AlertDialog(
//                 title:  const Text("Alerte",
//                          style: TextStyle(color: Colors.red,
//                           fontWeight: FontWeight.bold
//                          ),
//                 ),
//                 content: const Text("Voulez vous quitter l'application"),
//                 actions: [
//                   ElevatedButton(
//                     onPressed: (){
//                       Navigator.of(context).pop(false);
//                     },
//                      style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,

//                     ),
//                      child:  const Text("No",
//                              style: TextStyle(
//                               color: Colors.black
//                              ),
                     
//                      )),

//                      const SizedBox(width: 6,),

//                    ElevatedButton(
//                     onPressed: (){
//                       Navigator.of(context).pop(true);
//                     },
//                      style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.greenAccent,

//                     ),
//                      child:  const Text("Exit", style: TextStyle(
//                               color: Colors.black
//                              ),
//                      )),   
//                 ],
                
                
//               );
//             });
//              if(value != null){
//               return Future.value(value);
//             }
//             else{
//               return Future.value(false);
//             }

//          },)























