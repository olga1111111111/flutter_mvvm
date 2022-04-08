import 'package:flutter/material.dart';
import 'package:flutter_application_mvvm/ui/navigation/main_navigation.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_mvvm/domain/data_providers/auth_api_provider.dart';
import 'package:flutter_application_mvvm/domain/services/auth_service.dart';

enum _ViewModelAuthButtonState { canSubmit, authProcess, disable }

class _ViewModelState {
  // final String authErrorTitle;
  // final String login;
  // final String password;
  // final bool isAuthInProcess;

  String authErrorTitle = '';
  String login = '';
  String password = '';
  bool isAuthInProcess = false;

  var _authButtonState = _ViewModelAuthButtonState.disable;

  _ViewModelAuthButtonState get authButtonState {
    if (isAuthInProcess) {
      _authButtonState = _ViewModelAuthButtonState.authProcess;
    } else if (login.isNotEmpty && password.isNotEmpty) {
      _authButtonState = _ViewModelAuthButtonState.canSubmit;
    }

    return _authButtonState;
  }

  _ViewModelState(
      //   {
      //   this.authErrorTitle = '',
      //   this.login = '',
      //   this.password = '',
      //   this.isAuthInProcess = false,
      // }
      );

  // _ViewModelState copyWith({
  //   String? authErrorTitle,
  //   String? login,
  //   String? password,
  //   bool? isAuthInProcess,
  // }) {
  //   return _ViewModelState(
  //     authErrorTitle: authErrorTitle ?? this.authErrorTitle,
  //     login: login ?? this.login,
  //     password: password ?? this.password,
  //     isAuthInProcess: isAuthInProcess ?? this.isAuthInProcess,
  //   );
  // }
}

class _ViewModel extends ChangeNotifier {
  final _authService = AuthService();
  // var _state = _ViewModelState();
  final _state = _ViewModelState();
  _ViewModelState get state => _state;

  void changeLogin(String value) {
    if (_state.login == value) return;
    // _state = _state.copyWith(login: value);
    _state.login = value;
    notifyListeners();
  }

  void changePassword(String value) {
    if (_state.password == value) return;
    // _state = _state.copyWith(password: value);
    _state.password = value;
    notifyListeners();
  }

  Future<void> onAuthButtonPressed(BuildContext context) async {
    final login = _state.login;
    final password = _state.password;

    if (login.isEmpty || password.isEmpty) return;

    // _state = _state.copyWith(authErrorTitle: '', isAuthInProcess: true);
    _state.authErrorTitle = '';
    _state.isAuthInProcess = true;

    notifyListeners();

    try {
      await _authService.login(login, password);
      // _state = _state.copyWith(isAuthInProcess: false);
      _state.isAuthInProcess = false;
      notifyListeners();
      MainNavigation.showLoader(context);
    } on AuthApiProviderIncorectLoginDataError {
      // _state = _state.copyWith(
      //     authErrorTitle: 'Неправильный логин или пароль',
      //     isAuthInProcess: false);
      _state.authErrorTitle = 'Неправильный логин или пароль';
      _state.isAuthInProcess = false;

      notifyListeners();
    } catch (exeption) {
      // _state = _state.copyWith(
      //     authErrorTitle: 'случилась неприятность, попробуйте повторить позже',
      //     isAuthInProcess: false);
      // notifyListeners();
      _state.authErrorTitle =
          'случилась неприятность, попробуйте повторить позже';
      _state.isAuthInProcess = false;
    }
  }
}

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key}) : super(key: key);
  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => _ViewModel(),
      child: const AuthWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              _ErrorTitleWidget(),
              SizedBox(
                height: 10,
              ),
              _LoginWidget(),
              SizedBox(
                height: 10,
              ),
              _PasswordWidget(),
              SizedBox(
                height: 10,
              ),
              AuthButtonWidget(),
            ],
          ),
        ),
      ),
    ));
  }
}

class _LoginWidget extends StatelessWidget {
  const _LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Логин',
        border: OutlineInputBorder(),
      ),
      onChanged: model.changeLogin,
    );
  }
}

class _PasswordWidget extends StatelessWidget {
  const _PasswordWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Пароль',
        border: OutlineInputBorder(),
      ),
      onChanged: model.changePassword,
    );
  }
}

class _ErrorTitleWidget extends StatelessWidget {
  const _ErrorTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authErrorTitle =
        context.select((_ViewModel value) => value.state.authErrorTitle);
    return Text(authErrorTitle);
  }
}

class AuthButtonWidget extends StatelessWidget {
  const AuthButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    final authButtonState =
        context.select((_ViewModel value) => value.state.authButtonState);
    final onPressed = authButtonState == _ViewModelAuthButtonState.canSubmit
        ? model.onAuthButtonPressed
        : null;
    final child = authButtonState == _ViewModelAuthButtonState.authProcess
        ? const CircularProgressIndicator()
        : const Text('авторизоваться');
    return ElevatedButton(
      onPressed: () => onPressed?.call(context),
      child: child,
    );
  }
}
