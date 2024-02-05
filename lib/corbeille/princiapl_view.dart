


import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseapis/firebaseml/v1beta2.dart';
import 'package:firebaseapis/identitytoolkit/v3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:real_track/config/theme/style.dart';
import 'package:real_track/core/constante/constant_var/const_var.dart';
import 'package:real_track/feature/auth/presentation/page/detail_view.dart';
import 'package:real_track/feature/auth/presentation/page/menu.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class PrincipalView extends StatefulWidget {
   PrincipalView({super.key});

  @override
  State<PrincipalView> createState() => _PrincipalViewState();

}

class _PrincipalViewState extends State<PrincipalView>
    with SingleTickerProviderStateMixin {

       MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<OSMdata> _options = <OSMdata>[];
  LatLng? position = const LatLng(5.3487798 -3.9761185,11.75);
  GeoPoint locations = const GeoPoint(5.3487798 -3.9761185,11.75);
   MapShapeLayerController _controller = MapShapeLayerController();
 

  late String userInfo = '';

  late List searcResulat = [];
  late List userData = [];
  late  bool toogleSearchBar = false;

  

  // Set<Marker> markers = Set();
  List<Marker> markers = [];

  int? editId;

  bool isSaved = false;
  bool isDelete = false;

  Timer? _debounce;
  var client = http.Client();
  late Location location = new Location();

  void setNameCurrentPos() async {
    double latitude = _mapController.center.latitude;
    double longitude = _mapController.center.longitude;

    String url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1';

    var response = await client.post(Uri.parse(url));
    var decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;

      _searchController.text = await decodedResponse['display_name'] ?? " MOVE TO CURRENT POSITION";
    
    print('------------------- longitude $latitude et latitude $longitude');
  }

  void setNameCurrentPosAtInit() async {

    double latitude = position!.latitude;
    double longitude =  position!.longitude;
    String url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1';
    var response = await client.post(Uri.parse(url));
    var decodedResponse = await
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    _searchController.text = await decodedResponse['display_name'];
  }

  @override
  void initState() {
    super.initState();
    mapShapeSource;


    _mapController = MapController();
    setNameCurrentPosAtInit();
    _mapController.mapEventStream.listen((event) async {
      if (event is MapEventMoveEnd) { 
        var client = http.Client();
        String url =
            'https://nominatim.openstreetmap.org/reverse?format=json&lat=${event.camera.center.latitude}&lon=${event.camera.center.longitude}&zoom=18&addressdetails=1';
        var response = await client.post(Uri.parse(url));
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes))
            as Map<dynamic, dynamic>;
        // print(decodedResponse);
        _searchController.text = await decodedResponse['display_name'];
        // position = LatLng(event.center.latitude, event.center.longitude);
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
    _mapController.dispose();
    _controller.dispose();

  }


  // << ---------------------------- search user 
   void seachStudio(String query)async{
      final resultat = await FirebaseFirestore.instance.collection('Userinfo').where("flullname", isEqualTo: query).get();
       searcResulat = await  resultat.docs.map((e)  =>e.data()).toList();
      
      setState(()  {
        
          if(searcResulat.isNotEmpty){
              setState(()  {
                 toogleSearchBar =  true;
              });
          } 
          if(searcResulat.isEmpty){
            const Text("aucune valeur");
          } 
          print(searcResulat);
        
      }); 
      // return seachStudio(query);
    }

    late bool mySearchBar = false;

  //  ------------------------------ maps json file
    MapShapeSource mapShapeSource = const MapShapeSource.asset("assets/cart/custom.json",
    shapeDataField: 'Contry name'
    ); 
  
  void ZoomIn(){
    // _controller.zoomPanBehavior
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const UserMenu(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        // automaticallyImplyLeading: false,
        title:  Column(
          children: [
            mySearchBar ?
            TextFormField(
                          controller: _searchController,
                              focusNode: _focusNode,
                              decoration:  InputDecoration(
                                hintText: 'Rechercher une commune',
                                prefixIcon:  const Icon(
                                  Icons.map_rounded,
                                  color: Colors.black12),
                                isDense: true,
                                border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white,),
                                ),
                                fillColor: MyColors.grey,
                                filled: true
                              ),
                              onEditingComplete: () {
                                //  seachStudio(_searchController.text);
                              },
                              onChanged: (String value) async{
                                seachStudio(value); 
                          
                                if (_debounce?.isActive ?? false)
                                  _debounce?.cancel();
                                _debounce =
                                    Timer(
                                      const Duration(milliseconds: 2000),
                                        () async {
                                  var client = http.Client();
                                  try {
                                    String url =
                                        'https://nominatim.openstreetmap.org/search?countrycodes=CI&q=$value&format=json&polygon_geojson=1&addressdetails=1';
                                    var response =
                                        await client.get(Uri.parse(url));
                                    var decodedResponse = jsonDecode(
                                            utf8.decode(response.bodyBytes)) as List<dynamic>;
                                            print('----------------api response    $decodedResponse');
                                    _options = decodedResponse
                                        .map((e) => OSMdata(
                                            displayname: e['display_name'],
                                            lat: double.parse(e['lat']),
                                            lon: double.parse(e['lon'])))
                                        .toList();             
                                    _options.forEach((element) {
                                      position =
                                          LatLng(element.lat, element.lon);
                                        print('----------------api latitude   ${element.lat}');
                                        
                                        
                                    });
                                
                                    setState(() {});
                                  } finally {
                                    client.close();
                                  }
                                
                                  setState(() {});
                                });
                              })
            : Container(),
            const SizedBox(height: 10,)
          ],
        ),
        actions: [
             IconButton(
                  onPressed: (){
                  setState(() {
                    mySearchBar =! mySearchBar;
                  });
                  },
                  icon: const Icon(Icons.search, color: Colors.white))
        ],
                          
        ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Userinfo").snapshots(),
        builder: (context, snapshot) {
          print('<<----------------------- snaphort data : $snapshot');
          if(snapshot.connectionState == ConnectionState.waiting){
            return Container(
               alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }   
            if (!snapshot.hasData) {
            return   const Column(
              children: [
                Text("Aucune donnee"),
                // Container(
                //    alignment: Alignment.center,
                //   child: const CircularProgressIndicator(
                //     color: Colors.red,
                //   ),
                // ),
              ],
            );
            }

          if(snapshot.hasData){

             locations = snapshot.data!.docs.first.get("latitude");
                // snapshot.data!.docs.forEach((data) {
                //   searcResulat.add(data);
                // });

                 snapshot.data!.docs.forEach((data) {
                  userData.add(data);
              });

                
            if (location == null) {
            return   const Column(
              children: [
                Text("Aucune donnee"),
                // Container(
                //    alignment: Alignment.center,
                //   child: const CircularProgressIndicator(
                //     color: Colors.red,
                //   ),
                // ),
              ],
            );
            }

            final latLng = LatLng(
              locations.latitude,
              locations.longitude);

             markers.add(
                  Marker(
                    height: 40,
                    width:40,
                    point: latLng,
                     child: GestureDetector(
                      child: Container( 
                        // color: Colors.white,
                        alignment: Alignment.center,

                        child: const Column(
                          children: [
                              // Text(user['flullname']))
                              // searcResulat[0]["flullname"] == 'Danga' ?
                              //         const Icon(
                              //         Icons.place_sharp,
                              //         color: Colors.red)
                                      // :
                                 Icon(
                                Icons.hotel_rounded,
                                color: Colors.red)
                          ],
                        ),







                        // height: 100,
                        // child: Column(
                        //   children: [
                        //   ...List.generate(userData.length, (index) {
                        //        final user = userData[index];
                        //     print('------------------ nombre of marker  ${user['flullname']}');
                        //     return  GestureDetector(
                        //       onTap: () async{
                        //        await  Navigator.push(context, MaterialPageRoute(builder: (context)=>  DetailView(item: user)));             
                        //       },
                        //       child: Container(
                        //         child: Column(
                        //           children: [
                        //            Container(        
                        //             child: Column(
                        //               children: [
                        //                  Container(
                        //                   padding: EdgeInsets.all(5),
                        //                   decoration: BoxDecoration(
                        //                     color: Colors.white,
                        //                     borderRadius: BorderRadius.circular(4)
                        //                   ),
                        //                   child: Text(user['flullname']))
                        //               ],
                        //             ),
                        //            ),
                        //            user["flullname"] == 'Danga' ?
                        //              const Icon(
                        //               Icons.place_sharp,
                        //               color: Colors.red)     
                        //              : const Icon(
                        //               Icons.hotel_rounded,
                        //               color: Colors.red)   
                        //           ],
                        //         ),
                        //       ),
                        //     );
                        //   }).toList(),
                        // ],)
                        ))));  
          }

          return SfMaps(
              
                layers: [
                 MapShapeLayer(
                  controller: _controller,
                  source: mapShapeSource,
                  // initialLatLngBounds: MapLatLngBounds(northeast, southwest),
                  initialMarkersCount: userData.length,
                  markerBuilder: (context, index) {
                    final user = userData[index];
                    GeoPoint data = user['latitude'];
                    double latitudes = data.latitude;
                    double longitude = data.longitude;
                    return MapMarker(latitude: latitudes, longitude: longitude);
                  },

                  ),

                // MapTileLayer(
                //   urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                //   initialFocalLatLng: MapLatLng(position!.latitude, position!.longitude),
                //   initialZoomLevel: 5,
                //   )
                ],
                );
        }
      ),
    );
  }

    Future<PickedData> pickData() async {
      
    LatLong center = LatLong(
        _mapController.center.latitude, _mapController.center.longitude);
    var client = http.Client();
    String url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${_mapController.center.latitude}&lon=${_mapController.center.longitude}&zoom=18&addressdetails=1';
    var response = await client.get(Uri.parse(url));
    var decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;
    String displayName = decodedResponse['display_name'];
    return PickedData(center, displayName);
  }
  
}


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








































































