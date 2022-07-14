import 'package:flutter/material.dart';
import 'package:my_holdout/tasks_with_moor/presentation/new_tag_input_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../data/moor_database.dart';
import 'new_task_input_widget.dart';

class TasksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = AppDatabase();
    return MultiProvider(
      providers: [
        Provider(create: (_) => db.taskDao),
        Provider(create: (_) => db.tagDao),
      ],
      child: MaterialApp(
        title: 'Material App',
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
        actions: <Widget>[
          _buildCompletedOnlySwitch(),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: _buildTaskList(context)),
          NewTaskInput(),
          NewTagInput(),
        ],
      ),
    );
  }

  Row _buildCompletedOnlySwitch() {
    return Row(
      children: <Widget>[
        Text('Completed Only'),
        Switch(
            value: showCompleted,
            activeColor: Colors.white,
            onChanged: (newValue) {
              setState(() {
                showCompleted = newValue;
              });
            })
      ],
    );
  }

  StreamBuilder<List<TaskWithTag>> _buildTaskList(BuildContext context) {
    final dao = Provider.of<TaskDao>(context);
    return StreamBuilder(
        stream: showCompleted
            ? dao.watchCompletedTasks()
            : dao.watchAllTasks(),
        builder: (context, AsyncSnapshot<List<TaskWithTag>> snapshot) {
          final tasks = snapshot.data ?? List();

          return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (_, index) {
                final itemTask = tasks[index];
                return _buildListItem(itemTask, dao);
              });
        });
  }

  Widget _buildListItem(TaskWithTag item, TaskDao dao) {
    return Slidable(
      child: CheckboxListTile(
        title: Text(item.task.name),
        subtitle: Text(item.task.dueDate?.toString() ?? "No date"),
        secondary: _buildTag(item.tag),
        value: item.task.completed,
        onChanged: (newValue) {
          dao.updateTask(item.task.copyWith(completed: newValue));
        },
      ),
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => dao.deleteTask(item.task),
        )
      ],
    );
  }

  Column _buildTag(Tag tag) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (tag != null) ...[
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(tag.color),
            ),
          ),
          Text(
            tag.name,
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ]
      ],
    );
  }
}
