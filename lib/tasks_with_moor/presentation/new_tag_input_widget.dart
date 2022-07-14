import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:my_holdout/tasks_with_moor/data/moor_database.dart';
import 'package:provider/provider.dart';

class NewTagInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewTagInputState();
  }
}

class _NewTagInputState extends State<NewTagInput> {
  static const Color DEFAULT_COLOR = Colors.red;

  TextEditingController controller;
  Color pickedTagColor = DEFAULT_COLOR;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          _buildTextField(context),
          _buildColorPickerButton(context),
        ],
      ),
    );
  }

  Flexible _buildTextField(BuildContext context) {
    return Flexible(
      flex: 1,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: 'Tag Name'),
        onSubmitted: (inputName) {
          final dao = Provider.of<TagDao>(context, listen: false);
          final tag = TagsCompanion(
            name: Value(inputName),
            color: Value(pickedTagColor.value),
          );
          dao.insertTag(tag);
          resetValuesAfterSubmit();
        },
      ),
    );
  }

  Widget _buildColorPickerButton(BuildContext context) {
    return Flexible(
        flex: 1,
        child: GestureDetector(
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: pickedTagColor,
            ),
          ),
          onTap: () {
            _showColorPickerDialog(context);
          },
        ));
  }

  Future _showColorPickerDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: MaterialColorPicker(
              allowShades: false,
              selectedColor: DEFAULT_COLOR,
              onMainColorChange: (colorSwatch) {
                setState(() {
                  pickedTagColor = colorSwatch;
                  Navigator.of(context).pop();
                });
              },
            ),
          );
        });
  }

  void resetValuesAfterSubmit() {
    setState(() {
      pickedTagColor = DEFAULT_COLOR;
      controller.clear();
    });
  }
}
