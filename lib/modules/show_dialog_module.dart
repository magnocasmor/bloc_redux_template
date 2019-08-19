import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bloc_redux_example/blocs/show_dialog_bloc.dart';
import 'package:bloc_redux_example/screens/bloc_examples/show_dialog_screen.dart';
import 'package:flutter/material.dart';

class ShowDialogModule extends ModuleWidget {
  @override
  List<Bloc<BlocBase>> get blocs => [
        Bloc((inject) => ShowDialogBloc()),
      ];

  @override
  List<Dependency> get dependencies => null;

  @override
  Widget get view => ShowDialogScreen();

  static Inject get to => Inject<ShowDialogModule>.of();
}
