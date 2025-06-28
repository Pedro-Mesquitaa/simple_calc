import 'package:hive_flutter/hive_flutter.dart';
class RepositoryOperations {

  static void clearBox() {
    final box = Hive.box('operations');
    box.clear();
  }

  static void putOnBox(String operation, num result) {
    final box = Hive.box('operations');
    box.add([operation, result]);
  }

  static List<List<dynamic>> getOnBox() {
    final box = Hive.box('operations');
    final List<List<dynamic>> resultSet = [];

    for(var k in box.keys) {
      final value = box.get(k);

      if (value is List && value.length == 2 && value[0] is String && value[1] is num) {
        resultSet.add(value);
      }
    }

    return resultSet;
  }
} 