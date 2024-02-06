
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:real_track/feature/auth/data/model/user_info.dart';
import 'package:real_track/feature/auth/presentation/page/profile_view_flow.dart';
import 'package:url_launcher/url_launcher.dart';


class UserMenu extends StatefulWidget {
  const UserMenu({super.key});
 

  @override
  State<UserMenu> createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {

  final Uri _uri = Uri.parse('https://dev-y0ca.onrender.com');
  final Uri _uri1 = Uri.parse('mailto:devpeters965@gmail.com');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
           accountName:  Text( 'Real truck'),
           accountEmail: Text(''),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(
              child: Image.network('https://images.pexels.com/photos/6652302/pexels-photo-6652302.jpeg?auto=compress&cs=tinysrgb&w=600',fit: BoxFit.cover,width:90, height: 90 ,)   ),    
          ),
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          ),

          
            ListTile(
              title: const Text('Creer Profile'),
              leading:  Icon(Icons.signpost_rounded,color: Colors.teal.shade300,),
              onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProfileViewFlow()))
              ),

                 
            ListTile(
              title: const Text('Call back'),
              leading:  Icon(Icons.email,color: Colors.teal.shade300,),
              // onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context)=>  MyFormNavigator())),
              onTap: urlLuancher1
            ),
          
            ListTile(
              title: const Text('About us'),
              leading:  Icon(Icons.language_rounded,color: Colors.teal.shade300,),
              onTap: urlLuancher,
            ),
          
           const Divider(height: 3,color: Colors.grey,),

            ListTile(
              title:  const Text('Exit'),
              leading:   const Icon(Icons.power_settings_new_rounded,color: Color.fromARGB(255, 255, 41, 41),),
              onTap: () {
                if(Platform.isAndroid){
                  exit(0);
                }
              },
            ),
        ],
        ),);
  }

   Future<void> urlLuancher()async{
    if(!await launchUrl(_uri)){
      throw Exception('Url invalide $_uri');
    }
  }

   Future<void> urlLuancher1()async{
    if(!await launchUrl(_uri1)){
      throw Exception('Url invalide $_uri1');
    }
  }
}



