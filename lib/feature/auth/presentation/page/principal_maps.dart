


import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:real_track/config/theme/style.dart';
import 'package:real_track/core/animation/slade_effect.dart';
import 'package:real_track/core/constante/constant_var/const_var.dart';
import 'package:real_track/feature/auth/presentation/page/detail_view.dart';
import 'package:real_track/feature/auth/presentation/page/menu.dart';

class rincipalView extends StatefulWidget {
   rincipalView({super.key});

  @override
  State<rincipalView> createState() => _rincipalViewState();

}

class _rincipalViewState extends State<rincipalView> with SingleTickerProviderStateMixin {



   // ------------------------ All My Variable
  MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<OSMdata> _options = <OSMdata>[];
  LatLng? position = const LatLng(5.3487798 -3.9761185,11.75);
  GeoPoint locations = const GeoPoint(5.3487798 -3.9761185,11.75);
  late String userInfo = '';
  late List searcResulat = [];
  late List userData = [];
  late  bool toogleSearchBar = false;
  late bool isSearchInformation = true;
  List<Marker> markers = [];
  int? editId;
  bool isSaved = false;
  bool isDelete = false;
  Timer? _debounce;
  var client = http.Client();
  late Location location = new Location();
  late bool showMakerInformation = false;


  // ------------------------Get One Positon
  void setNameCurrentPos() async {
    double latitude = _mapController.center.latitude;
    double longitude = _mapController.center.longitude;
    String url ='https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1';
    var response = await client.post(Uri.parse(url));
    var decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;
      _searchController.text = await decodedResponse['display_name'] ?? " MOVE TO CURRENT POSITION";
    print('------------------- longitude $latitude et latitude $longitude');
  }



  // --------------------- Get Current Position 
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


//  --------------------- Do Init Position When App Start
  @override
  void initState() {
    super.initState();
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
   
  }



