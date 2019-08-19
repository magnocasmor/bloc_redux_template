import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ImmutableAction {}

class SignInAction {
  final String userName;

  SignInAction({this.userName});
}

class SignOutAction {}

class ChangeThemeAction {}

class ChangeProfileAction {
  final ImageProvider photo;
  final String userName;

  ChangeProfileAction({
    this.photo,
    this.userName,
  });
}

class ScheduleGlobalDialogAction {
  final String title;
  final String description;

  ScheduleGlobalDialogAction(this.title, this.description);
}

class ScheduleGlobalSnackbarAction {
  final String description;

  ScheduleGlobalSnackbarAction(this.description);
}

class RegisterMainContextAction {
  final BuildContext mainContext;

  RegisterMainContextAction(this.mainContext);
}

class HasConnectionAction {
  final ConnectivityResult result;

  HasConnectionAction(this.result);
}

class WifiConnectionAction {
  final bool netoworkingAcess;

  WifiConnectionAction(this.netoworkingAcess);
}

class MobileConnectionAction {
  final bool netoworkingAcess;

  MobileConnectionAction(this.netoworkingAcess);
}

class NoConnectionAction {}
