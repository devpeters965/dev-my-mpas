
import 'package:cloud_firestore/cloud_firestore.dart';

class RemoteBDPath{
  RemoteBDPath._();

   static  final remoteDbUserInfoStream = FirebaseFirestore.instance.collection('Userinfo').snapshots();
   static  final  remoteDbUserInfoFuture = FirebaseFirestore.instance.collection('Userinfo').get;
   static  final  remoteRequestUserInfoFuture = FirebaseFirestore.instance.collection('Userinfo');



}