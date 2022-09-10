import 'package:flutter/material.dart';
import 'package:the_masters/Models/CustomerHandler.dart';
import 'package:the_masters/src/widgets/appbar_search.dart';
import 'package:the_masters/src/widgets/responsive_body.dart';

import 'customer_form.dart';

class CustomersView extends ResponsiveBody {
  final customers = CustomerHandler.customers;

  @override
  ResponsiveBodyResult buildLarge(BuildContext context) {
    return const ResponsiveBodyResult();
  }

  @override
  ResponsiveBodyResult buildSmall(BuildContext context) {
    return ResponsiveBodyResult(
      appBar: AppBarSearch(
        searchHint: 'Type to search customers',
      ),
      body: ListView.separated(
        itemCount: customers.length * 10,
        separatorBuilder: (_, __) => const Divider(height: 0, indent: 18),
        itemBuilder: (context, index) {
          final customer = customers[index % customers.length];
          return ListTile(
            title: Text(customer.name),
            subtitle: Text(customer.primaryPhone),
            trailing: Text(customer.customerNo.toString()),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.person_add_alt),
        label: const Text('New Customer'),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const CustomerFormSmall(id: 0),
        )),
      ),
    );
  }
}
