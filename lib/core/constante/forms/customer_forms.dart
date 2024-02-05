import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerForm extends StatelessWidget {
  const CustomerForm({super.key, required this.label, this.nombreLigne, this.textInputType,  this.textController, this.validation, this.ontaP, this.onChanged});

final String label;
  final int? nombreLigne;
  final TextInputType? textInputType;
  final TextEditingController? textController;
  final String? Function(String?)? validation;
  final void Function()? ontaP;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 12),
      child: Column(
        children: [
          TextFormField(
          controller: textController,
          maxLines: nombreLigne,
          keyboardType: textInputType,
          style:  GoogleFonts.poppins(color: Colors.black),
          decoration: InputDecoration(
            label:  Text(label,style:  GoogleFonts.poppins(color: Colors.black),),
            fillColor: Colors.grey.shade200,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none
            )
          ),
          validator:validation ,
          onTap: ontaP,
          onChanged: onChanged,
        ),
        ],
      ),
    );
  }
} 