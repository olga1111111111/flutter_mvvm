import 'dart:math';

import 'package:flutter_application_mvvm/domain/entity/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  var _user = User(0);
  User get user => _user;

  Future<void> loadValue() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final age = sharedPreferences.getInt('age') ?? 0;
    _user = User(age);
  }

  Future<void> saveValue() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('age', _user.age);
  }

  void incrementAge() async {
    _user = _user.copyWith(age: _user.age + 1);
  }

  void decrementAge() async {
    _user = _user.copyWith(age: max(_user.age - 1, 0));
  }
}
