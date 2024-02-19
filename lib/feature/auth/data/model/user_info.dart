// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:isar/isar.dart';
// part 'user_info.g.dart';
part 'user_info.g.dart';

@collection
class UserModel {
  Id id = Isar.autoIncrement;
  final String managerNames;
  final String images;
  final String bussiness;
  final String phoneName;
  final String email;
  final String desciption;
  final String commune;
  late final String? authEmail;
  final String? authPassword;

  UserModel({
    required this.id,
    required this.managerNames,
    required this.images,
    required this.bussiness,
    required this.phoneName,
    required this.email,
    required this.desciption,
    required this.commune,
    this.authEmail,
    this.authPassword
  });
 

  UserModel copyWith({
    Id? id,
    String? image,
    String? managerNames,
    String? bussiness,
    String? phoneName,
    String? email,
    String? desciption,
    String? commune, 
    String? authEmail,
    String? authPassword
  }) {
    return UserModel(
      id: id ?? this.id,
      images: images ?? this.images,
      managerNames: managerNames ?? this.managerNames,
      bussiness: bussiness ?? this.bussiness,
      phoneName: phoneName ?? this.phoneName,
      email: email ?? this.email,
      desciption: desciption ?? this.desciption,
      commune:commune ?? this.commune ,
      authEmail: authEmail?? this.authEmail,
      authPassword: authPassword ?? this.authPassword
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'images':images,
      'managerNames': managerNames,
      'bussiness': bussiness,
      'phoneName': phoneName,
      'email': email,
      'desciption': desciption,
      'commune': commune,
      'authEmail':authEmail,
      'authPassword':authPassword
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ,
      images: map['images'],
      managerNames: map['managerNames'] as String,
      bussiness: map['bussiness'] as String,
      phoneName: map['phoneName'] as String,
      email: map['email'] as String,
      desciption: map['desciption'] as String,
      commune: map['commune'],
      authEmail: map['authEmail'] as String,
      authPassword: map['authPassword']
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(managerNames:$managerNames, id: $id,images:$images  , bussiness: $bussiness, phoneName: $phoneName, email: $email, desciption: $desciption, commune: $commune, authEmail: $authEmail, authPassword: $authPassword )';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.images == images &&
      other.managerNames == managerNames &&
      other.bussiness == bussiness &&
      other.phoneName == phoneName &&
      other.email == email &&
      other.desciption == desciption &&
      other.commune == commune &&
      other.authEmail == authEmail &&
      other.authPassword == authPassword;
  }

  @override
  int get hashCode {
    return id.hashCode^  
      images.hashCode ^
      managerNames.hashCode ^
      bussiness.hashCode ^
      phoneName.hashCode ^
      email.hashCode ^
      desciption.hashCode ^
      commune.hashCode ^
      authEmail.hashCode ^
      authPassword.hashCode;
     
  }
}
