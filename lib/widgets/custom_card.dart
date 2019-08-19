import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const CustomCard({
    Key key,
    @required this.title,
    @required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 8.0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Icon(
              icon,
              size: 48.0,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}
