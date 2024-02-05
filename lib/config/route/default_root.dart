import 'package:flutter/material.dart';

class MyRoot{

  MyRoot._();

  static void nextNavigation(BuildContext context, nextScreen){
    Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => nextScreen // Remplacez SecondScreen par le nom de votre écran cible.
    ),
  );
  }


  static void backNavigation(BuildContext context){
    Navigator.of( context).pop();
  }






}