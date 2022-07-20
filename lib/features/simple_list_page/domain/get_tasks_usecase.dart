import 'dart:async';

import 'package:my_holdout/features/simple_list_page/domain/simple_use_case.dart';

import 'my_task.dart';

class GetTasksUseCase extends SimpleUseCase<List<MyTask>, NoParams> {
  final streamController = StreamController<List<MyTask>>();

  @override
  Future<List<MyTask>> execute(NoParams noParams) {
    return Future.delayed(Duration(seconds: 5),
        () => [1, 2, 3].map((_) => MyTask.unique()).toList());
  }

  void executeWithCompletion(Function(List<MyTask>) completion) async {
    List<MyTask> tasks = await Future.delayed(Duration(seconds: 1),
            () => [1, 2, 3].map((_) => MyTask.unique()).toList());
    completion(tasks);
    tasks = await Future.delayed(Duration(seconds: 5),
            () => [1, 2, 3, 4].map((_) => MyTask.unique()).toList());
    completion(tasks);
  }

  Stream<List<MyTask>> getStream() {
    streaming();
    return streamController.stream;
  }

  Future<void> streaming() async {
    streamController.add([1, 2, 3].map((_) => MyTask.unique()).toList());
    streamController.add([1, 2, 3, 4].map((_) => MyTask.unique()).toList());
  }
}
