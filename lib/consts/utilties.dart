

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

///convert string to double
double stringToDouble(String text) {
  String englishText = text.toEnglishDigit();

  return double.parse(englishText.replaceAll(RegExp(r'[^0-9.-]'), ''))
      .toDouble();
}


 Future<String> getDeviceInfo()async{
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if(Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id;
  }
  if(Platform.isWindows) {
    WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
    return windowsInfo.deviceId;
  }
  if(Platform.isIOS){
   IosDeviceInfo iosInfo=await deviceInfo.iosInfo;
   return iosInfo.model;
  }
return "public info";
}