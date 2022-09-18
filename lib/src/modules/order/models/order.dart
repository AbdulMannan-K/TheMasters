import 'package:json_annotation/json_annotation.dart';
import 'package:the_masters/src/modules/customer/model/customer.dart';
import 'package:the_masters/src/modules/order/models/order_item.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  const Order({
    this.id = '',
    this.paid = 0,
    this.total = 0,
    this.number = 0,
    this.items = const [],
    this.status = false,
    required this.customer,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  final List<OrderItem> items;

  @JsonKey(name: '_id')
  final String id;
  final int number;
  final bool status;
  final double paid;
  final double total;

  final Customer customer;

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
