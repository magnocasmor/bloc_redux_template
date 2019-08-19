import 'package:bloc_redux_example/redux/actions.dart';
import 'package:bloc_redux_example/redux/app_state.dart';
import 'package:bloc_redux_example/redux/middlewares.dart';
import 'package:bloc_redux_example/redux/reducer.dart';
import 'package:bloc_redux_example/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:connectivity/connectivity.dart';

void main() {
  final store = Store<AppState>(
    reducers,
    middleware: middlewares,
    distinct: true,
    initialState: AppState.initialState(),
  );
  Connectivity()
      .onConnectivityChanged
      .distinct()
      .listen((ConnectivityResult result) {
    if (result == ConnectivityResult.none)
      store.dispatch(NoConnectionAction());
    else
      store.dispatch(HasConnectionAction(result));
  });

  ///onConnectivityChanged only catch changes, so we may check connection status when run the code
  Connectivity().checkConnectivity().then((result) {
    if (result == ConnectivityResult.none)
      store.dispatch(NoConnectionAction());
    else
      store.dispatch(HasConnectionAction(result));
  });

  runApp(MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final Store store;
  const MyApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, ThemeData>(
        converter: (store) => store.state.appTheme,
        distinct: true,
        builder: (context, appTheme) {
          return MaterialApp(
            title: 'Bloc + Redux App Demo',
            theme: appTheme,
            navigatorKey: Routes.navKey,
            onGenerateRoute: Routes.route,
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.HOME,
          );
        },
      ),
    );
  }
}
