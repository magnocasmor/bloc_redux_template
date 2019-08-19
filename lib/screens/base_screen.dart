import 'package:bloc_redux_example/entities/profile_view_model.dart';
import 'package:bloc_redux_example/redux/app_state.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class BaseScreen extends StatelessWidget {
  final String title;
  final Widget child;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final FloatingActionButton fab;

  const BaseScreen({
    Key key,
    @required this.title,
    this.child,
    this.fab,
    this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          StoreConnector<AppState, ProfileViewModel>(
            converter: (store) => ProfileViewModel(
              photo: store.state.photo,
              userName: store.state.userName,
              typeConnection: store.state.result,
              status: store.state.connectionStatus,
            ),
            distinct: true,
            builder: (_, viewModel) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.white),
                ),
                margin: const EdgeInsets.all(2.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Hero(
                        tag: 'profile',
                        child: CircleAvatar(
                          backgroundImage: viewModel.photo,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        viewModel.userName,
                        style: Theme.of(context).textTheme.subhead.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                    Icon(
                      _iconConnectionStatus(viewModel.typeConnection),
                      color: _colorConnectionStatus(viewModel.status),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
        centerTitle: false,
      ),
      body: Center(
        child: child,
      ),
      floatingActionButton: fab,
    );
  }

  IconData _iconConnectionStatus(ConnectivityResult typeConnection) {
    switch (typeConnection) {
      case ConnectivityResult.wifi:
        return Icons.wifi;
      case ConnectivityResult.mobile:
        return Icons.import_export;
      default:
        return Icons.device_unknown;
    }
  }

  Color _colorConnectionStatus(ConnectionStatus status) {
    switch (status) {
      case ConnectionStatus.full_acess:
        return Colors.greenAccent;
      case ConnectionStatus.only_connected:
        return Colors.orangeAccent;
      case ConnectionStatus.offline:
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }
}
