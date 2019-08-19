import 'dart:async';
import 'package:rxdart/rxdart.dart';

mixin DialogStreamMixin {
  final _dialogState = BehaviorSubject<DialogState>();

  StreamSubscription<DialogState> _listen;

  void dialogListen(void Function(DialogState) onData) {
    _listen = _dialogState.stream.distinct(
      (previous, next) {
        if (previous is ShowDialogState && next is ShowDialogState)
          return previous.title == next.title &&
              previous.description == next.description;
        else
          return previous == next;
      },
    ).listen(onData);
  }

  void showDialog({String title, String description}) {
    _dialogState.add(ShowDialogState(
      title: title,
      description: description,
    ));
  }

  void hideDialog() {
    _dialogState.add(HideDialogState());
  }

  void disposeDialogStream() {
    _listen?.cancel();
    _dialogState.close();
  }
}

abstract class DialogState {}

class ShowDialogState extends DialogState {
  final String title;
  final String description;

  ShowDialogState({this.title, this.description});
}

class HideDialogState extends DialogState {}
