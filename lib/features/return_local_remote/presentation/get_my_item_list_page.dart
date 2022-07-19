import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_holdout/features/return_local_remote/bloc/my_item_list_bloc.dart';
import 'package:my_holdout/features/return_local_remote/my_item_list_composer.dart';
import 'package:my_holdout/features/return_local_remote/presentation/widgets/items_display.dart';
import 'package:my_holdout/number_trivia/presentation/widgets/loading_widget.dart';
import 'package:my_holdout/number_trivia/presentation/widgets/message_display.dart';

class GetMyItemListPage extends StatelessWidget {
  // final MyItemListBloc _bloc = MyItemListComposer.composedMyItemListBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Items')),
      body: _buildBody(context),
    );
  }

  BlocProvider<MyItemListBloc> _buildBody(BuildContext buildContext) {
    return BlocProvider(
        create: (_) => MyItemListComposer.composedMyItemListBloc()..add(GetMyItemListEvent()),
        child: Column(
          children: <Widget>[
            BlocBuilder<MyItemListBloc, MyItemListState>(
              builder: (context, state) {
                if (state is MyItemListLoading) {
                  return LoadingWidget();
                } else if (state is MyItemListLoaded) {
                  return ItemsDisplay(itemList: state.itemList);
                } else {
                  return MessageDisplay(message: "null");
                }
              },
            ),
            ElevatedButton(
              onPressed: () => buildContext.read<MyItemListBloc>().
                  add(GetMyItemListEvent()),
              // onPressed: () => _bloc.add(GetMyItemListEvent()),
              child: Text('Go to animate a widget across screens'),
            )
          ],
        ));
  }
}
