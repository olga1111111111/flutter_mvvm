import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_mvvm/domain/entity/user.dart';
import 'package:flutter_application_mvvm/domain/services/auth_service.dart';
import 'package:flutter_application_mvvm/domain/services/user_service.dart';
import 'package:flutter_application_mvvm/ui/navigation/main_navigation.dart';
import 'package:provider/provider.dart';

class _ViewModelState {
  final String ageTitle;
  _ViewModelState({
    required this.ageTitle,
  });
}

class _ViewModel extends ChangeNotifier {
  final _authService = AuthService();
  final _userService = UserService();
  var _state = _ViewModelState(ageTitle: '');
  _ViewModelState get state => _state;
  StreamSubscription<User>? userSubscription;

  // void loadValue() async {
  //   await _userService.initialize();
  //   _updateState();
  // }

  _ViewModel() {
    _state = _ViewModelState(
      ageTitle: _userService.user.age.toString(),
    );
    userSubscription = _userService.userStream.listen((user) {
      _state = _ViewModelState(ageTitle: _userService.user.age.toString());
      notifyListeners();
    });
    _userService.openConnect();

    // loadValue();
    // _userService.loadValue().then((_) => notifyListeners());
  }
  @override
  void dispose() {
    userSubscription?.cancel();
    _userService.closeConnect();
    super.dispose();
  }

  // Future<void> onIncrementButtonPressed() async {
  //   _userService.incrementAge();
  //   // _state = ViewModelState(ageTitle: _userService.user.age.toString());
  //   // notifyListeners();
  //   _updateState();
  // }

  // Future<void> onDecrementButtonPressed() async {
  //   _userService.decrementAge();
  //   _updateState();
  // }

  // void _updateState() {
  //   final user = _userService.user;
  //   _state = _ViewModelState(ageTitle: user.age.toString());
  //   notifyListeners();
  // }

  Future<void> onLogoutPressed(BuildContext context) async {
    await _authService.logout();

    MainNavigation.showLoader(context);
  }
}

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({Key? key}) : super(key: key);

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => _ViewModel(),
      child: const ExampleWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<_ViewModel>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
              onPressed: () => viewModel.onLogoutPressed(context),
              child: const Text('выход')),
        ],
      ),
      body: const SafeArea(
        child: Center(child: _AgeTitle()),
      ),
    );
  }
}

class _AgeTitle extends StatelessWidget {
  const _AgeTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = context.select((_ViewModel vm) => vm.state.ageTitle);
    return Text(title);
  }
}

// class _AgeIncrementWidget extends StatelessWidget {
//   const _AgeIncrementWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final viewModel = context.read<_ViewModel>();
//     return ElevatedButton(
//       onPressed: viewModel.onIncrementButtonPressed,
//       child: const Text('+'),
//     );
//   }
// }

// class _AgeDecrementWidget extends StatelessWidget {
//   const _AgeDecrementWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final viewModel = context.read<_ViewModel>();
//     return ElevatedButton(
//       onPressed: viewModel.onDecrementButtonPressed,
//       child: const Text('-'),
//     );
//   }
// }
