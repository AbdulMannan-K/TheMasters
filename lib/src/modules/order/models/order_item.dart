import 'package:json_annotation/json_annotation.dart';

part 'order_item.g.dart';

@JsonSerializable()
class OrderItem {
  OrderItem({
    this.price = 0,
    this.quantity = 0,
    this.status = false,
    required this.name,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  final String name;
  int quantity;
  double price;
  bool status;

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  @override
  bool operator ==(Object other) {
    return other is OrderItem && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  static List<OrderItem> getOrderItems() {
    return <OrderItem>[
      OrderItem(name: 'Suit (Complete)'),
      OrderItem(name: 'Suit (Stitching)'),
      OrderItem(name: 'Pant (Complete)'),
      OrderItem(name: 'Pant (Complete)'),
      OrderItem(name: 'Pant (Complete)'),
      OrderItem(name: 'Shirt (Complete)'),
      OrderItem(name: 'Shirt (Stitching)'),
      OrderItem(name: 'Shalwar Qamiz (Complete)'),
      OrderItem(name: 'Shalwar Qamiz (Stitching)'),
      OrderItem(name: 'Waist Coat (Complete)'),
      OrderItem(name: 'Waist Coat (Stitching)'),
      OrderItem(name: 'Bush Coat (Complete)'),
      OrderItem(name: 'Bush Coat (Stitching)'),
      OrderItem(name: 'Sherwani (Complete)'),
      OrderItem(name: 'Sherwani (Stitching)'),
    ];
  }
}
