import 'src/app.dart';

void main() => App.initializeAndRun();

// import 'package:flutter/material.dart';
// import 'package:the_masters/Components/customer_card.dart';
// import 'package:the_masters/Components/order_card.dart';
// import 'package:the_masters/Components/side_bar.dart';
// import 'package:the_masters/Models/customer.dart';
// import 'package:the_masters/Screens/customer_screen.dart';
// import 'package:the_masters/Screens/main_screen.dart';
//
// void main() {
//   runApp(TheMasters());
// }
//
// class TheMasters extends StatelessWidget {
//   const TheMasters({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text('The Masters'),
//         ),
//         body: Row(
//           children: [
//             Expanded(
//               flex: 6,
//               child: Padding(
//                 padding: EdgeInsets.only(top: 40),
//                 child: MainScreen(),
//               ),
//             ),
//           ],
//         ),
//         floatingActionButton: TextButton(
//           onPressed: () {},
//           child: Text('Orders'),
//         ),
//       ),
//     );
//   }
// }
//
// // Column(
// // crossAxisAlignment: CrossAxisAlignment.center,
// // children: [
// // Row(
// // children: [
// // Expanded(child: CustomerCard()),
// // SizedBox(
// // width: 50,
// // ),
// // Expanded(child: CustomerCard()),
// // SizedBox(
// // width: 50,
// // ),
// // Expanded(child: CustomerCard()),
// // ],
// // ),
// // SizedBox(
// // height: 50,
// // ),
// // Row(
// // children: [
// // Expanded(child: CustomerCard()),
// // SizedBox(
// // width: 50,
// // ),
// // Expanded(child: CustomerCard()),
// // SizedBox(
// // width: 50,
// // ),
// // Expanded(child: CustomerCard()),
// // ],
// // ),
// // ],
// // ),
