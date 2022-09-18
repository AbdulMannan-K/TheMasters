import 'package:flutter/material.dart';
import 'package:the_masters/src/modules/customer/model/customer.dart';

class CustomerListTile extends StatelessWidget {
  const CustomerListTile({
    super.key,
    required this.customer,
    required this.onEdited,
    required this.onDeleted,
    required this.onPressed,
  });

  final Customer customer;
  final VoidCallback onEdited;
  final VoidCallback onDeleted;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: Text(customer.name ?? 'None'),
      subtitle: Text(customer.contactNumbers?.join(', ') ?? ''),
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
