import 'package:bloc_redux_example/screens/bloc_examples/networking_fetch_screen.dart';
import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bloc_redux_example/blocs/networking_fetch_bloc.dart';

class NetworkingFetchModule extends ModuleWidget {

  @override
  List<Bloc<BlocBase>> get blocs => [
        Bloc((inject) => NetworkingFetchBloc()),
      ];

  @override
  List<Dependency> get dependencies => null;

  @override
  Widget get view => NetworkingFetchScreen();

  static Inject get to => Inject<NetworkingFetchModule>.of();
}
