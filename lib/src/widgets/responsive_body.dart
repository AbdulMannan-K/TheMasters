import 'package:flutter/material.dart';

class ResponsiveBodyResult {
  const ResponsiveBodyResult({this.body, this.floatingActionButton});

  final Widget? body;
  final Widget? floatingActionButton;
}

abstract class ResponsiveBody {
  ResponsiveBodyResult buildLarge(BuildContext context);

  ResponsiveBodyResult buildSmall(BuildContext context);
}
