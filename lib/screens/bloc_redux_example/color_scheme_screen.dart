import 'package:bloc_redux_example/blocs/color_scheme_bloc.dart';
import 'package:bloc_redux_example/modules/color_scheme_module.dart';
import 'package:bloc_redux_example/redux/actions.dart';
import 'package:bloc_redux_example/redux/app_state.dart';
import 'package:bloc_redux_example/screens/base_screen.dart';
import 'package:bloc_redux_example/widgets/custom_button.dart';
import 'package:bloc_redux_example/widgets/custom_stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ColorSchemeScreen extends StatelessWidget {
  const ColorSchemeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = ColorSchemeModule.to.getBloc<ColorSchemeBloc>({
      'color': Theme.of(context).primaryColor,
    });
    return BaseScreen(
      title: 'Color Scheme',
      fab: FloatingActionButton.extended(
        icon: Icon(Icons.brush),
        label: Text('CHANGE THEME'),
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {
          StoreProvider.of<AppState>(context).dispatch(ChangeThemeAction());
        },
      ),
      child: CustomStreamBuilder<ColorSchemeState>(
        initialData: bloc.initialState,
        stream: bloc.stream,
        builder: (context, state) {
          switch (state.runtimeType) {
            case LoadingColorSchemeState:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case GeneratedColorSchemeState:
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: (state as GeneratedColorSchemeState)
                    .generatedSchemes
                    .map((color) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      color: Color(color),
                    ),
                  );
                }).toList(),
              );
            default:
              return Container();
          }
        },
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
                (error as ErrorColorSchemeState).message,
                textAlign: TextAlign.center,
              ),
              Spacer(),
              CustomButton(
                label: 'try again',
                color: Colors.red,
                onPressed: bloc.generateColorScheme,
              ),
              Spacer(
                flex: 5,
              ),
            ],
          );
        },
      ),
    );
  }
}
