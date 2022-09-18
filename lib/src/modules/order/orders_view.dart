// import 'package:flutter/material.dart';
// import 'package:the_masters/src/widgets/appbar_search.dart';
// import 'package:the_masters/src/widgets/responsive_body.dart';
//
// class OrdersView extends ResponsiveBody {
//   @override
//   ResponsiveBodyResult buildLarge(BuildContext context) {
//     return const ResponsiveBodyResult();
//   }
//
//   @override
//   ResponsiveBodyResult buildSmall(BuildContext context) {
//     return ResponsiveBodyResult(
//       body: const OrdersViewSmall(),
//       floatingActionButton: FloatingActionButton.extended(
//         icon: const Icon(Icons.post_add_rounded),
//         label: const Text('New Order'),
//         onPressed: () {},
//       ),
//     );
//   }
// }
//
// class OrdersViewSmall extends StatefulWidget {
//   const OrdersViewSmall({Key? key}) : super(key: key);
//
//   @override
//   State<OrdersViewSmall> createState() => _OrdersViewSmallState();
// }
//
// class _OrdersViewSmallState extends State<OrdersViewSmall>
//     with SingleTickerProviderStateMixin {
//   late TabController tabController;
//   final searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//
//     tabController = TabController(length: 2, vsync: this);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBarSearch(
//         controller: searchController,
//         searchHint: 'Type to search orders',
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(54),
//           child: TabBar(
//             controller: tabController,
//             indicatorSize: TabBarIndicatorSize.label,
//             indicatorPadding: const EdgeInsets.fromLTRB(0, 6, 0, 8),
//             indicator: const BoxDecoration(
//               color: Colors.blue,
//               borderRadius: BorderRadius.all(Radius.circular(20)),
//             ),
//             tabs: const [
//               Tab(child: Text('        Pending        ')),
//               Tab(child: Text('        Completed        ')),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