  // << ---------------------------- search user 
   void seachStudio(String query)async{
      final resultat = await FirebaseFirestore.instance.collection('Userinfo').where("communes", isEqualTo: query).get();
       searcResulat = await  resultat.docs.map((e)  =>e.data()).toList();
      setState(()  {
          if(searcResulat.isNotEmpty){
              setState(()  {
                 toogleSearchBar =  true;
                 isSearchInformation = false;
              });
              print('------------------- isSearch: $toogleSearchBar');
              print('------------------- isSearch: $isSearchInformation');

          } 
          if(searcResulat.isEmpty){
            const Text("aucune valeur");
          } 
          print(searcResulat);
      }); 
      // return seachStudio(query);
    }
    late bool mySearchBar = false;
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const UserMenu(),
      appBar: AppBar(
        backgroundColor: Colors.black,
    
        iconTheme: const IconThemeData(color: Colors.white),
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


      // ------------------------------- App Body

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Userinfo").snapshots(),
        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.waiting){
            return Container(
               alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          } 
          if(!snapshot.hasData){
            return  Center(
              child: Column(
                children: [
                  Text("Aucune donnée",style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),),
                   const CircularProgressIndicator(
                    color: Colors.red,
                  )
                ],
              ),
            );
          }
         if (!snapshot.hasData) {
            return   const Column(
              children: [
                Text("Aucune donnee"),
              ],
            );
            }
          if(snapshot.hasData){
             
            //  --------------------- Extrat Data From FB
             locations = snapshot.data!.docs.first.get("latitude");
                 snapshot.data!.docs.forEach((data) {
                  userData.add(data);
              });

            // ------------------- Take All GeoPoint From By Marker FB
              for (DocumentSnapshot document in snapshot.data!.docs) {
                final title = document["managerNames"];
                GeoPoint coordonnee = document['latitude'];
                double latitudes = coordonnee.latitude;
                double longitudes = coordonnee.longitude;
                 Marker marker = Marker(
                  height: 100,
                  width: 50,
                point: LatLng(latitudes, longitudes),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(context: context, builder: ((context) => 
                                          AlertDialog(
                                            title:  Column(
                                                // mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  ListTile(
                                                    title: Text( document['managerNames']?? '' ,style:  GoogleFonts.poppins(fontSize: 11.sp, color: Colors.black),),
                                                    subtitle: Text(  document['bussinessNames'] ?? ''  ,style: GoogleFonts.poppins(fontSize: 11.sp),),
                                                    leading:   CircleAvatar(
                                                        child:  
                                                          ClipOval(
                                                          child: Image.network( document['images'],
                                                          height: MediaQuery.sizeOf(context).height,
                                                          width:  MediaQuery.sizeOf(context).width,
                                                          ),
                                                        ),
                                                      ), 
                                                      trailing: IconButton(
                                                        onPressed: (){
                                                            Navigator.push(context, MaterialPageRoute(
                                                              builder: (context)=>
                                                            DetailView(item: document, isSearchToggle: toogleSearchBar)
                                                            ));
                                                        }, icon: Icon(CupertinoIcons.arrow_right_circle_fill),
                                                  ),
                                                  ),
                                                ],
                                                
                                              ),
                                          )
                                      
                                          )
                                          );
                      
                       
                      },
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.white
                        ),
                        child: Column(
                          children: [
                            Text(title,style: GoogleFonts.poppins(color: MyColors.black,fontSize: 8.h),
                            textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    ),
                
                    const SizedBox(height:4),
                    const Icon(Icons.place,color: Colors.red,),
                  ],
                ));
                markers.add(marker);
              }
          }

          return Stack(
            children: [
          
              // -------------------------- Maps Widget 
                  Positioned.fill(
                     child: FlutterMap(
                        options: MapOptions(
                            onTap: (tapPosition, point) {
                               setState(()  {
                                 position = point;
                               });
                            },
                            initialCenter:
                             position != null
                                ? position!
                                : 
                            LatLng(
                              position!.latitude,
                              position!.longitude),
                            zoom: 8.0,
                            maxZoom: 18,
                            minZoom: 6),
                        mapController: _mapController,
                        children: [
                          TileLayer(
                            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: const ['a', 'b', 'c'],
                          ),
                          MarkerLayer(markers: markers)
                        ],
                      )),

                   // ----------------------- SubDescription Of Makers  
                  Positioned( 
                    bottom: 2,
                    child: Container(
                      height: 100,
                      width: MediaQuery.sizeOf(context).width,
                      margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                      child:  ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:  toogleSearchBar? searcResulat.length : userData.length,
                                  itemBuilder: (context, index){
                                  final users = toogleSearchBar? searcResulat[index]: userData[index];
                                    return    Column(
                                      children: [
                                        
                                         _searchController.value.text.contains(users["communes"])?

                                        SladeAnimation(
                                          delay: 1200,
                                          child: GestureDetector(
                                            onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>  
                                                DetailView(search: users,  isSearchToggle: isSearchInformation))); 
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(5)
                                                ),
                                              child: Column(
                                                  children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.all(5),
                                                    decoration:  BoxDecoration(
                                                      color:  ('${users['images']}'.isNotEmpty)? Colors.transparent :  Colors.black12,
                                                      shape: BoxShape.circle
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(5),
                                                      child: ('${users['images']}'.isNotEmpty)?
                                                       Image.network(
                                                         users['images'],
                                                         height: MediaQuery.sizeOf(context).height/15 ,
                                                      )
                                                      : SvgPicture.asset("assets/icons/Travelers-pana.svg"),
                                                    )
                                                  ),
                                                   const SizedBox(width: 10,),
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [ 
                                                          Text( users['communes']?? '' ,style:  GoogleFonts.poppins(fontSize: 11.sp, color: Colors.black),),
                                                           Text(  users['bussinessNames'] ?? ''  ,style: GoogleFonts.poppins(fontSize: 11.sp,color: Colors.black),),
                                                          RichText(text: TextSpan(
                                                            children: [
                                                               TextSpan(
                                                                text: users['phone'],
                                                                style:  GoogleFonts.poppins(fontSize: 11.sp,color: MyColors.black)
                                                              ),
                                                            ]
                                                          ))
                                                    ],
                                                    ),
                                                  )
                                                ], 
                                              ),
                                              ],
                                              ),
                                              ),
                                          ),
                                        )  
                                       
                                        : Container()                   
                                      ],
                                    );
                                   })
                         )
                         ),

                 // ---------------------------- Zoom In
                  Positioned(
                      bottom: 150,
                      right: 5,
                      child: FloatingActionButton(
                        heroTag: 'btn1',
                        backgroundColor: Colors.white,
                        onPressed: () {
                          _mapController.move(
                              _mapController.center, _mapController.zoom + 1);
                          pickData().then((value) {
                            position = LatLng(value.latLong.latitude,
                                value.latLong.longitude);
                            _searchController.text = value.address;
                            
                            setState(() {});
                          });
                        },
                        child: const Icon(CupertinoIcons.add),
                      )),

                         // ---------------------------- zoom out  
                        Positioned(
                          bottom: 90,
                          right: 5,
                          child: FloatingActionButton(
                            heroTag: 'btn2',
                            backgroundColor: Colors.white,
                            onPressed: () {
                              _mapController.move(
                                  _mapController.center, _mapController.zoom - 1);
                              pickData().then((value) {
                                position = LatLng(value.latLong.latitude,
                                    value.latLong.longitude);
                                setState(() {});
                              });
                            },
                            child: const Icon(CupertinoIcons.minus),
                          )),

                        // ----------------------------- Get My Position
                        Positioned(
                          bottom: 30,
                          right: 5,
                          child: FloatingActionButton(
                            heroTag: 'btn3',
                            backgroundColor: Colors.white,
                            onPressed: () async {
                              final _locationData = await location.getLocation();
          
                              _mapController.move(
                                  LatLng(
                                      _locationData.latitude ??
                                         position!.latitude,
                                      position!.longitude),
                                  _mapController.zoom);
                              setNameCurrentPos();
                            },
                            child: const Icon(Icons.my_location),
                          )),

                        // ----------------------------- Search Bar
                        Positioned(
                        top: 17,
                        left: 0,
                        right: 0,
                        child: Container(
                          margin: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: [                  
                              StatefulBuilder(builder: ((context, setState) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        _options.length > 5 ? 5 : _options.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(_options[index].displayname),
                                        subtitle: Text(
                                            '${_options[index].lat},${_options[index].lon}'),
                                        onTap: () {
                                          _mapController.move(
                                              LatLng(_options[index].lat,
                                                  _options[index].lon),
                                              15.0);
                                          pickData().then((value) {
                                            position = LatLng(
                                                value.latLong.latitude,
                                                value.latLong.longitude);
                                            _searchController.text = value.address;
          
                                            setState(() {});
                                          });
          
                                          _focusNode.unfocus();
                                          _options.clear();
                                          setState(() {});
                                        },
                                      );
                                    });
                              })),
                            ],
                          ),
                        ),
                      ),     
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










































































