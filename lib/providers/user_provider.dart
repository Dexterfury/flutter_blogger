import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_blogger/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  // constructor
  UserProvider({UserModel? user}) : _user = user;

  UserModel? get user => _user;

  // update user name
  void updateName(String name) {
    _user!.name = name;
    notifyListeners();

    // save to shared preferences
    saveUserData();
  }

  // update user image
  void updateImage(File fileImage) {
    _user!.imageUrl = File(fileImage.path).path;
    notifyListeners();

    // save to shared preferences
    saveUserData();
  }

  // save userData to shared preferences
  void saveUserData() async {
    // save to shared preferences
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('user', jsonEncode(_user!.toJson()));
  }

  // get userData from shared preferences
  Future<UserModel> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userString = sharedPreferences.getString('user');
    if (userString != null) {
      _user = UserModel.fromJson(jsonDecode(userString));
      return _user!;
    }
    return UserModel(
      id: 0,
      name: 'User123',
      email: 'dexterfury@test.com',
      imageUrl: '',
    );
  }
}
