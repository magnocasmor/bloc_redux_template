import 'package:bloc_redux_example/redux/actions.dart';
import 'package:bloc_redux_example/redux/app_state.dart';
import 'package:bloc_redux_example/routes.dart';
import 'package:bloc_redux_example/screens/base_screen.dart';
import 'package:bloc_redux_example/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StoreProvider.of<AppState>(context)
        .dispatch(RegisterMainContextAction(context));

    return BaseScreen(
      title: 'Home Page',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomCard(
                  icon: Icons.home,
                  title: 'Bloc Only Examples',
                  onTap: () => Routes.push(Routes.BLOC_EXAMPLES),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomCard(
                  icon: Icons.language,
                  title: 'Redux Only Examples',
                  onTap: () => Routes.push(Routes.REDUX_EXAMPLES),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomCard(
                  icon: Icons.device_hub,
                  title: 'Bloc + Redux Examples',
                  onTap: () => Routes.push(Routes.BLOC_REDUX_EXAMPLES),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
