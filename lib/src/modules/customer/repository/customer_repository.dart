import 'package:the_masters/src/modules/customer/model/customer.dart';
import 'package:the_masters/src/modules/customer/repository/mongo_customer_repository.dart';

abstract class CustomerRepository {
  factory CustomerRepository() = MongoCustomerRepository;

  Stream<Customer> find({String? name, String? phone});

  Future<Customer> create(Customer customer);

  Future<Customer> update(Customer customer);

  Future<void> delete(Customer customer);
}
