import 'package:bloc_pattern/bloc_pattern.dart';

abstract class BaseBloc<T> extends BlocBase {
  T get initialState;

  void addState(T state);

  void addError(T state);

  Stream<T> get stream;
}
