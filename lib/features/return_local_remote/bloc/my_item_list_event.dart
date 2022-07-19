part of 'my_item_list_bloc.dart';

abstract class MyItemListEvent extends Equatable {
  const MyItemListEvent();
}

class GetMyItemListEvent extends MyItemListEvent {
  @override
  List<Object> get props => [];
}

class GotMyItemListEvent extends MyItemListEvent {
  final List<MyItem> itemList;

  GotMyItemListEvent({@required this.itemList});

  @override
  List<Object> get props => [itemList];
}
