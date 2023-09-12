import 'package:flutter/material.dart';
import 'package:mysql_app/models/subscription.dart';
import 'package:mysql_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  Subscription? _subs;
  Subscription? get subs => _subs;
  User? _user;
  User? get user => _user;

  ///get user object from local storage
  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userInfo = prefs.getString("currentUser");
    if (userInfo != null) {
      _user = User.fromJson(userInfo);
    }
  }

  ///set user object to local storage
  setUser(User userGet) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("currentUser", userGet.toJson());
    _user = userGet;

    notifyListeners();
  }

  bool _isAuthentificated = false;

  bool get isAuthentificated {
    return this._isAuthentificated;
  }

  set isAuthentificated(bool newVal) {
    this._isAuthentificated = newVal;
    this.notifyListeners();
  }

  ///remove user object from local storage
  removeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("currentUser");
    prefs.remove("currentSubs");
    _user = null;
    _subs = null;
    notifyListeners();
  }

  ///level up user
  void levelUpUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _user = User(
        name: _user!.name,
        email: _user!.email,
        pass: _user!.pass,
        phoneNumber: _user!.phoneNumber,
        level: 1);
    prefs.setString("currentUser", _user!.toJson());
    notifyListeners();
  }

  setSubscription(Subscription subscription) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("currentSubs", subscription.toJson());
    print(_subs);
    _subs = subscription;
    notifyListeners();
  }

  getSubscription() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? subsInfo = prefs.getString("currentSubs");
    if (subsInfo != null) {
      _subs = Subscription.fromJson(subsInfo);
    }

    notifyListeners();
  }
}
