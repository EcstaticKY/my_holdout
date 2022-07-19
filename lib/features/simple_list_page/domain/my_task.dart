import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:my_holdout/shared/util/get_uuid.dart';

class MyTask extends Equatable {
  final String uuid;
  final String name;

  MyTask._({@required this.uuid, @required this.name});
  
  factory MyTask.unique() {
    return MyTask._(uuid: getUuid(), name: getUuid());
  }

  @override
  List<Object> get props => [uuid, name];
}