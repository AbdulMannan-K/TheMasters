import 'package:the_masters/src/modules/order/models/order.dart';

import 'mongo_order_repository.dart';

abstract class OrderRepository {
  factory OrderRepository() = MongoOrderRepository;

  Stream<Order> find({
    required bool status,
    String? number,
    String? name,
    String? phone,
  });

  Future<int> getNextOrderNumber();

  Future<Order> create(Order order);

  Future<Order> update(Order order);

  Future<void> delete(Order order);
}
