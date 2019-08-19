import 'package:bloc_redux_example/routes.dart';
import 'package:bloc_redux_example/screens/base_screen.dart';
import 'package:bloc_redux_example/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class BlocExampleScreen extends StatelessWidget {
  const BlocExampleScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Bloc Examples',
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        physics: ClampingScrollPhysics(),
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          CustomCard(
            icon: Icons.get_app,
            title: 'Networking Fetch Data',
            onTap: () => Routes.push(Routes.NETWORKING_FETCH),
          ),
          CustomCard(
            icon: Icons.perm_device_information,
            title: 'Show Dialog',
            onTap: () => Routes.push(Routes.SHOW_DIALOG),
          ),
          CustomCard(
            icon: Icons.info_outline,
            title: 'Show Snackbar',
            onTap: () => Routes.push(Routes.SHOW_SNACKBAR),
          ),
        ],
      ),
    );
  }
}
