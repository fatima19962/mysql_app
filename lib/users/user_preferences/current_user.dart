

import 'package:get/get.dart';
import 'package:mysql_app/models/user.dart';

class CurrentUser extends GetxController{

 final Rx<User> _currentUser =const User(name: "name", email: "email", pass: "pass").obs;
 User get user => _currentUser.value;

 // getUserInfo() async{
 //  User? getUserInfoFromLocalStorage= await UserPrefs.readUser();
 //  _currentUser.value=getUserInfoFromLocalStorage!;
 // }
}