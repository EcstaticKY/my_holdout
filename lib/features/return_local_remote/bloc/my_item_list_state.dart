part of 'my_item_list_bloc.dart';

abstract class MyItemListState extends Equatable {
  const MyItemListState();
}

class MyItemListEmpty extends MyItemListState {
  @override
  List<Object> get props => [];
}

class MyItemListLoading extends MyItemListState {
  @override
  List<Object> get props => [];
}

class MyItemListLoaded extends MyItemListState {
  final List<MyItem> itemList;

  MyItemListLoaded({@required this.itemList});

  @override
  List<Object> get props => [itemList];
}

