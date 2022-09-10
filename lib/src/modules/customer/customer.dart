import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer {
  const Customer({
    required this.id,
    required this.name,
    required this.contactNumbers,
  });

  factory Customer.fromJson(Map<String, dynamic> _) => _$CustomerFromJson(_);

  final int id;
  final String name;
  final List<String> contactNumbers;

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}

class CustomerBuilder {
  CustomerBuilder({this.id, this.name, List<String>? contactNumbers}) {
    _contactNumbers.addAll(contactNumbers ?? []);
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
}
