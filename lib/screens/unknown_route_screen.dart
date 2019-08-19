import 'package:bloc_redux_example/routes.dart';
import 'package:bloc_redux_example/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class UnknownRouteScreen extends StatelessWidget {
  final String unknownRoute;
  UnknownRouteScreen({Key key, this.unknownRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Icon(
                Icons.warning,
                size: 76,
                color: Colors.orangeAccent,
              ),
            ),
            Expanded(
              child: Text(
                'Diabo é isso?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(child: Text('No routes found to $unknownRoute')),
            Flexible(
              flex: 2,
              child: SizedBox(
                height: 56.0,
                width: 170.0,
                child: CustomButton(
                  label: 'GO TO HOME',
                  onPressed: () {
                    Routes.popUntil(Routes.HOME);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
