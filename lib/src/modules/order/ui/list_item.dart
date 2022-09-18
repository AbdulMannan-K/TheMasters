import 'package:flutter/material.dart';
import 'package:the_masters/src/modules/customer/model/customer.dart';
import 'package:the_masters/src/modules/order/models/order.dart';

class OrderListTile extends StatelessWidget {
  const OrderListTile({
    super.key,
    required this.order,
    required this.onEdited,
    required this.onDeleted,
    required this.onPressed,
  });

  final Order order;
  final VoidCallback onEdited;
  final VoidCallback onDeleted;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Order # ${order.number} (${order.customer.name})'),
        // Text(order.customer.name ?? 'None'),
      ]),
      subtitle: Text(order.customer.contactNumbers?.join(', ') ?? ''),
      trailing: PopupMenuButton(
        elevation: 4,
        color: Colors.blue.shade50,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.blue.shade200, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 0,
            child: Row(children: const [
              Icon(Icons.edit_rounded),
              SizedBox(width: 10),
              Text('Edit'),
            ]),
          ),
          PopupMenuItem(
            value: 1,
            child: Row(children: const [
              Icon(Icons.delete_rounded),
              SizedBox(width: 10),
              Text('Remove'),
            ]),
          ),
        ],
        onSelected: (value) {
          if (value == 0) {
            onEdited();
          } else if (value == 1) {
            onDeleted();
          }
        },
      ),
    );
  }
}
