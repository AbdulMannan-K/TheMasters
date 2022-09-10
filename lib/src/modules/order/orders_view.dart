import 'package:flutter/material.dart';
import 'package:the_masters/src/widgets/responsive_body.dart';

class OrdersView extends ResponsiveBody {
  @override
  ResponsiveBodyResult buildLarge(BuildContext context) {
    return ResponsiveBodyResult();
  }

  @override
  ResponsiveBodyResult buildSmall(BuildContext context) {
    return ResponsiveBodyResult();
  }
}

// class OrdersView extends StatefulWidget {
//   const OrdersView({Key? key}) : super(key: key);
//
//   @override
//   State<OrdersView> createState() => _OrdersViewState();
// }
//
// class _OrdersViewState extends State<OrdersView> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
