  import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:real_track/feature/auth/domain/usercase/check_service_map_state.dart';

// class GetDefaultPosition extends StatefulWidget {
//   const GetDefaultPosition({super.key});

//   @override
//   State<GetDefaultPosition> createState() => _GetDefaultPositionState();
// }

// class _GetDefaultPositionState extends State<GetDefaultPosition> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//           future: defaultPosition(),
//           builder: (context, snap) {
//             if (snap.hasData) {
//               return PrincipaleView(
//                 position: snap.data as Position,
//               );
//             } else {
//               return const Scaffold(
//                 body: Center(
//                   child: CircularProgressIndicator.adaptive(
//                     // backgroundColor: Colors.yellow,
//                   ),
//                 ),
//               );
//             }
//           },
//         );
//   }
// }