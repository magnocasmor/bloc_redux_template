import 'package:bloc_redux_example/blocs/networking_fetch_bloc.dart';
import 'package:bloc_redux_example/modules/networking_fetch_module.dart';
import 'package:bloc_redux_example/screens/base_screen.dart';
import 'package:bloc_redux_example/widgets/custom_button.dart';
import 'package:bloc_redux_example/widgets/custom_stream_builder.dart';
import 'package:flutter/material.dart';

class NetworkingFetchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NetworkingFetchBloc bloc =
        NetworkingFetchModule.to.bloc<NetworkingFetchBloc>();

    return BaseScreen(
      title: 'Network Fetch Data',
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomStreamBuilder<NetworkingFetchState>(
          initialData: bloc.initialState,
          stream: bloc.stream,
          errorBuilder: (context, error) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(
                  flex: 5,
                ),
                Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 56.0,
                ),
                Spacer(),
                Text(
                  (error as ErrorFetchState).message,
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                CustomButton(
                  label: 'try again',
                  color: Colors.red,
                  onPressed: bloc.fetchData,
                ),
                Spacer(
                  flex: 5,
                ),
              ],
            );
          },
          builder: (context, data) {
            switch (data.runtimeType) {
              case LoadingFetchState:
                return CircularProgressIndicator();
                break;
              case PopulatedFetchState:
                final json = (data as PopulatedFetchState).data;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(
                      flex: 5,
                    ),
                    Text(
                      json['id'].toString(),
                      style: Theme.of(context).textTheme.title,
                    ),
                    Spacer(),
                    Text(
                      json['title'].toString(),
                      style: Theme.of(context).textTheme.body1,
                    ),
                    Spacer(),
                    CustomButton(
                      label: 'Update',
                      onPressed: bloc.fetchData,
                    ),
                    Spacer(
                      flex: 5,
                    ),
                  ],
                );
              case NoDataFetchedState:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Icon(
                        Icons.warning,
                        color: Colors.orange,
                        size: 56.0,
                      ),
                    ),
                    Expanded(child: Text((data as NoDataFetchedState).message)),
                    Flexible(
                      flex: 10,
                      child: CustomButton(
                        label: 'Try again',
                        color: Colors.orange,
                        onPressed: bloc.fetchData,
                      ),
                    ),
                  ],
                );
              default:
                return CustomButton(
                  label: 'Fetch Data',
                  onPressed: bloc.fetchData,
                );
            }
          },
        ),
      ),
    );
  }
}
