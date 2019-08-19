import 'package:bloc_redux_example/modules/color_scheme_module.dart';
import 'package:bloc_redux_example/modules/networking_fetch_module.dart';
import 'package:bloc_redux_example/modules/show_dialog_module.dart';
import 'package:bloc_redux_example/modules/show_snackbar_module.dart';
import 'package:bloc_redux_example/screens/bloc_examples/bloc_examples_screen.dart';
import 'package:bloc_redux_example/screens/home_screen.dart';
import 'package:bloc_redux_example/screens/redux_examples/profile_change_screen.dart';
import 'package:bloc_redux_example/screens/redux_examples/redux_example_screen.dart';
import 'package:bloc_redux_example/screens/redux_examples/schedule_dialog_screen.dart';
import 'package:bloc_redux_example/screens/unknown_route_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Interface para navegar no app
abstract class Routes {
  static final navKey = GlobalKey<NavigatorState>();

  static const String HOME = '/';
  static const String BLOC_EXAMPLES = '/bloc_examples';
  static const String REDUX_EXAMPLES = '/redux_examples';
  static const String BLOC_REDUX_EXAMPLES = '/bloc_redux_examples';
  static const String NETWORKING_FETCH = '/networking_fetch';
  static const String SHOW_DIALOG = '/show_dialog_bloc';
  static const String SHOW_SNACKBAR = '/show_snackbar_bloc';
  static const String PROFILE_CHANGE = '/profile_change';
  static const String SCHEDULE_DIALOG = '/schedule_global_dialog';

  /// Mapea a rota de seu nome para a tela especifica
  static Widget _routeFromName(RouteSettings settings) {
    switch (settings.name) {
      case HOME:
        return HomeScreen();
      case BLOC_EXAMPLES:
        return BlocExampleScreen();
      case REDUX_EXAMPLES:
        return ReduxExampleScreen();
      case NETWORKING_FETCH:
        return NetworkingFetchModule();
      case SHOW_DIALOG:
        return ShowDialogModule();
      case SHOW_SNACKBAR:
        return ShowSnackBarModule();
      case PROFILE_CHANGE:
        return ProfileChangeScreen();
      case SCHEDULE_DIALOG:
        return ScheduleDialogScreen();
      case BLOC_REDUX_EXAMPLES:
        return ColorSchemeModule();
      default:
        return UnknownRouteScreen(
          unknownRoute: settings.name,
        );
    }
  }

  static MaterialPageRoute route(RouteSettings settings) {
    final route = _routeFromName(settings);
    return MaterialPageRoute(
      builder: (context) => route,
      settings: settings,
    );
  }

  static NavigatorState get _navState => navKey.currentState;

  static Future<T> push<T>(String routeName,
      {Map<String, dynamic> arguments}) async {
    return await _navState.pushNamed<T>(routeName, arguments: arguments);
  }

  static Future<T> pushAndRemoveUntil<T>(String routeName,
      {String retainRoute, Map<String, dynamic> arguments}) async {
    return await _navState.pushNamedAndRemoveUntil<T>(
      routeName,
      retainRoute is String
          ? ModalRoute.withName(retainRoute)
          : (route) => false,
      arguments: arguments,
    );
  }

  static void popUntil<T>(String routeName) {
    return _navState.popUntil(
      ModalRoute.withName(routeName),
    );
  }

  static bool pop<T>([T value]) {
    return _navState.pop<T>(value);
  }

  /// Só retira a tela da pilha se ele não for a primeira, para evitar a pilha ficar sem tela ou finalizar o app
  static Future<bool> maybePop<T>([T result]) async {
    return await _navState.maybePop<T>(result);
  }
}
