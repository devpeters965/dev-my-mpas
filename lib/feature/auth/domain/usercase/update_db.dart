import 'dart:async';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:real_track/core/constante/constant_var/const_var.dart';


  final FirebaseStorage _storage = FirebaseStorage.instance;
class AddUser{

    // ----------- Upload Image Into FB
  Future uploadeImageToDataBase(String children, Uint8List file) async{
    Reference ref = _storage.ref().child(children).child("profile/${DateTime.now()}.jpg");
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String download = await snapshot.ref.getDownloadURL();
    return download;
  }



    // ------------------ Add Object to send In FB
    Future<String> addUsers({
    required String managerNames,
    required String bussinessNames,
    required String phones,
    required String emails,
    required Uint8List images,
     Object? communes,
    required String uploadTimes,
    required String desciption,
    
  
  })async{
  
      // ---------------- Get Current Position
     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best );
      
     String imageUri = await uploadeImageToDataBase("children", images);

     final querySnapshort = await FirebaseFirestore.instance.collection('Userinfo').where('managerNames', isEqualTo:managerNames).get();
      querySnapshort.docs.forEach((DocumentSnapshot documentSnapshot) {

      // ------------------ Add Data In FB 
      FirebaseFirestore.instance.collection('Userinfo').doc(documentSnapshot.id).update({
      'images':imageUri,
      'managerNames':managerNames,
      'bussinessNames':bussinessNames,
      'phone':phones,
      'email':emails,
      'communes': communes,
      'times': uploadTimes,
      'latitude': GeoPoint(position.latitude, position.longitude),
      'description':desciption
  
    });
        
      });



  
    print('==== User created  lalt ${position.altitude} long ${position.longitude}');  

    return '';
    
  }

  // -------------------- Upload Data Into FB
    upLoadData(Uint8List image)async{
    final uploadFileTime = DateTime.now();
    String body = await AddUser().addUsers(
                    managerNames: managerName.text,
                    bussinessNames: bussinessName.text,
                    phones: phoneNumber.text,
                    emails: mysemail.text,
                    uploadTimes: uploadFileTime.toString(),
                    images: image,
                    communes: userCommune,
                    desciption: desciption.text 
                    );
      debugPrint('-------------------- UpLoad Data Into FB ');
      debugPrint('------------------- Update body : $body');              

  }
}



