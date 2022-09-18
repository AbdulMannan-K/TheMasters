import 'package:flutter/material.dart';

class ResponsiveBody extends StatelessWidget {
  const ResponsiveBody({
    super.key,
    required this.buildLargeView,
    required this.buildSmallView,
  });

  final WidgetBuilder buildLargeView;
  final WidgetBuilder buildSmallView;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 480) {
        return buildSmallView(context);
      } else {
        return buildLargeView(context);
      }
    });
  }
}
