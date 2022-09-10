import 'dart:html';

import 'package:flutter/material.dart';
import 'package:the_masters/src/modules/order/orders_view.dart';
import 'package:the_masters/src/widgets/responsive_body.dart';
import 'package:the_masters/src/widgets/responsive_scaffold.dart';
import 'package:the_masters/src/modules/customer/customers_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var selectedIndex = 0;

  //final pages = <ResponsiveBody>[
  //  CustomersView(),
  //  OrdersView(),
  //];

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      body: CustomersView(),
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: const <NavigationDestination>[
        NavigationDestination(
          label: 'Customers',
          icon: Icon(Icons.groups_outlined),
          selectedIcon: Icon(Icons.groups_rounded),
        ),
        NavigationDestination(
          label: 'Orders',
          icon: Icon(Icons.assignment_outlined),
          selectedIcon: Icon(Icons.assignment_rounded),
        ),
      ],
    );
  }

  void onDestinationSelected(int index) {
    selectedIndex = index;
    setState(() {});
  }
}
