import 'package:bloc_redux_example/redux/actions.dart';
import 'package:bloc_redux_example/redux/app_state.dart';
import 'package:bloc_redux_example/routes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

final List<Middleware<AppState>> middlewares = [
  TypedMiddleware<AppState, dynamic>(_logMiddleware),
  TypedMiddleware<AppState, ScheduleGlobalDialogAction>(_showDialogMiddleware),
  TypedMiddleware<AppState, HasConnectionAction>(_checkConnection),
];

void _showDialogMiddleware(Store<AppState> store,
    ScheduleGlobalDialogAction action, NextDispatcher next) {
  Future.delayed(
    Duration(seconds: 10),
    () {
      showDialog(
        context: store.state.mainContext,
        builder: (context) {
          return AlertDialog(
            title: Text(action.title),
            content: Text(action.description),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: Routes.pop,
              ),
            ],
          );
        },
      );
    },
  );
}

void _logMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) {
  print('LOG: Dispacth action ${action.runtimeType.toString()}');
  next(action);
}

void _checkConnection(Store<AppState> store, HasConnectionAction action,
    NextDispatcher next) async {
  final result = await http.get('https://www.gstatic.com/generate_204');
  if (action.result == ConnectivityResult.wifi)
    return next(
      WifiConnectionAction(result.statusCode == 204),
    );
  else if (action.result == ConnectivityResult.mobile)
    return next(
      MobileConnectionAction(result.statusCode == 204),
    );
  // else
  //   return next(action);
}
