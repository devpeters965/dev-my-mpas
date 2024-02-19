import 'package:real_track/feature/auth/data/data_resource/local/local_service.dart';
import 'package:real_track/feature/auth/data/data_resource/remote/serice/serive_send_otp.dart';
import 'package:real_track/feature/auth/domain/usercase/search_user/search_user.dart';

class UserCase {
  UserCase._();
  static LocalService usercase = LocalService();
  static ServiceOTP serviceOTP = ServiceOTP();
  // static SearchUser searchUser = SearchUser();
  static LocalServiceGoogle usercaseGoogle = LocalServiceGoogle();

}