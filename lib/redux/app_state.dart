
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

enum ConnectionStatus { full_acess, only_connected, offline, none }

class AppState {
  final String userName;
  final ImageProvider photo;
  final ThemeData appTheme;
  final BuildContext mainContext;
  final ConnectivityResult result;
  final ConnectionStatus connectionStatus;

  AppState({
    this.userName,
    this.photo,
    this.appTheme,
    this.mainContext,
    this.result,
    this.connectionStatus,
  });

  factory AppState.initialState() {
    return AppState(
      userName: 'Jubscleiton',
      photo: NetworkImage('https://source.unsplash.com/featured/?face'),
      result: ConnectivityResult.none,
      connectionStatus: ConnectionStatus.none,
    );
  }

  AppState copyWith({
    ImageProvider photo,
    String userName,
    bool isAuth,
    ThemeData appTheme,
    BuildContext mainContext,
    GlobalKey<ScaffoldState> mainScaffold,
    ConnectivityResult result,
    ConnectionStatus connectionStatus,
  }) =>
      AppState(
        userName: userName ?? this.userName,
        photo: photo ?? this.photo,
        appTheme: appTheme ?? this.appTheme,
        mainContext: mainContext ?? this.mainContext,
        result: result ?? this.result,
        connectionStatus: connectionStatus ?? this.connectionStatus,
      );
}
