import 'package:mongo_dart/mongo_dart.dart';

abstract class DBClient {
  static late Db _client;

  static Future<void> initialize() async {
    _client = await Db.create(
      'mongodb+srv://arish:1234@cluster0.ogvmmiq.mongodb.net/the-masters?retryWrites=true&w=majority',
      // 'mongodb://localhost:27017/the-masters'
    );
    await _client.open();
  }

  static Db get() => _client;
}
