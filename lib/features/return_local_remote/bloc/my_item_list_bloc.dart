import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:my_holdout/shared/observer.dart';
import '../get_my_item_list.dart';
import '../my_item.dart';

part 'my_item_list_event.dart';
part 'my_item_list_state.dart';

class MyItemListBloc extends Bloc<MyItemListEvent, MyItemListState> {
  final GetMyItemList getMyItemList;

  MyItemListBloc({@required this.getMyItemList}) : super(MyItemListEmpty());

  @override
  Stream<MyItemListState> mapEventToState(MyItemListEvent event) async* {
    if (event is GetMyItemListEvent) {
      getMyItemList.execute(_MyItemListObserver(bloc: this));
      yield MyItemListLoading();
    } else if (event is GotMyItemListEvent) {
      yield MyItemListLoaded(itemList: event.itemList);
    }
  }

  void loadedItemList(List<MyItem> itemList) {
    // add(MyItemListLoaded(itemList: itemList));
    add(GotMyItemListEvent(itemList: itemList));
  }
}

class _MyItemListObserver implements Observer<List<MyItem>> {
  final MyItemListBloc bloc;
  _MyItemListObserver({@required this.bloc});

  @override
  void onComplete() { }

  @override
  void onError(e) { }

  @override
  void onNext(List<MyItem> response) {
    bloc.loadedItemList(response);
  }
}
