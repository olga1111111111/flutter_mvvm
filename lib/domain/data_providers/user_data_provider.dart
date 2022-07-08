// import 'package:flutter_application_mvvm/domain/entity/user.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

import 'package:flutter_application_mvvm/domain/entity/user.dart';

//changeNotifier (или  valueProvider ) или stream чтобы узнавать о переодических изменениях данных

class UserDataProvider {
  Timer? _timer;
  var _user = User(0);
  final _controller = StreamController<User>();
  //получать stream из любого места
  Stream<User> get userStream => _controller.stream.asBroadcastStream();
  User get user => _user;

  void openConnect() {
    if (_timer != null) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _user = User(_user.age + 1);
      _controller.add(_user);
    });
  }

  void closeConnect() {
    _timer?.cancel();
    _timer = null;
  }

  // final sharedPreferences = SharedPreferences.getInstance();

  // Future<User> loadValue() async {
  //   final age = (await sharedPreferences).getInt('age') ?? 0;
  //   return User(age);
  // }

  // Future<void> saveValue(User user) async {
  //   (await sharedPreferences).setInt('age', user.age);
  // }
}
