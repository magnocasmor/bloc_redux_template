import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;

  const CustomButton({
    Key key,
    this.label,
    this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: color ?? Theme.of(context).primaryColor,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
      ),
      onPressed: onPressed,
    );
  }
}
