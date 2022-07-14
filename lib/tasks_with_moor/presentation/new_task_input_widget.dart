import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';
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
  Tag selectedTag;

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
          _buildTagSelector(context),
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
        final task =
            TasksCompanion(name: Value(inputName), dueDate: Value(newTaskDate), tagName: Value(selectedTag?.name));
        dao.insertTask(task);
        resetValuesAfterSubmit();
      },
    ));
  }

  StreamBuilder<List<Tag>> _buildTagSelector(BuildContext context) {
    return StreamBuilder<List<Tag>>(
        stream: Provider.of<TagDao>(context).watchTags(),
        builder: (context, snapshot) {
          final tags = snapshot.data ?? List();

          DropdownMenuItem<Tag> dropDownFromTag(Tag tag) {
            return DropdownMenuItem(
              value: tag,
              child: Row(
                children: <Widget>[
                  Text(tag.name),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(tag.color),
                    ),
                  )
                ],
              ),
            );
          }

          final dropdownMenuItems =
              tags.map((tag) => dropDownFromTag(tag)).toList()
                ..insert(
                  0,
                  DropdownMenuItem(value: null, child: Text('No tag')),
                );

          return Expanded(
              child: DropdownButton(
            onChanged: (Tag tag) {
              setState(() {
                selectedTag = tag;
              });
            },
            isExpanded: true,
            value: selectedTag,
            items: dropdownMenuItems,
          ));
        });
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
      selectedTag = null;
      controller.clear();
    });
  }
}
