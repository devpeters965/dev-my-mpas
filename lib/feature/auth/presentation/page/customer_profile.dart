
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_track/config/theme/style.dart';
import 'package:real_track/feature/auth/data/data_resource/remote/firebase_path.dart';

class CustomerProfile extends StatelessWidget {
  const CustomerProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.yellow,
      alignment: Alignment.center,
      child:FutureBuilder(
        future: FirebsaPath.getUserDataStream,
         builder: (context, snapshot) {
    
          late List<dynamic> customer = [];
          snapshot.data!.docs.forEach((element)=> 
          customer.add(element)
          );
    
          if(snapshot.connectionState == ConnectionState.waiting){
            print("= les data sur snaphort============================= $snapshot");
    
            return Container(
              child:  const Column(
                children: [
                    Text("Data loading"),
                    SizedBox(height: 12,),
                    CircularProgressIndicator(
                      color: Colors.grey,
                    )
                ],
              ),
    
            );
          }
          if(!snapshot.hasData){
            return Container(
              child: const Column(
                children: [
                    Text("No data"),
                    SizedBox(height: 12,),
                    CircularProgressIndicator(
                      color: Colors.grey,
                    )
                ],
              ),
            );
          }
          return Container(
            height: 100,
            width: 100,
            alignment: Alignment.center,
            // color: Colors.red,
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                final contenu = customer[index];
                print('==================== $contenu');
            
                return Row(
                  children: [

                  Text(contenu['flullname'],
                             style:  GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 17
                              ),),

                  const SizedBox(width: 12),

                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: MyColors.grey,
                      shape: BoxShape.circle
                    ),
                    child: Text('${contenu['marque'].substring(0,2)}' ,
                            style:  GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 30
                            ),
                    ),
                  ),
                  ],
                );
              }),
          );

         },)
       );
  }
}
