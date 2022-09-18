import 'package:flutter/material.dart';
import 'package:the_masters/src/modules/customer/ui/customer_form.dart';
import 'package:the_masters/src/modules/customer/ui/customers_view.dart';
import 'package:the_masters/src/modules/order/ui/orders_view.dart';
import 'package:the_masters/src/widgets/responsive_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var selectedIndex = 0;
  final subViews = <Widget>[
    CustomerView(),
    OrdersView(),
  ];

  @override
  Widget build(BuildContext context) {
    // return CustomerFormSmall(id: 1);
    // rF
    return ResponsiveBody(
      buildLargeView: buildLargeView,
      buildSmallView: buildSmallView,
    );
  }

  Widget buildSmallView(BuildContext context) {
    return Column(children: [
      Expanded(child: subViews[selectedIndex]),
      NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: const [
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
      )
    ]);
  }

  Widget buildLargeView(BuildContext context) {
    return Row(children: [
      NavigationRail(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: const [
          NavigationRailDestination(
            label: Text('Customers'),
            icon: Icon(Icons.groups_outlined),
            selectedIcon: Icon(Icons.groups_rounded),
          ),
          NavigationRailDestination(
            label: Text('Orders'),
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment_rounded),
          )
        ],
      ),
      Expanded(child: subViews[selectedIndex])
    ]);
  }

  void onDestinationSelected(int index) {
    selectedIndex = index;
    setState(() {});
  }
}
