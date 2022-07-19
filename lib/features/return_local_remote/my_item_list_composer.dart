import 'package:my_holdout/features/return_local_remote/my_item_repository_local_impl.dart';
import 'package:my_holdout/features/return_local_remote/my_item_repository_remote_impl.dart';
import 'package:my_holdout/injection_container.dart';

import 'bloc/my_item_list_bloc.dart';
import 'get_my_item_list.dart';

class MyItemListComposer {
  static MyItemListBloc composedMyItemListBloc() {
    final localRepository = MyItemRepositoryLocalImpl();
    final remoteRepository = MyItemRepositoryRemoteImpl();
    final getMyItemList = GetMyItemList(
        localRepository: localRepository, remoteRepository: remoteRepository);
    final bloc = MyItemListBloc(getMyItemList: getMyItemList);
    return bloc;
  }

  // static composeMyItemListBloc() {
  //   final localRepository = MyItemRepositoryLocalImpl();
  //   final remoteRepository = MyItemRepositoryRemoteImpl();
  //   sl.register
  //   sl.registerLazySingleton(() => GetMyItemList(
  //       localRepository: localRepository, remoteRepository: remoteRepository));
  // }
}
