import 'package:flutter/material.dart';

class ConstrainedView extends StatelessWidget {
  final Widget child;
  final double width;
  const ConstrainedView({
    Key? key,
    required this.child,
    this.width = 250,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < width) {
          return const Text('');
        }
        return child;
      },
    );
  }
}
