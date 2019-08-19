import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bloc_redux_example/blocs/show_snackbar_bloc.dart';
import 'package:bloc_redux_example/mixin/snackbar_stream_mixin.dart';
import 'package:bloc_redux_example/modules/show_snackbar_module.dart';
import 'package:bloc_redux_example/screens/base_screen.dart';
import 'package:bloc_redux_example/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ShowSnackbarScreen extends StatefulWidget {
  const ShowSnackbarScreen({Key key}) : super(key: key);

  @override
  _ShowSnackbarScreenState createState() => _ShowSnackbarScreenState();
}

class _ShowSnackbarScreenState extends State<ShowSnackbarScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final bloc = ShowSnackBarModule.to.bloc<ShowSnackBarBloc>();

  @override
  void initState() {
    super.initState();
    bloc.snackBarListen(
      _snackbarListen,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConsumerModule<ShowSnackBarBloc, ShowSnackBarModule>(
      builder: (context, bloc) {
        return BaseScreen(
          title: 'Show Snackbar',
          scaffoldKey: _scaffoldKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Show snackbar from bloc state'),
              CustomButton(
                label: 'Normal State (dont show SnackBar)',
                onPressed: () {
                  bloc.changeState(1);
                },
              ),
              CustomButton(
                label: 'Show Snackbar',
                onPressed: () {
                  bloc.changeState(2);
                },
              ),
              CustomButton(
                label: 'Throw Exception',
                onPressed: () {
                  bloc.changeState(-1);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _snackbarListen(SnackBarState state) {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    if (state is ShowSnackBarState)
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(state.title),
              Text(state.description),
            ],
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {
              // bloc.hideSnackBar();
            },
          ),
        ),
      );
  }
}
