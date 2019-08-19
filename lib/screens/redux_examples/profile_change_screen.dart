import 'dart:math';
import 'package:bloc_redux_example/redux/actions.dart';
import 'package:bloc_redux_example/redux/app_state.dart';
import 'package:bloc_redux_example/screens/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ProfileChangeScreen extends StatelessWidget {
  final TextEditingController _tfController = TextEditingController();

  ProfileChangeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _tfController.text = StoreProvider.of<AppState>(context).state.userName;
    ImageProvider imageProvider = StoreProvider.of<AppState>(context).state.photo;
    return BaseScreen(
      title: 'Profile Change',
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(
              flex: 2,
            ),
            StatefulBuilder(
              builder: (_, setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: imageProvider,
                      radius: 56.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton.icon(
                        icon: Icon(Icons.refresh),
                        label: Text('Random Photo'),
                        onPressed: () {
                          setState(
                            () {
                              imageProvider = NetworkImage(
                                'https://source.unsplash.com/featured/?face,${Random().nextInt(100)}',
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: TextFormField(
                controller: _tfController,
                maxLength: 15,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      gapPadding: 8.0,
                    ),
                    labelText: 'Username'),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            OutlineButton(
              child: Text('Save Change'),
              onPressed: () {
                StoreProvider.of<AppState>(context).dispatch(
                  ChangeProfileAction(
                    photo: imageProvider,
                    userName: _tfController.text,
                  ),
                );
              },
            ),
            Spacer(
              flex: 5,
            ),
          ],
        ),
      ),
    );
  }
}
