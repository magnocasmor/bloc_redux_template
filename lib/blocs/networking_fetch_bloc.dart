import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:http/http.dart' as http;
import 'base_bloc.dart';
import 'dart:math' as math;

class NetworkingFetchBloc extends BaseBloc<NetworkingFetchState> {
  NetworkingFetchBloc() {
    fetchData();
  }

  final _state = BehaviorSubject<NetworkingFetchState>();

  @override
  NetworkingFetchState get initialState => NetworkingFetchState();

  @override
  Stream<NetworkingFetchState> get stream => _state.stream.distinct();

  @override
  void addState(NetworkingFetchState state) => _state.add(state);

  @override
  void addError(NetworkingFetchState state) => _state.addError(state);

  Future<void> fetchData() async {
    try {
      addState(LoadingFetchState());
      final randomId = math.Random().nextInt(500);
      final response = await http
          .get('https://jsonplaceholder.typicode.com/todos/$randomId');
      final result = json.decode(response.body);
      if (result.isEmpty)
        return addState(NoDataFetchedState('TODO not found. Id $randomId.'));
      addState(PopulatedFetchState(result));
    } catch (e) {
      print(e);
      addError(ErrorFetchState(e.toString()));
    }
  }

  @override
  void dispose() {
    _state.close();
    super.dispose();
  }
}

class NetworkingFetchState {}

class LoadingFetchState extends NetworkingFetchState {}

class PopulatedFetchState extends NetworkingFetchState {
  final Map data;

  PopulatedFetchState(this.data);
}

class NoDataFetchedState extends NetworkingFetchState {
  final String message;

  NoDataFetchedState(this.message);
}

class ErrorFetchState extends NetworkingFetchState {
  final String message;

  ErrorFetchState(this.message);
}
