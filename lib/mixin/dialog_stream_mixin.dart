import 'dart:async';
import 'package:rxdart/rxdart.dart';

mixin DialogStreamMixin {
  final _dialogState = BehaviorSubject<DialogState>();

  StreamSubscription<DialogState> _listen;

  void dialogListen(void Function(DialogState) onData) {
    _listen = _dialogState.stream.distinct(
      (previus, next) {
        if (previus is ShowDialogState && next is ShowDialogState)
          return previus.title == next.title &&
              previus.description == next.description;
        else
          return previus == next;
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
