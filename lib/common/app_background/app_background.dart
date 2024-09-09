import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({
    super.key,
    required this.child,
    this.colors,
  });
  final Widget child;
  final List<Color>? colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: colors ??
            const [
              Color.fromRGBO(130, 197, 245, 1),
              Color.fromRGBO(21, 69, 239, 0.7),
            ],
      )),
      child: child,
    );
  }
}
