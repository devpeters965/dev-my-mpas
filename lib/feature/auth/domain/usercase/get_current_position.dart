// import 'dart:async';

// import 'package:geolocator/geolocator.dart';

// class TrustLocation {

// Future  gestrusPosition(){
//    Future<Position> position =  Geolocator.getCurrentPosition(
//     desiredAccuracy: LocationAccuracy.high
//   );
//   return position;
// }

// static Future realTimePosition(Position? position)  {
//   final LocationSettings locationSettings =  LocationSettings(
//   accuracy: LocationAccuracy.high,
//   distanceFilter: 100,
// );
// StreamSubscription<Position> positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
//     (Position? position) {
//         print(position == null ? 'Unknown' : '${position.latitude.toString()}, ${position.longitude.toString()}');
//     });
//     return realTimePosition(position);

//  }






// }