import 'package:flutter/material.dart';
import 'package:just_todo/functions/task_edti_functions.dart';
import 'package:just_todo/widgets/custom_btn_widget.dart';

import '../constants/app_colors.dart';
import '../routes/page_routes.dart';
import '../validation/form_validations.dart';
import '../widgets/form_widgets.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  bool boolCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: AppColors.background),
        height: double.infinity,
        padding: FormWidgets.paddingWholeForm,
        child: Form(
          key: _formKey,
          child: Center(
            child: _addTaskForm(context),
          ),
        ),
      ),
    );
  }

  Widget _addTaskForm(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        FormWidgets.titleDraw("CRIAR UMA TASK", dividerHeight: 64),
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
        _createTaskBtn(context)
      ],
    );
  }

  Widget _createTaskBtn(BuildContext context) {
    return CustomButtonWidget.draw(() {
      if (_formKey.currentState!.validate()) {
        TaskEditFunctions.addTask(
          titleController,
          descriptionController,
        ).then((value) {
          FormValidation.scaffoldMessenger(
            value,
            context,
            "TASK ${value?.toUpperCase()} CRIRADA",
            "ALGO DEU ERRADO",
          );
          PageRoutes.toHomePage(context);
        });
      }
    }, "CRIAR TASK", 280);
  }
}
