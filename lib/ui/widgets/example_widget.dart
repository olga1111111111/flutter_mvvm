import 'package:flutter/material.dart';
import 'package:flutter_application_mvvm/domain/blocs/users_bloc.dart';

import 'package:provider/provider.dart';



class ExampleWidget extends StatelessWidget {
  const ExampleWidget({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              _AgeTitle(),
              _AgeIncrementWidget(),
              _AgeDecrementWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AgeTitle extends StatelessWidget {
  const _AgeTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UsersBloc>();

    return StreamBuilder<UsersState>(
        initialData: bloc.state,
        stream: bloc.stream,
        builder: (context, snapshot) {
          final age = snapshot.requireData.currentUser.age;
          return Text('$age');
        });
  }
}

class _AgeIncrementWidget extends StatelessWidget {
  const _AgeIncrementWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UsersBloc>();
    return ElevatedButton(
      onPressed: bloc.incrementAge,
      child: const Text('+'),
    );
  }
}

class _AgeDecrementWidget extends StatelessWidget {
  const _AgeDecrementWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UsersBloc>();
    return ElevatedButton(
      onPressed: bloc.decrementAge,
      child: const Text('-'),
    );
  }
}
