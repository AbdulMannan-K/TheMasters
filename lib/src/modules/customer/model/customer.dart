import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer {
  const Customer({
    required this.id,
    required this.name,
    required this.order,
    required this.contactNumbers,
  });

  factory Customer.fromJson(Map<String, dynamic> _) => _$CustomerFromJson(_);

  @JsonKey(name: "_id")
  final String id;
  final String? name;
  @JsonKey(name: "_order")
  final String? order;
  @JsonKey(name: "contacts")
  final List<String>? contactNumbers;

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}

class CustomerBuilder {
  CustomerBuilder({this.id, this.name, List<String>? contactNumbers}) {
    _contactNumbers.addAll(contactNumbers ?? ['']);
  }

  String? id;
  String? name;

  final _contactNumbers = <String?>[];

  int get contactNumbersLength => _contactNumbers.length;

  void addContactNumber(String number) {
    _contactNumbers.add(number);
  }

  String? getContactNumber(int index) => _contactNumbers[index];

  void setContactNumber(int index, String? number) {
    _contactNumbers[index] = number;
  }

  void removeContactNumberAt(int index) {
    _contactNumbers.removeAt(index);
  }

  void fill(Customer customer) {
    id = customer.id;
    name = customer.name;
    _contactNumbers.clear();
    _contactNumbers.addAll(customer.contactNumbers ?? []);
  }

  Customer build() {
    if (name == null) {
      throw 'Name should not be null';
    }

    return Customer(
      id: id ?? '',
      order: '',
      name: name!,
      contactNumbers: _contactNumbers.map((e) => e!).toList(),
    );
  }
}
