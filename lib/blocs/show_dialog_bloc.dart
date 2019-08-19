import 'package:bloc_redux_example/blocs/base_bloc.dart';
import 'package:bloc_redux_example/mixin/dialog_stream_mixin.dart';
import 'package:rxdart/rxdart.dart';

class ShowDialogBloc extends BaseBloc<ShowDialogBaseState>
    with DialogStreamMixin {
  final _state = BehaviorSubject<ShowDialogBaseState>();

  @override
  void addError(ShowDialogBaseState state) {
    if (state is OnErrorDialogState)
      showDialog(
        title: 'This code is on fire! 🔥🔥🔥',
        description: state.message,
      );
    _state.addError(state);
  }

  @override
  void addState(ShowDialogBaseState state) {
    if (state is OnChangedDialogState)
      showDialog(
        title: state.title,
        description: state.description,
      );
    _state.add(state);
  }

  @override
  ShowDialogBaseState get initialState => InativeState();

  @override
  Stream<ShowDialogBaseState> get stream => _state.stream.distinct();

  void changeState(int status) {
    try {
      switch (status) {
        case 0:
          addState(InativeState());
          break;
        case 1:
          addState(NormalState());
          break;
        case 2:
          addState(OnChangedDialogState(
            'title',
            'description',
          ));
          break;
        default:
          throw (Exception('Invalid Status Exception: $status'));
      }
    } catch (e) {
      addError(OnErrorDialogState(e.message));
    }
  }

  @override
  void dispose() {
    _state.close();
    disposeDialogStream();
    super.dispose();
  }
}

abstract class ShowDialogBaseState {}

class InativeState extends ShowDialogBaseState {}

class NormalState extends ShowDialogBaseState {}

class OnChangedDialogState extends ShowDialogBaseState {
  final String title;
  final String description;

  OnChangedDialogState(this.title, this.description);
}

class OnErrorDialogState extends ShowDialogBaseState {
  final String message;

  OnErrorDialogState(this.message);
}
