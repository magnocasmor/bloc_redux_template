import 'package:bloc_redux_example/redux/actions.dart';
import 'package:bloc_redux_example/redux/app_state.dart';
import 'package:bloc_redux_example/routes.dart';
import 'package:bloc_redux_example/screens/base_screen.dart';
import 'package:bloc_redux_example/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ReduxExampleScreen extends StatelessWidget {
  const ReduxExampleScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Redux Examples',
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        physics: ClampingScrollPhysics(),
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          CustomCard(
            icon: Icons.face,
            title: 'Change Profile',
            onTap: () => Routes.push(Routes.PROFILE_CHANGE),
          ),
          CustomCard(
            icon: Icons.schedule,
            title: 'Schedule Dialog',
            onTap: () => Routes.push(Routes.SCHEDULE_DIALOG),
          ),
        ],
      ),
      fab: FloatingActionButton.extended(
        icon: Icon(Icons.brush),
        label: Text('CHANGE THEME'),
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {
          StoreProvider.of<AppState>(context).dispatch(ChangeThemeAction());
        },
      ),
    );
  }
}
