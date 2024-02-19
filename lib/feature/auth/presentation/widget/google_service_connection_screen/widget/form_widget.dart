import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ReusableTextField extends StatefulWidget {
    ReusableTextField({super.key, required this.text, required this.icon, required this.controller, required this.validator });

  String? text; 
  IconData? icon;
  bool? isPasswordType;
  TextEditingController? controller;
 String? Function(String?)? validator;


  @override
  State<ReusableTextField> createState() => RreusableTextFieldState();
}

class RreusableTextFieldState extends State<ReusableTextField> {
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
    controller: widget.controller,
    obscureText: widget.isPasswordType!,
    enableSuggestions: widget.isPasswordType!,
    autocorrect: widget.isPasswordType!,
    cursorColor: Colors.white,
    validator: widget.validator,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        widget.icon,
        color: Colors.white70,
      ),
      labelText: widget.text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: widget.isPasswordType!
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
      
  );
  }
}