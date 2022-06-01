import 'package:flutter/material.dart';
import 'package:just_todo/functions/task_edit_functions.dart';

import '../constants/app_colors.dart';
import '../constants/form_constants.dart';
import '../model/task.dart';

class FormWidgets {
  static Widget normalCamp(
    TextEditingController controller,
    String title, {
    dynamic validation,
    String hint = "",
    double? height,
    bool boolDevider = false,
    double dividerTam = 8,
  }) {
    double dividerHigh = boolDevider ? 16 : 0;
    dividerHigh = boolDevider ? 16 : dividerTam;

    return Column(
      children: [
        TextFormField(
          validator: validation == null ? null : (value) => validation(),
          controller: controller,
          maxLines: null,
          cursorColor: AppColors.primaryColor,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            focusColor: AppColors.primaryColor,
            hintText: hint,
            labelText: title,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primaryColor,
              ),
            ),
            labelStyle: TextStyle(color: AppColors.primaryColor),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
            contentPadding: height != null
                ? EdgeInsets.only(top: 0, left: 16, bottom: height, right: 16)
                : null,
          ),
        ),
        Divider(color: Colors.transparent, height: dividerHigh),
      ],
    );
  }

  static EdgeInsets paddingWholeForm = EdgeInsets.only(
      left: FormConstants.paddingSides, right: FormConstants.paddingSides);

  static Widget titleDraw(String title, {double dividerHeight = 16}) => Column(
        children: [
          Text(
            title,
            textDirection: TextDirection.ltr,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 30,
            ),
          ),
          Divider(
            color: Colors.transparent,
            height: dividerHeight,
          )
        ],
      );
  static Widget formConfirmedCheckBox(
      Task task, BuildContext context, setState) {
    String label =
        (task.completed) ? "MARCADA COMO FEITA" : "AINDA NÃO CONCLUÍDA";

    return CheckboxListTile(
        value: task.completed,
        title: Text(label),
        activeColor: AppColors.secondColor,
        onChanged: (value) {
          setState(() {
            task.completed = !task.completed;
            TaskEditFunctions.changingCompleted(task);

            scaffoldMessager(task, context);
          });
        });
  }
}

void scaffoldMessager(Task task, BuildContext context) {
  String output = (task.completed)
      ? "TASK ${task.title!.toUpperCase()} MARCADA COMO FEITA"
      : "TASK ${task.title!.toUpperCase()} AINDA NÃO CONCLUÍDA";

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(output)),
  );
}
