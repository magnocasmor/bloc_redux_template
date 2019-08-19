import 'package:rxdart/rxdart.dart';

mixin SnackBarStreamMixin {
  final _snackBarState = BehaviorSubject<SnackBarState>();

  void snackBarListen(void Function(SnackBarState) onData) {
    _snackBarState.stream.distinct().listen(onData);
  }

  void showSnackBar({String title, String description}) {
    _snackBarState.add(ShowSnackBarState(
      title: title,
      description: description,
    ));
  }

  void hideSnackBar() {
    _snackBarState.add(HideSnackBarState());
  }

  void disposeSnackBarStream() {
    _snackBarState.close();
  }
}

abstract class SnackBarState {}

class ShowSnackBarState extends SnackBarState {
  final String title;
  final String description;

  ShowSnackBarState({this.title, this.description});
}

class HideSnackBarState extends SnackBarState {}
