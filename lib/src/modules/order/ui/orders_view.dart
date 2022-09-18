import 'package:flutter/material.dart';
import 'package:the_masters/src/modules/customer/ui/customers_view.dart';
import 'package:the_masters/src/modules/order/models/order.dart';
import 'package:the_masters/src/modules/order/repository/order_repository.dart';
import 'package:the_masters/src/modules/order/ui/list_item.dart';
import 'package:the_masters/src/modules/order/ui/order_completion.dart';
import 'package:the_masters/src/modules/order/ui/order_form.dart';
import 'package:the_masters/src/widgets/appbar_search.dart';
import 'package:the_masters/src/widgets/responsive_body.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView>
    with
        SearchableViewMixin<OrdersView, Order>,
        SingleTickerProviderStateMixin {
  TabController? controller;
  final repository = OrderRepository();

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 2, vsync: this);
    find();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBody(
      buildLargeView: buildLargeView,
      buildSmallView: buildSmallView,
    );
  }

  Widget buildLargeView(BuildContext context) {
    return Container();
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
          return OrderListTile(
            order: data[index],
            onDeleted: () async {
              repository.delete(data[index]);
              data.removeAt(index);
              setState(() {});
            },
            onEdited: () async {
              final result = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return OrderFormSmall(
                    order: data[index],
                    customer: data[index].customer,
                  );
                },
              ));

              if (result != null) {
                data[index] = result;
                setState(() {});
              }
            },
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => OrderCompletion(order: data[index]),
              ));
            },
          );
        },
      );
    }

    return Scaffold(
      body: child,
      appBar: AppBarSearch(
        searchHint: 'Type to search orders',
        bottom: TabBar(
          controller: controller,
          onTap: (_) {
            find();
          },
          indicator: const BoxDecoration(color: Colors.blue),
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
    );
  }

  @override
  Stream<Order> onFind() {
    if (controller != null) {
      return repository.find(status: controller!.index == 1);
    } else {
      return const Stream.empty();
    }
  }
}
