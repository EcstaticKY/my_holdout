import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

class MyItem {
  final String uuid;
  final String description;

  MyItem._({@required this.uuid, @required this.description});

  factory MyItem.unique() {
    final uuid = Uuid().v4();
    final description = Uuid().v4();

    return MyItem._(uuid: uuid, description: description);
  }
}