import 'dart:convert';

import 'package:bloc_redux_example/blocs/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:http/http.dart' as http;

class ColorSchemeBloc extends BaseBloc<ColorSchemeState> {
  final _state = BehaviorSubject<ColorSchemeState>();

  final Color themeColor;

  ColorSchemeBloc(this.themeColor) {
    generateColorScheme();
  }

  @override
  void addError(ColorSchemeState state) {
    _state.addError(state);
  }

  @override
  void addState(ColorSchemeState state) {
    _state.add(state);
  }

  @override
  ColorSchemeState get initialState => LoadingColorSchemeState();

  @override
  Stream<ColorSchemeState> get stream => _state.stream.distinct();

  void generateColorScheme() async {
    try {
      addState(LoadingColorSchemeState());
      String colorString = themeColor.toString();
      String valueString =
          colorString.split('(0x')[1].split(')')[0].split('ff')[1];
          
      final scheme =
          await http.get('https://www.thecolorapi.com/scheme?hex=$valueString');
      final Map result = json.decode(scheme.body);

      final List schemes = result['colors'].map((color) {
        return int.parse('FF' + color['hex']['clean'], radix: 16);
      }).toList();
      addState(GeneratedColorSchemeState(schemes));
    } catch (e) {
      addError(ErrorColorSchemeState(e.message));
    }
  }
}

abstract class ColorSchemeState {}

class LoadingColorSchemeState extends ColorSchemeState {}

class GeneratedColorSchemeState extends ColorSchemeState {
  final List generatedSchemes;

  GeneratedColorSchemeState(this.generatedSchemes);
}

class ErrorColorSchemeState extends ColorSchemeState {
  final String message;

  ErrorColorSchemeState(this.message);
}
