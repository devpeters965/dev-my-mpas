// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:real_track/feature/auth/domain/entities/user_info.dart';

// class DataService{
//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//   addUser(UserEntities userEntities)async{
//     await _db.collection("Userinfo").add(userEntities.toMap());
//   }

//   updateUser(UserEntities userEntities)async{
//     await _db.collection("Userinfo").doc(userEntities.id as String?).update(userEntities.toMap());
//   }

//   Future<void> deleteUser(String userEntitiesId) async{
//     await _db.collection('Userinfo').doc(userEntitiesId).delete();
//   }


//   Future <List<UserEntities>> fectCollection(){
//     _db.collection('Userinfo').snapshots().map((snaphort)  {
//       snaphort.docs.map((docSnapShort) => UserEntities.fromDocumentSnapshot(docSnapShort)).toList();
//     });
//    return fectCollection();
//   }

// }