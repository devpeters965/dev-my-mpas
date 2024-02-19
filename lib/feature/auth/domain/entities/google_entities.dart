

import 'dart:convert';

import 'package:isar/isar.dart';
part   'google_entities.g.dart';

@collection
class GoogleEntites{
  Id id = Isar.autoIncrement;
  String authEmail;
  String authPassword;

  GoogleEntites({
    required this.id,
    required this.authEmail,
    required this.authPassword
  });

    GoogleEntites copyWith({
    Id? id,
    String? autoIncrement,
    String? authEmail,
  
    
  }) {
    return GoogleEntites(
      id: id ?? this.id,
      authEmail: authEmail ?? this.authEmail,
      authPassword: authPassword ?? this.authPassword,
    
    );
  }

   Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'authEmail':authEmail,
      'authPassword': authPassword,
    };
  }

    factory GoogleEntites.fromMap(Map<String, dynamic> map) {
    return GoogleEntites(
      id: map['id'] ,
      authEmail: map['authEmail'],
      authPassword: map['authPassword'] as String,
    );
  }
  String toJson() => json.encode(toMap());
  factory GoogleEntites.fromJson(String source) => GoogleEntites.fromMap(json.decode(source) as Map<String, dynamic>);

    @override
  String toString() {
    return 'UserModel(id: $id,authEmail:$authEmail ,bussiness: $authPassword,)';
  }

   @override
  bool operator ==(covariant GoogleEntites other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.authEmail == authEmail &&
      other.authPassword == authPassword;
  }

   @override
  int get hashCode {
    return id.hashCode^  
      authEmail.hashCode ^
      authPassword.hashCode ;
 
  }


}