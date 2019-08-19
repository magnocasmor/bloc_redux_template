import 'package:bloc_redux_example/redux/app_state.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class ProfileViewModel {
  final ImageProvider photo;
  final String userName;
  final ConnectivityResult typeConnection;
  final ConnectionStatus status;

  ProfileViewModel({
    this.userName,
    this.photo,
    this.typeConnection,
    this.status,
  });

  operator ==(object) {
    if (object is ProfileViewModel)
      return this.photo == object.photo &&
          this.userName == object.userName &&
          this.typeConnection == object.typeConnection &&
          this.status == object.status;
    else
      return false;
  }

  /// It's not necessary
  // @override
  // int get hashCode => this.photo.hashCode + this.userName.hashCode;
}
