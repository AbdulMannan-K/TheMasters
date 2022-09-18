import 'package:mongo_dart/mongo_dart.dart';

abstract class MongoUtils {
  static Map<String, dynamic> objectIdToHexString(Map<String, dynamic> obj) {
    if (obj['_id'] is ObjectId) {
      obj['_id'] = obj['_id'].$oid;
    }

    return obj;
  }
}
