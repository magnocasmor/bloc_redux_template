import 'package:bloc_redux_example/redux/actions.dart';
import 'package:bloc_redux_example/redux/app_state.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'dart:math' as math;

final Reducer<AppState> reducers = combineReducers<AppState>(
  [
    TypedReducer<AppState, SignInAction>(_signInReducer),
    TypedReducer<AppState, SignOutAction>(_signOutReducer),
    TypedReducer<AppState, ChangeThemeAction>(_changeThemeReducer),
    TypedReducer<AppState, ChangeProfileAction>(_changeProfileReducer),
    TypedReducer<AppState, RegisterMainContextAction>(_registerMainContextReducer),
    TypedReducer<AppState, WifiConnectionAction>(_wifiConnectionReducer),
    TypedReducer<AppState, MobileConnectionAction>(_mobileConnectionReducer),
    TypedReducer<AppState, NoConnectionAction>(_noConnectionReducer),
  ],
);

AppState _signInReducer(AppState state, SignInAction action) {
  return state.copyWith(isAuth: true);
}

AppState _signOutReducer(AppState state, SignOutAction action) {
  return state.copyWith(isAuth: false);
}

AppState _changeThemeReducer(AppState state, ChangeThemeAction action) {
  return state.copyWith(
    appTheme: ThemeData(
      primaryColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
          .withOpacity(1.0),
      accentColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
          .withOpacity(1.0),
    ),
  );
}

AppState _changeProfileReducer(AppState state, ChangeProfileAction action) {
  return state.copyWith(
    userName: action.userName,
    photo: action.photo,
  );
}

AppState _registerMainContextReducer(
    AppState state, RegisterMainContextAction action) {
  return state.copyWith(
    mainContext: action.mainContext,
  );
}

AppState _wifiConnectionReducer(AppState state, WifiConnectionAction action) {
  return state.copyWith(
    result: ConnectivityResult.wifi,
    connectionStatus: action.netoworkingAcess
        ? ConnectionStatus.full_acess
        : ConnectionStatus.only_connected,
  );
}

AppState _mobileConnectionReducer(
    AppState state, MobileConnectionAction action) {
  return state.copyWith(
    result: ConnectivityResult.mobile,
    connectionStatus: action.netoworkingAcess
        ? ConnectionStatus.full_acess
        : ConnectionStatus.only_connected,
  );
}

AppState _noConnectionReducer(AppState state, NoConnectionAction action) {
  return state.copyWith(
    result: ConnectivityResult.none,
    connectionStatus: ConnectionStatus.offline,
  );
}
