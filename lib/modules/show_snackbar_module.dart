import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bloc_redux_example/blocs/show_snackbar_bloc.dart';
import 'package:bloc_redux_example/screens/bloc_examples/show_snackbar_screen.dart';
import 'package:flutter/material.dart';

class ShowSnackBarModule extends ModuleWidget {
  @override
  List<Bloc<BlocBase>> get blocs => [
        Bloc(
          (inject) => ShowSnackBarBloc(),
        ),
      ];

  @override
  List<Dependency> get dependencies => null;

  @override
  Widget get view => ShowSnackbarScreen();

  static Inject get to => Inject<ShowSnackBarModule>.of();
}
