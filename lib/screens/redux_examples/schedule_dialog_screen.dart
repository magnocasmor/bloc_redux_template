import 'package:bloc_redux_example/redux/actions.dart';
import 'package:bloc_redux_example/redux/app_state.dart';
import 'package:bloc_redux_example/screens/base_screen.dart';
import 'package:bloc_redux_example/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ScheduleDialogScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ScheduleDialogScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Schedule Dialog',
      scaffoldKey: _scaffoldKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                    'Schedule a dialog and navigate to others screen. This dialog show up in 10 seconds'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                maxLength: 20,
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                maxLength: 100,
              ),
            ),
            Flexible(
              flex: 5,
              child: CustomButton(
                label: 'SCHEDULE',
                onPressed: () {
                  Future.delayed(
                    Duration(seconds: 10),
                    () {
                      StoreProvider.of<AppState>(context).dispatch(
                        ScheduleGlobalDialogAction(
                          _titleController.text,
                          _descriptionController.text,
                        ),
                      );
                    },
                  );
                  _scaffoldKey.currentState.hideCurrentSnackBar();
                  _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      content: Text(
                        'Schedule completed!',
                        textAlign: TextAlign.center,
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
