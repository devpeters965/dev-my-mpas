
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:real_track/config/theme/style.dart';

final managerName = TextEditingController();
final bussinessName = TextEditingController();
final phoneNumber = TextEditingController();
final mysemail = TextEditingController();
final desciption = TextEditingController();
final otpcontroller = TextEditingController();
late Object? userCommune  = "Abidjan";

late Future< Position?> position;

 String detailText = 'électronique, restant essentiellement inchangé. Il a été popularisé dans les années 1960 avec la sortie de feuilles Letraset contenant des passages de Lorem Ipsum, et plus récemment avec des logiciels de publication assistée par ordinateur comme Aldus PageMaker comprenant des versions de Lorem Ipsum.';

// ------------------- List Of Abidjan Commune 

 List<String> communeAbidjan = [
'Abobo',
'Adjamé',
'Attécoubé',
'Cocody',
'Koumassi',
'Marcory',
'Plateau',
'Port-Bouët',
'Treichville',
'Yopougon'];


// ------------ base icon path
 const baseIcons = "assets/icons";


// ------------------- Local Data Base Value
  late String userInfo = '';

  late List searcResulat = [];
  late List userData = [];
  late bool toogleSearchBar = false;
  late bool isSearchInformation = true;



  // ----------------- Information On Of Form Progress
  List profileIconHeader = [
    {
      'icons' : Icons.phone,
      'title': 'Contact',
      'colors': MyColors.greens
    }  ,
    {
      'icons' : Icons.email,
      'title': 'Email',
      'colors': MyColors.greens
    },
     {
      'icons' : Icons.place_sharp,
      'title': 'Commune',
      'colors': MyColors.greens
    }
  ];

 bool modifieIconsCommune = false;
 bool modifieIconsTell = false;


class OSMdata {
  final String displayname;
  final double lat;
  final double lon;
  OSMdata({required this.displayname, required this.lat, required this.lon});
  @override
  String toString()  {
    return '$displayname, $lat, $lon';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is OSMdata && other.displayname == displayname;
  }

  @override
  int get hashCode => Object.hash(displayname, lat, lon);
}

class LatLong {
  final double latitude;
  final double longitude;
  LatLong(this.latitude, this.longitude);
}

class PickedData {
  final LatLong latLong;
  final String address;

  PickedData(this.latLong, this.address);
}




