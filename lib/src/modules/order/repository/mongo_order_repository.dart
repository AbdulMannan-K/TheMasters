import 'package:mongo_dart/mongo_dart.dart';
import 'package:the_masters/src/base/data.dart';
import 'package:the_masters/src/modules/order/models/order.dart';
import 'package:the_masters/src/modules/order/repository/order_repository.dart';
import 'package:the_masters/src/utils/mongo_utils.dart';

class MongoOrderRepository implements OrderRepository {
  final _client = DBClient.get();

  @override
  Future<Order> create(Order order) async {
    final result = await _client
        .collection('orders')
        .insertOne(order.toJson()..remove('_id'));

    return Order(
      id: result.id.toString(),
      paid: order.paid,
      items: order.items,
      total: order.total,
      status: order.status,
      customer: order.customer,
    );
  }

  @override
  Future<void> delete(Order order) {
    return _client
        .collection('orders')
        .deleteOne(where.id(ObjectId.fromHexString(order.id)));
  }

  @override
  Stream<Order> find({
    required bool status,
    String? number,
    String? name,
    String? phone,
  }) {
    var query = where.eq('status', status);

    return _client
        .collection('orders')
        .find(query)
        .map(MongoUtils.objectIdToHexString)
        .map(Order.fromJson);
  }

  @override
  Future<Order> update(Order order) async {
    final json = order.toJson()..remove('_id');
    final modifier = ModifierBuilder();

    json.forEach((key, value) {
      modifier.set(key, value);
    });

    await _client.collection('orders').updateOne(
      where.id(ObjectId.fromHexString(order.id)),
      modifier,
    );

    return order;
  }

  @override
  Future<int> getNextOrderNumber() async {
    return 10000 + (await _client.collection('orders').count());
  }
}
