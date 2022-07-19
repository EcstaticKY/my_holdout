import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:my_holdout/features/return_local_remote/my_item.dart';
import 'package:my_holdout/features/return_local_remote/my_item_repository.dart';
import 'package:my_holdout/shared/stream_usecase.dart';

class GetMyItemList extends StreamUseCase<List<MyItem>, void> {
  final StreamController<List<MyItem>> controller = StreamController();
  final MyItemRepository localRepository;
  final MyItemRepository remoteRepository;

  GetMyItemList({@required this.localRepository, @required this.remoteRepository});

  @override
  Future<Stream<List<MyItem>>> buildUseCaseStream(void ignore) async {

    try {
      final cachedItemList = await localRepository.getMyItemList();
      controller.add(cachedItemList);
    } catch(e) {
      print(e);
    }

    try {
      final remoteItemList = await remoteRepository.getMyItemList();
      controller.add(remoteItemList);
      controller.close();
    } catch(e) {
      print(e);
      controller.addError(e);
    }

    return controller.stream;
  }

  Future<Stream<List<MyItem>>> buildStream() async {
    final StreamController<List<MyItem>> controller = StreamController();
    try {
      final cachedItemList = await localRepository.getMyItemList();
      controller.add(cachedItemList);
    } catch(_) { }

    try {
      final remoteItemList = await remoteRepository.getMyItemList();
      controller.add(remoteItemList);
      controller.close();
    } catch(e) {
      controller.addError(e);
    }

    return controller.stream;
  }
}