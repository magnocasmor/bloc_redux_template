import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bloc_redux_example/blocs/color_scheme_bloc.dart';
import 'package:bloc_redux_example/screens/bloc_redux_example/color_scheme_screen.dart';
import 'package:flutter/material.dart';

class ColorSchemeModule extends ModuleWidget {
  @override
  List<Bloc<BlocBase>> get blocs => [
        Bloc((inject) => ColorSchemeBloc(inject.params['color']), singleton: false),
      ];

  @override
  List<Dependency> get dependencies => null;

  @override
  Widget get view => ColorSchemeScreen();

  static Inject get to => Inject<ColorSchemeModule>.of();
}
