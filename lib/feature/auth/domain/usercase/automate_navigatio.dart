import 'package:flutter/material.dart';

class AutomateNavigator{
  static void getScreen(int timer, BuildContext context,  screen){
     Future.delayed(const Duration(seconds: 1)).then((value) =>
     Navigator.push(context, MaterialPageRoute(
      builder: (context)=> screen
     )));
  }
}