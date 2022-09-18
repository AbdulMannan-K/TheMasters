import 'dart:async';

import 'package:flutter/material.dart';
import 'package:the_masters/src/modules/customer/model/customer.dart';
import 'package:the_masters/src/modules/customer/repository/customer_repository.dart';
import 'package:the_masters/src/modules/customer/ui/list_item.dart';
import 'package:the_masters/src/modules/order/ui/order_form.dart';
import 'package:the_masters/src/widgets/appbar_search.dart';
import 'package:the_masters/src/widgets/responsive_body.dart';

import 'customer_form.dart';

class CustomerView extends StatefulWidget {
  const CustomerView({Key? key}) : super(key: key);

  @override
  State<CustomerView> createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView>
    with SearchableViewMixin<CustomerView, Customer> {
  final repository = CustomerRepository();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBody(
      buildLargeView: buildLargeView,
      buildSmallView: buildSmallView,
    );
  }

  Widget buildSmallView(BuildContext context) {
    Widget child;
    if (loading) {
      child = const Center(child: CircularProgressIndicator());
    } else {
      child = ListView.separated(
        itemCount: data.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return CustomerListTile(
            customer: data[index],
            onDeleted: () async {
              repository.delete(data[index]);
              data.removeAt(index);
              setState(() {});
            },
            onEdited: () async {
              final result = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return CustomerFormSmall(customer: data[index]);
                },
              ));

              if (result != null) {
                data[index] = result;
                setState(() {});
              }
            },
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => OrderFormSmall(customer: data[index]),
              ));
            },
          );
        },
      );
    }

    return Scaffold(
      body: child,
      appBar: AppBarSearch(
        controller: searchController,
        searchHint: 'Type to search customers..',
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.person_add_alt),
        label: const Text('New Customer'),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const CustomerFormSmall(),
        )),
      ),
    );
  }

  Widget buildLargeView(BuildContext context) {
    return Container(color: Colors.red);
  }

  @override
  Stream<Customer> onFind() {
    final text = searchController.text.trim();
    if (text.isNotEmpty) {
      if (_isNumeric(text)) {
        return repository.find(phone: searchController.text);
      } else {
        return repository.find(name: searchController.text);
      }
    } else {
      return repository.find();
    }
  }
}

bool _isNumeric(String? str) {
  if (str == null) {
    return false;
  }

  return double.tryParse(str) != null;
}

mixin SearchableViewMixin<T extends StatefulWidget, U> on State<T> {
  final data = <U>[];
  final searchController = TextEditingController();

  bool get loading => _loading;

  Stream<U> onFind();

  @override
  void initState() {
    super.initState();

    searchController.addListener(_onChange);
    find();
  }

  var _oldText = '';

  void find() {
    data.clear();
    _subscription?.cancel();

    _setLoading(true);
    _subscription = onFind().listen(_onStream);
  }

  void _onChange() {
    if (searchController.text != _oldText) {
      _oldText = searchController.text;

      find();
    }
  }

  _onStream(U item) {
    _setLoading(false);
    data.add(item);
    if (mounted) {
      setState(() {});
    }
  }

  void _setLoading(bool value) {
    if (_loading != value) {
      _loading = value;

      if (mounted) {
        setState(() {});
      }
    }
  }

  var _loading = true;
  StreamSubscription<U>? _subscription;
}
