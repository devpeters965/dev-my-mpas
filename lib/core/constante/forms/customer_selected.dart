import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerSelected extends StatelessWidget {
      CustomerSelected({super.key, required this.inputTitle,   this.label, this.validator, required this.items, this.selectValue, this.onChanged});

  

  final String inputTitle;
  // late Object? infoHeure;
  final String? label;
  final dropValues = ValueNotifier('_value');
  final  String? Function(Object?)? validator;
  final List items;
  Object? selectValue; 
  final void Function(Object?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder(
      valueListenable: dropValues,
       builder: ((context, value, child) {
      return  Padding(
              padding:  const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(label!,style:  GoogleFonts.poppins(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400),),
                  ),
                  
                  DropdownButtonFormField(
                   style:  GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16,),
                          hint: Text(inputTitle,style:  GoogleFonts.poppins(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w400),),
                           iconDisabledColor: Colors.black,
                           iconEnabledColor: Colors.black,
                          focusColor: Colors.black,
                          dropdownColor: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5),
                          decoration: InputDecoration(
                            fillColor: Colors.grey[200],
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            )
                          ),
                          elevation: 2,
                          selectedItemBuilder: (context) {
                            return  List.generate(items.length, (index) {
                            return DropdownMenuItem(child: Text(items[index]));
                            });
                          },
                          items: List.generate(
                            items.length, (index) => DropdownMenuItem(
                            value: items[index],
                            enabled: true,
                            child: Text(items[index]))), 
                            onChanged: onChanged
                   ),

                ],
              )
        );
    }));
      
  }

} 











  