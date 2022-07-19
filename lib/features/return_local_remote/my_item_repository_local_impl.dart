import 'my_item.dart';
import 'my_item_repository.dart';

class MyItemRepositoryLocalImpl implements MyItemRepository {
  @override
  Future<List<MyItem>> getMyItemList() {
    return Future(() => [1, 2, 3].map((_) => MyItem.unique()).toList());
  }
}