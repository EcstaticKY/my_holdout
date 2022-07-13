import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../data/moor_database.dart';
import 'new_task_input_widget.dart';

class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(create: (_) => AppDatabase(), child: MaterialApp(
      title: 'Tasks App',
      home: HomePage(),
    ),);
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: _buildTaskList(context)),
          NewTaskInput()
        ],
      ),
    );
  }

  StreamBuilder<List<Task>> _buildTaskList(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    return StreamBuilder(
        stream: database.watchAllTasks(),
        builder: (context, AsyncSnapshot<List<Task>> snapshot) {
          final tasks = snapshot.data ?? List();

          return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (_, index) {
                final itemTask = tasks[index];
                return _buildListItem(itemTask, database);
              });
        });
  }

  Widget _buildListItem(Task itemTask, AppDatabase database) {
    return Slidable(
      child: CheckboxListTile(
        title: Text(itemTask.name),
        subtitle: Text(itemTask.dueDate?.toString() ?? "No date"),
        value: itemTask.completed,
        onChanged: (newValue) {
          database.updateTask(itemTask.copyWith(completed: newValue));
        },
      ),
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => database.deleteTask(itemTask),
        )
      ],
    );
  }
}