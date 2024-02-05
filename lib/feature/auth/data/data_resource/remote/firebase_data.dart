// import 'package:flutter/material.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:real_track/feature/auth/data/model/user_info.dart';
// import 'package:real_track/feature/auth/domain/entities/user_info.dart';
// import 'package:real_track/feature/auth/domain/respository/entities_repository.dart';
// // part 'firebase_data.freezed.dart';

// @freezed
//    class FectData implements EntityRepository{
//      @override
//      Future<List<UserInfoModelEntites>> getNewUserCoordonneeEntity() async{
//     AsyncSnapshot<QuerySnapshot<List<UserInfoModelEntites>>> querySnapshot =  FirebaseFirestore.instance.collection("Userinfo").snapshots() as AsyncSnapshot<QuerySnapshot<List<UserInfoModelEntites>>> ;
//        List<dynamic> userData = [];
//         querySnapshot.data!.docs.forEach((data) {
//           userData.add(UserInfoModelEntites(
//             name: data['flullname'], 
//             numero: data['phone'],
//             marque: data['marque'],
//             matricule: data['matricule'],
//           ));;

//         });

//         return getNewUserCoordonneeEntity();
//      }
//  }

// //  add(UserInfoModelEntites(
// //             name: data['flullname'], 
// //             numero: data['phone'],
// //             marque: data['marque'],
// //             matricule: data['matricule'],
// //           ));

   
     
     

//     //  async{
//     //     QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection("Userinfo").get();
//     //     List<UserInfoModelEntites> userData = [];
//     //     querySnapshot.docs.forEach((data) {
//     //       userData.add(UserInfoModelEntites(
//     //         name: data['flullname'], 
//     //         numero: data['phone'],
//     //         marque: data['marque'],
//     //         matricule: data['matricule'],
//     //       ));

//     //     });

//     //     return userCollection();
//     //  }



