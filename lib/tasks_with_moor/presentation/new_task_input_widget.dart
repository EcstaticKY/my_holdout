import 'package:flutter/material.dart';
import 'package:my_holdout/tasks_with_moor/data/moor_database.dart';
import 'package:provider/provider.dart';

class NewTaskInput extends StatefulWidget {
  const NewTaskInput({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewTaskInputState();
}

class _NewTaskInputState extends State<NewTaskInput> {
  DateTime newTaskDate;
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTextField(context),
          _buildDateButton(context),
        ],
      ),
    );
  }

  Expanded _buildTextField(BuildContext context) {
    return Expanded(
        child: TextField(
      controller: controller,
      decoration: InputDecoration(hintText: "Task Name"),
      onSubmitted: (inputName) {
        final dao = Provider.of<TaskDao>(context, listen: false);
        final task = Task(name: inputName, dueDate: newTaskDate);
        dao.insertTask(task);
        resetValuesAfterSubmit();
      },
    ));
  }

  IconButton _buildDateButton(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.calendar_today),
        onPressed: () async {
          newTaskDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2010),
              lastDate: DateTime(2050));
        });
  }

  void resetValuesAfterSubmit() {
    setState(() {
      newTaskDate = null;
      controller.clear();
    });
  }
}
