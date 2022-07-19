import 'my_item.dart';

abstract class MyItemRepository {
  Future<List<MyItem>> getMyItemList();
}