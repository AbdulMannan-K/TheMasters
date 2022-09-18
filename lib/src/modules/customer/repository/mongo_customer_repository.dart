import 'package:mongo_dart/mongo_dart.dart';
import 'package:the_masters/src/base/data.dart';
import 'package:the_masters/src/modules/customer/model/customer.dart';
import 'package:the_masters/src/utils/mongo_utils.dart';

import 'customer_repository.dart';

class MongoCustomerRepository implements CustomerRepository {
  final _client = DBClient.get();

  @override
  Stream<Customer> find({String? name, String? phone}) {
    var filter = where.notExists('deleted');

    if (name != null) {
      filter = filter.and(where.match('name', name, caseInsensitive: true));
    }

    if (phone != null) {
      filter = filter.and(where.match('contacts', phone));
    }

    return _client
        .collection('users')
        .find(filter)
        .map(MongoUtils.objectIdToHexString)
        .map(Customer.fromJson)
      ..map((event) => print(event.id));
  }

  @override
  Future<Customer> create(Customer customer) async {
    final result = await _client
        .collection('users')
        .insertOne(customer.toJson()..remove('_id'));

    return Customer(
      id: result.id.toString(),
      name: customer.name,
      order: customer.order,
      contactNumbers: customer.contactNumbers,
    );
  }

  @override
  Future<void> delete(Customer customer) async {
    _client.collection('users').updateOne(
          where.id(ObjectId.fromHexString(customer.id)),
          ModifierBuilder().set('deleted', true),
        );
  }

  @override
  Future<Customer> update(Customer customer) async {
    final json = customer.toJson()..remove('_id');
    final modifier = ModifierBuilder();

    json.forEach((key, value) {
      modifier.set(key, value);
    });

    await _client.collection('users').updateOne(
          where.id(ObjectId.fromHexString(customer.id)),
          modifier,
        );

    return customer;
  }
}
