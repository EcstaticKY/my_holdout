import 'package:my_holdout/features/return_local_remote/my_item.dart';
import 'package:my_holdout/features/return_local_remote/my_item_repository.dart';

class MyItemRepositoryRemoteImpl implements MyItemRepository {
  @override
  Future<List<MyItem>> getMyItemList() {
    return Future.delayed(Duration(seconds: 4),
        () => [1, 2, 3, 4, 5].map((_) => MyItem.unique()).toList());
  }
}
