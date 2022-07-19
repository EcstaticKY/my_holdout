import 'package:my_holdout/features/simple_list_page/domain/simple_use_case.dart';

import 'my_task.dart';

class GetTasksUseCase extends SimpleUseCase<List<MyTask>, NoParams> {
  @override
  Future<List<MyTask>> execute(NoParams noParams) {
    return Future.delayed(Duration(seconds: 5),
        () => [1, 2, 3].map((_) => MyTask.unique()).toList());
  }
}
