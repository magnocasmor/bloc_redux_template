import 'package:bloc_redux_example/blocs/base_bloc.dart';
import 'package:bloc_redux_example/mixin/snackbar_stream_mixin.dart';
import 'package:rxdart/rxdart.dart';

class ShowSnackBarBloc extends BaseBloc<ShowSnackBarBaseState>
    with SnackBarStreamMixin {
  final _state = BehaviorSubject<ShowSnackBarBaseState>();

  @override
  void addError(ShowSnackBarBaseState state) {
    if (state is OnErrorSnackBarState)
      showSnackBar(
        title: 'This code is on fire! 🔥🔥🔥',
        description: state.message,
      );
    _state.addError(state);
  }

  @override
  void addState(ShowSnackBarBaseState state) {
    _state.add(state);
    if (state is OnChangedSnackBarState)
      showSnackBar(
        title: state.title,
        description: state.description,
      );
  }

  @override
  ShowSnackBarBaseState get initialState => InativeState();

  @override
  Stream<ShowSnackBarBaseState> get stream => _state.stream.distinct();

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
          addState(OnChangedSnackBarState(
            'title',
            'description',
          ));
          break;
        default:
          throw (Exception('Invalid Status Exception: $status'));
      }
    } catch (e) {
      addError(OnErrorSnackBarState(e.message));
    }
  }

  @override
  void dispose() {
    _state.close();
    disposeSnackBarStream();
    super.dispose();
  }
}

abstract class ShowSnackBarBaseState {}

class InativeState extends ShowSnackBarBaseState {}

class NormalState extends ShowSnackBarBaseState {}

class OnChangedSnackBarState extends ShowSnackBarBaseState {
  final String title;
  final String description;

  OnChangedSnackBarState(this.title, this.description);
}

class OnErrorSnackBarState extends ShowSnackBarBaseState {
  final String message;

  OnErrorSnackBarState(this.message);
}
