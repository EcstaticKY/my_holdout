import 'package:uuid/uuid.dart';

final Uuid _uuid = Uuid();

String getUuid() {
  return _uuid.v4();
}