
import 'package:url_launcher/url_launcher.dart';

class DeepLink{

  DeepLink._();   
    static Future<void> linkLuncker(String emails)async{
      final Uri lunchMail = Uri.parse('mailto:'+emails);
    if(!await launchUrl(lunchMail,
     mode: LaunchMode.externalApplication)){
      throw Exception('Url invalide $lunchMail');
    }
  }

 static Future<void> contactLuncher(String contact) async{
  final Uri contactLunch = Uri.parse('tel:'+contact);
   if(!await launchUrl(contactLunch,
     mode: LaunchMode.externalApplication)){
      throw Exception('Url invalide $contactLunch');
    }

  }



}