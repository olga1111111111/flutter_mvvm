// import 'dart:math';

import 'package:flutter_application_mvvm/domain/data_providers/user_data_provider.dart';
import 'package:flutter_application_mvvm/domain/entity/user.dart';

typedef UserServiceOnUpdate = void Function(User);

class UserService {
  final _userDataProvider = UserDataProvider();
  // VoidCallback? _currentOnUpdate;
  // геттер прокидывает текущее значение user из провайдера
  User get user => _userDataProvider.user;
  Stream<User> get userStream => _userDataProvider.userStream;

  void openConnect() => _userDataProvider.openConnect();
  void closeConnect() => _userDataProvider.closeConnect();

  // // сервис должен открыть соединение и начать обновлять события
  // void startListenUser(UserServiceOnUpdate onUpDate) {
  //   //l.89
  //   final currentOnUpdate = () {
  //     onUpDate(_userDataProvider.user);
  //   };
  //   _currentOnUpdate = currentOnUpdate;
  //   // сначала подписываюсь
  //   _userDataProvider.addListener(currentOnUpdate);
  //   // вызываю onUpdate()с текущим значением
  //   onUpDate(_userDataProvider.user);
  //   //  открываю connect
  //   _userDataProvider.openConnect();
  // }

  // void stopListenUser() {
  //   final currentOnUpdate = _currentOnUpdate;
  //   if (currentOnUpdate != null) {
  //     _userDataProvider.removeListener(currentOnUpdate);
  //   }
  // }
  // var _user = User(0);
  // User get user => _user;

  // Future<void> initialize() async {
  //   _user = await _userDataProvider.loadValue();
  // }

  // void incrementAge() async {
  //   _user = _user.copyWith(age: _user.age + 1);
  //   _userDataProvider.saveValue(_user);
  // }

  // void decrementAge() async {
  //   _user = _user.copyWith(age: max(_user.age - 1, 0));
  //   _userDataProvider.saveValue(_user);
  // }
}
