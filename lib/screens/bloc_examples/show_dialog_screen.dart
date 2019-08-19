import 'package:bloc_redux_example/blocs/show_dialog_bloc.dart';
import 'package:bloc_redux_example/mixin/dialog_stream_mixin.dart';
import 'package:bloc_redux_example/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bloc_redux_example/modules/show_dialog_module.dart';
import 'package:bloc_redux_example/routes.dart';
import 'package:bloc_redux_example/screens/base_screen.dart';

class ShowDialogScreen extends StatefulWidget {
  const ShowDialogScreen({Key key}) : super(key: key);

  @override
  _ShowDialogScreenState createState() => _ShowDialogScreenState();
}

class _ShowDialogScreenState extends State<ShowDialogScreen> {
  final bloc = ShowDialogModule.to.bloc<ShowDialogBloc>();

  @override
  void initState() {
    super.initState();

    bloc.dialogListen(_dialogListen);
  }

  @override
  Widget build(BuildContext context) {
    return ConsumerModule<ShowDialogBloc, ShowDialogModule>(
      builder: (context, bloc) {
        return BaseScreen(
          title: 'Show Dialog Bloc ',
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Show Dialog from bloc state '),
              CustomButton(
                label: 'Normal State (dont show Dialog)',
                onPressed: () {
                  bloc.changeState(1);
                },
              ),
              CustomButton(
                label: 'Show Dialog',
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

  void _dialogListen(data) {
    if (data is ShowDialogState)
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(data.title),
            content: Text(data.description),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  bloc.hideDialog();
                  Routes.pop();
                },
              )
            ],
          );
        },
      );
  }
}
