import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:real_track/feature/auth/data/data_resource/local/local_data.dart';
import 'package:real_track/feature/auth/domain/usercase/check_service_map_state.dart';
import 'package:real_track/firebase_connexion_screen.dart';

 Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
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
          return  const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home:   AuthGate() 
        
        // AuthenticationFlowScreen()
          );
          
        // FutureBuilder(
        //     future: defaultPosition(),
        //     builder: (context, snap) {
        //       if (snap.hasData) {
        //         return const FlashScreen(
        //         );
        //       }
        //       else {
        //        return  Scaffold(
        //           body: Container(
        //             margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 7),
        //             child: Column(
        //               children: [
        //                 Expanded(
        //                   child: Lottie.asset(AssetsFile.mapAnimation)
        //                   ),
        //                   TextButton(onPressed: (){
        //                     AutomateNavigator.getScreen(5,
        //                      context, Navigator.of(context));
        //                   },
        //                    child: const Text("")),
        //                    const SizedBox(
        //                     height: 5,
        //                    ),
        //                   CircularProgressIndicator(
        //                   color: MyColors.grey,
        //                 ),
        //               ],
        //             ),
        //           ),
        //         );
        //       }
        //     },
        //   ));
        
        } 
      );
  }
 
}
























