import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../data_providers/user_data_provider.dart';
import '../entity/user.dart';

class UsersState {
  final User currentUser;

//<editor-fold desc="Data Methods">

  const UsersState({
    required this.currentUser,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsersState &&
          runtimeType == other.runtimeType &&
          currentUser == other.currentUser);

  @override
  int get hashCode => currentUser.hashCode;

  @override
  String toString() {
    return 'UsersState{  currentUser: $currentUser, }';
  }

  UsersState copyWith({
    User? currentUser,
  }) {
    return UsersState(
      currentUser: currentUser ?? this.currentUser,
    );
  }

//</editor-fold>
}

abstract class UsersEvents {}

class UsersIncrementEvent implements UsersEvents {}

class UsersDecrementEvent implements UsersEvents {}

class UsersInitializeEvent implements UsersEvents {}

class UsersBloc extends Bloc<UsersEvents, UsersState> {
  final _userDataProvider = UserDataProvider();

  UsersBloc() : super(UsersState(currentUser: User(0))) {
    on<UsersEvents>((event, emit) async {
      if (event is UsersInitializeEvent) {
        final user = await _userDataProvider.loadValue();
        emit(UsersState(currentUser: user));
      } else if (event is UsersIncrementEvent) {
        var user = state.currentUser;
        user = user.copyWith(age: user.age + 1);
        await _userDataProvider.saveValue(user);
        emit(UsersState(currentUser: user));
      } else if (event is UsersDecrementEvent) {
        var user = state.currentUser;
        user = user.copyWith(age: max(user.age - 1, 0));
        //заставляю функцию ждать сохранения
        await _userDataProvider.saveValue(user);
        emit(UsersState(currentUser: user));
      }
    },
        transformer: sequential());
    // on<UsersInitializeEvent>((event, emit) async{
    //   final user = await _userDataProvider.loadValue();
    //   emit(UsersState(currentUser: user));
    // });
    // on<UsersIncrementEvent>((event, emit) async {
    //   var  user = state.currentUser;
    //   user = user.copyWith(age: user.age +1);
    //   await _userDataProvider.saveValue(user);
    //   emit(UsersState(currentUser: user));
    // });
    // on<UsersDecrementEvent>((event, emit) async{
    //   var user = state.currentUser;
    //   user = user.copyWith(age:max(user.age - 1, 0) );
    //   await _userDataProvider.saveValue(user);
    //   emit(UsersState(currentUser: user));
    // });

  }
}


  /*
   var _state = UsersState(
    currentUser: User(0),
  );
  final _eventController = StreamController<UsersEvents>.broadcast();
  late final Stream<UsersState> _stateStream;

  UsersState get state => _state;
  Stream<UsersState> get stream => _stateStream;

  void dispatch(UsersEvents event) {
    _eventController.add(event);
  }
  UsersBloc() {
    _stateStream = _eventController.stream
        .asyncExpand<UsersState>(_mapEventToState)
        .asyncExpand(_updateState)
        .asBroadcastStream();

    // _stateStream.listen((event) {});
    dispatch(UsersInitializeEvent());
  }
  Stream<UsersState> _updateState(UsersState state) async* {
    if (_state == state) return;
    _state = state;
    yield state;
  }
  Stream<UsersState> _mapEventToState(UsersEvents event) async* {
    if (event is UsersInitializeEvent) {
      final user = await _userDataProvider.loadValue();
      yield UsersState(currentUser: user);
    } else if (event is UsersIncrementEvent) {
      var user = _state.currentUser;
      user = user.copyWith(age: user.age + 1);
      await _userDataProvider.saveValue(user);
      yield UsersState(currentUser: user);
    } else if (event is UsersDecrementEvent) {
      var user = _state.currentUser;
      user = user.copyWith(age: max(user.age - 1, 0));
      //заставляю функцию ждать сохранения
      await _userDataProvider.saveValue(user);
      yield UsersState(currentUser: user);
    }
   */




//   void _updateState(UsersState state) {
//     if (_state == state) return; //исключить повторное обновление интерфейса
//     _state = state;
//     _userDataProvider.saveValue(_state.currentUser);
//     _stateController.add(state);
//   }
//
//   Future<void> _initialize() async {
//     final user = await _userDataProvider.loadValue();
//     _updateState(_state.copyWith(currentUser: user));
//   }
//
//   void incrementAge() async {
//     var user = _state.currentUser;
//     user = user.copyWith(age: user.age + 1);
//
//     _updateState(_state.copyWith(currentUser: user));
//
// // //coхраняем новое значение в state и затем - в хранилище
// //   _state = _state.copyWith(currentUser: user);
// //    await _userDataProvider.saveValue( user);
//   }
//
//   void decrementAge() async {
//     var user = _state.currentUser;
//     user = user.copyWith(age: max(user.age - 1, 0));
//     _updateState(_state.copyWith(currentUser: user));
//   }

