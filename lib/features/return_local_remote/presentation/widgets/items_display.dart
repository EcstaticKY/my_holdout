import 'package:flutter/material.dart';
import 'package:my_holdout/features/return_local_remote/my_item.dart';

class ItemsDisplay extends StatelessWidget {
  final List<MyItem> itemList;

  ItemsDisplay({@required this.itemList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (_, index) {
          final item = itemList[index];
          return _buildItem(item);
        });
  }

  Widget _buildItem(MyItem item) {
    return Column(
      children: <Widget>[
        Text('UUID: ${item.uuid}'),
        Text('Description: ${item.description}'),
      ],
    );
  }
}