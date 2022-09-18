import 'package:flutter/material.dart';
import 'package:the_masters/src/modules/order/models/order.dart';
import 'package:the_masters/src/modules/order/repository/order_repository.dart';

class OrderCompletion extends StatefulWidget {
  const OrderCompletion({super.key, required this.order});

  final Order order;

  @override
  State<OrderCompletion> createState() => _OrderCompletionState();
}

class _OrderCompletionState extends State<OrderCompletion> {
  final repository = OrderRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order # ${widget.order.number}'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.send),
          )
        ],
      ),
      body: CustomScrollView(slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return CheckboxListTile(
                value: widget.order.items[index].status,
                title: Text(widget.order.items[index].name),
                onChanged: (value) async {
                  widget.order.items[index].status = value ?? false;

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Row(children: const [
                        CircularProgressIndicator(),
                        Text('Loading'),
                      ]),
                    ),
                  );
                  await repository.update(widget.order);
                  setState(() {});

                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                },
              );
            },
            childCount: widget.order.items.length,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
          sliver: SliverToBoxAdapter(
            child: TextFormField(
              initialValue: widget.order.paid.toStringAsFixed(0),
              keyboardType: TextInputType.number,
              validator: (value) {
                value = value ?? '0';
                // if ((int.tryParse(value) ?? 0) < total) {
                //   return null;
                // } else {
                //   return 'Advance must be less than total';
                // }
              },
              decoration: const InputDecoration(
                label: Text('Paid'),
                prefix: Text('Rs.  '),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
          sliver: SliverToBoxAdapter(
            child: TextFormField(
              readOnly: true,
              initialValue:
                  (widget.order.total - widget.order.paid).toStringAsFixed(0),
              keyboardType: TextInputType.number,
              validator: (value) {
                value = value ?? '0';
                // if ((int.tryParse(value) ?? 0) < total) {
                //   return null;
                // } else {
                //   return 'Advance must be less than total';
                // }
              },
              decoration: const InputDecoration(
                label: Text('Remaining'),
                prefix: Text('Rs.  '),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          sliver: SliverToBoxAdapter(
            child: TextFormField(
              readOnly: true,
              initialValue: widget.order.total.toStringAsFixed(0),
              decoration: const InputDecoration(
                label: Text('Total'),
                prefix: Text('Rs.  '),
              ),
            ),
          ),
        ),
      ]),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: TextButton(
            onPressed: () {
              print('asd');
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text('Mark as Complete'),
          ),
        )
      ],
    );
  }
}
