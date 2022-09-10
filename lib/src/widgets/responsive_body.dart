import 'package:flutter/material.dart';

class ResponsiveBodyResult {
  const ResponsiveBodyResult({
    this.body,
    this.appBar,
    this.floatingActionButton,
  });

  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
}

abstract class ResponsiveBody {
  ResponsiveBodyResult buildLarge(BuildContext context);

  ResponsiveBodyResult buildSmall(BuildContext context);
}
