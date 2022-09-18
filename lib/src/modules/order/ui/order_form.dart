import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_masters/src/modules/customer/model/customer.dart';
import 'package:the_masters/src/modules/order/models/order.dart';
import 'package:the_masters/src/modules/order/models/order_item.dart';
import 'package:the_masters/src/modules/order/repository/order_repository.dart';
import 'package:the_masters/src/widgets/quantity_button.dart';

class OrderFormSmall extends StatefulWidget {
  const OrderFormSmall({super.key, required this.customer, this.order});

  final Customer customer;
  final Order? order;

  @override
  State<OrderFormSmall> createState() => _OrderFormSmallState();
}

class _OrderFormSmallState extends State<OrderFormSmall> {
  late List<OrderItem> items;

  final key = GlobalKey<FormState>();
  final repository = OrderRepository();
  final totalController = TextEditingController();
  final advanceController = TextEditingController();

  double get total => items.fold(0, (prev, e) {
        if (e.quantity > 0) {
          return prev + (e.price * e.quantity);
        }

        return prev;
      });

  @override
  void initState() {
    super.initState();

    if (widget.order != null) {
      advanceController.text = widget.order!.paid.toStringAsFixed(0);

      final allItems = OrderItem.getOrderItems();
      items = allItems.map((e) {
        final index = widget.order!.items.indexOf(e);
        if (index != -1) {
          return widget.order!.items[index];
        } else {
          return e;
        }
      }).toList();
    } else {
      items = OrderItem.getOrderItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    totalController.text = total.toStringAsFixed(0);

    return Scaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      appBar: AppBar(title: const Text('New Order')),
      body: Form(
        key: key,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              ...items.map((e) {
                return CupertinoFormSection.insetGrouped(children: [
                  CupertinoFormRow(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                      child: Row(children: [
                        Text(e.name, style: const TextStyle(fontSize: 16)),
                        const Spacer(),
                        QuantityButton(
                          quantity: e.quantity,
                          onIncrement: () => setState(() => e.quantity += 1),
                          onDecrement: () => setState(() => e.quantity -= 1),
                        )
                      ]),
                    ),
                  ),
                  if (e.quantity > 0)
                    CupertinoTextFormFieldRow(
                      initialValue: e.price.toStringAsFixed(0),
                      textAlign: TextAlign.right,
                      placeholder: 'Tap to enter',
                      keyboardType: TextInputType.number,
                      placeholderStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade300,
                      ),
                      prefix: Text(
                        'Price (Single)',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      onChanged: (value) {
                        e.price = (double.tryParse(value) ?? 0);
                        setState(() {});
                      },
                      validator: (str) =>
                          (str ?? '').isNotEmpty ? null : 'Enter valid price',
                    ),
                ]);
              }).toList(),
              const Divider(indent: 20, endIndent: 20, height: 30),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
                child: TextFormField(
                  controller: advanceController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    value = value ?? '0';
                    if ((int.tryParse(value) ?? 0) < total) {
                      return null;
                    } else {
                      return 'Advance must be less than total';
                    }
                  },
                  decoration: const InputDecoration(
                    label: Text('Advance'),
                    prefix: Text('Rs.  '),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: TextFormField(
                  controller: totalController,
                  decoration: const InputDecoration(
                    label: Text('Total'),
                    prefix: Text('Rs.  '),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: TextButton(
            onPressed: handleSubmit,
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text('Create Order'),
          ),
        ),
      ],
    );
  }

  void handleSubmit() async {
    if (!(key.currentState?.validate() ?? false)) return;
    final $items = items.where((element) => element.quantity > 0).toList();

    if ($items.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Select some items first',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Ok'),
            ),
          ],
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          children: const [CircularProgressIndicator(), Text('Loading')],
        ),
      ),
    );

    if (widget.order != null) {
      await repository.update(Order(
        items: $items,
        id: widget.order!.id,
        customer: widget.customer,
        number: widget.order!.number,
        total: double.tryParse(totalController.text) ?? 0,
        paid: double.tryParse(advanceController.text) ?? 0,
      ));
    } else {
      await repository.create(Order(
        items: $items,
        customer: widget.customer,
        number: await repository.getNextOrderNumber(),
        total: double.tryParse(totalController.text) ?? 0,
        paid: double.tryParse(advanceController.text) ?? 0,
      ));
    }

    if (mounted) {
      Navigator.of(context)
        ..pop()
        ..pop();
    }
  }
}
