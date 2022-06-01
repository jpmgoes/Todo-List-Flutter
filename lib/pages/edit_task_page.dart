import 'package:flutter/material.dart';
import 'package:just_todo/constants/intent_keys.dart';
import 'package:just_todo/functions/dialog.dart';
import 'package:just_todo/functions/task_edti_functions.dart';

import '../constants/app_colors.dart';
import '../model/task.dart';
import '../routes/page_routes.dart';
import '../validation/form_validations.dart';
import '../widgets/custom_btn_widget.dart';
import '../widgets/form_widgets.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({Key? key}) : super(key: key);

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final _formKey = GlobalKey<FormState>();

  Task task = Task(id: 0);
  late List<Task> allData;
  late int index = 0;

  late String title;
  late String desc;
  late bool completed;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Object? data = ModalRoute.of(context)!.settings.arguments;
    if (data is Map<String, dynamic>) {
      task = data[IntentKey.intentKeyTask]!;
      allData = data[IntentKey.intentKeyData]!;
      index = data[IntentKey.intentKeyIndex]!;
    }

    title = task.title!;
    desc = task.description!;
    completed = task.completed;

    titleController.text = title;
    descriptionController.text = desc;

    String showTitle = title.toUpperCase();

    if (title.length > 5) {
      showTitle = "${title.substring(0, 4).toUpperCase()}...";
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: AppColors.background),
        height: double.infinity,
        padding: FormWidgets.paddingWholeForm,
        child: Form(
          key: _formKey,
          child: Center(
            child: _addTaskForm(context, showTitle),
          ),
        ),
      ),
    );
  }

  Widget _addTaskForm(BuildContext context, showTitle) {
    return ListView(
      shrinkWrap: true,
      children: [
        FormWidgets.titleDraw(
          "EDITAR TASK $showTitle",
          dividerHeight: 64,
        ),
        FormWidgets.normalCamp(
          titleController,
          "Nome da Task",
          hint: "Estudar Grafos",
          validation: () => FormValidation.titleValidation(titleController),
        ),
        FormWidgets.normalCamp(
          descriptionController,
          "Descrição",
          height: 80,
        ),
        FormWidgets.formConfirmedCheckBox(task, context, setState),
        _updateTaskBtn(context),
        _deleteTaskButton(context),
      ],
    );
  }

  Widget _updateTaskBtn(BuildContext context) {
    return CustomButtonWidget.draw(() {
      if (_formKey.currentState!.validate()) {
        TaskEditFunctions.updateTask(
          titleController,
          descriptionController,
          task,
        ).then((value) {
          FormValidation.scaffoldMessenger(
            value,
            context,
            "TASK ${value?.toUpperCase()} ATUALIZADA",
            "ALGO DEU ERRADO",
          );
          PageRoutes.toHomePage(context);
        });
      }
    }, "ATUALIZAR TASK", 280);
  }

  Widget _deleteTaskButton(BuildContext context) {
    return CustomButtonWidget.draw(() {
      Dialogs.showMyDialog(context, taskArg: task);
    }, "DELETAR TASK", 280, color: AppColors.alertColor);
  }
}
