import 'package:cloud_firestore/cloud_firestore.dart';

class FirebsaPath{

static final getUserDataFuture = FirebaseFirestore.instance.collection("Userinfo").snapshots();
static final getUserDataStream = FirebaseFirestore.instance.collection("Userinfo").get();

}