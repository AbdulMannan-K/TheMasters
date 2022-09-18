import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:the_masters/src/base/data.dart';
import 'package:the_masters/src/modules/customer/model/customer.dart';

class DataViewSmall extends StatefulWidget {
  const DataViewSmall({Key? key}) : super(key: key);

  @override
  State<DataViewSmall> createState() => _DataViewSmallState();
}

class _DataViewSmallState extends State<DataViewSmall>
    with DbCollectionView<DataViewSmall, Customer> {
  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.separated(
      itemCount: data.length,
      separatorBuilder: (_, __) => const Divider(height: 0, indent: 18),
      itemBuilder: (context, index) {
        Widget title;
        if (data[index].name != null) {
          title = Text((data[index].name!).trim());
        } else {
          title = const Text(
            'None',
            style: TextStyle(fontStyle: FontStyle.italic),
          );
        }

        return ListTile(
          title: title,
          subtitle: Text(
            data[index].contactNumbers?.join(', ') ?? '',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        );
      },
    );
  }

  @override
  Customer parseObject(Map<String, dynamic> data) => Customer.fromJson(data);

  @override
  // TODO: implement collection
  mongo.DbCollection get collection => throw UnimplementedError();
}

mixin DbCollectionView<T extends StatefulWidget, U> on State<T> {
  var loading = true;

  mongo.DbCollection get collection;

  final data = <U>[];

  find() {

  }

  @override
  void initState() {
    super.initState();

    // collection = DBClient.get().collection('users');

    final timer =
        Timer.periodic(const Duration(seconds: 5), (_) => setState(() {}));

    collection
        .modernFind()
        .listen(_onData, onDone: timer.cancel, onError: onError);
  }

  void onError(error) {}

  void _onData(Map<String, dynamic> object) {
    object['_id'] = object['_id'].$oid;
    if (loading) loading = false;
    data.add(parseObject(object));
  }

  U parseObject(Map<String, dynamic> data);
}
