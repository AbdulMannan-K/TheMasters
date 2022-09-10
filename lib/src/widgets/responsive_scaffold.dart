import 'package:flutter/material.dart';
import 'package:the_masters/src/widgets/responsive_body.dart';

class ResponsiveScaffold extends StatelessWidget {
  const ResponsiveScaffold({
    super.key,
    this.body,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final ResponsiveBody? body;
  final ValueChanged<int> onDestinationSelected;
  final List<NavigationDestination> destinations;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      Widget? body;
      Widget? bottomNavigationBar;
      ResponsiveBodyResult? result;

      if (constraints.maxWidth > 480) {
        result = this.body?.buildLarge(context);

        body = Row(children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            destinations: destinations.map(toRailDestination).toList(),
          ),
          if (result != null && result.body != null)
            Expanded(child: result.body!),
        ]);
      } else {
        result = this.body?.buildSmall(context);

        body = result?.body;
        bottomNavigationBar = NavigationBar(
          destinations: destinations,
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
        );
      }

      return Scaffold(
        body: body,
        appBar: result?.appBar,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: result?.floatingActionButton,
      );
    });
  }
}

NavigationRailDestination toRailDestination(NavigationDestination destination) {
  return NavigationRailDestination(
    icon: destination.icon,
    label: Text(destination.label),
    selectedIcon: destination.selectedIcon,
  );
}
