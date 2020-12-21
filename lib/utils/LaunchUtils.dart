
import 'package:url_launcher/url_launcher.dart';

class LaunchUtils{
  static makeCall(String phoneNo){
   launch("tel://$phoneNo");
  }
}