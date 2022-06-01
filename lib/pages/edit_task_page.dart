import 'package:flutter/material.dart';
import 'package:just_todo/constants/intent_keys.dart';
import 'package:just_todo/constants/preferences_keys.dart';
import 'package:just_todo/constants/shared_pref.dart';
import 'package:just_todo/repository/task_repository.dart';
import 'package:just_todo/widgets/task_button_widget.dart';

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

  Task task = Task(id: -1);
  late List<Task> allData;
  late int index = -1;

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

    String showTitle = "${title.substring(0, 4).toUpperCase()}...";

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
          child: Padding(
            padding: const EdgeInsets.only(top: 160),
            child: ListView(
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
                  validation: () =>
                      FormValidation.titleValidation(titleController),
                ),
                FormWidgets.normalCamp(descriptionController, "Descrição",
                    height: 80),
                FormWidgets.formConfirmedCheckBox(task, context, setState),
                CustomButtonWidget.draw(() {
                  if (_formKey.currentState!.validate()) {
                    _updateTask().then((value) {
                      FormValidation.scaffoldMessenger(
                        value,
                        context,
                        "TASK ${value?.toUpperCase()} ATUALIZADA",
                        "ALGO DEU ERRADO",
                      );
                      PageRoutes.toHomePage(context);
                    });
                  }
                }, "ATUALIZAR TASK", 280),
                CustomButtonWidget.draw(() {
                  showMyDialog(context, taskArg: task);
                }, "DELETAR TASK", 280, color: AppColors.alertColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> _updateTask() async {
    final sharedPref = SharedPref();
    final value = await sharedPref.read(PreferencesKeys.tasks);

    final taskUpdated = Task(
      title: titleController.text,
      description: descriptionController.text,
      completed: task.completed,
      id: task.id,
    );

    TaskRepository newTaskRepo = TaskRepository.fromJson(value);
    newTaskRepo = newTaskRepo.replace(taskUpdated);

    sharedPref.save(PreferencesKeys.tasks, newTaskRepo);

    return title;
  }
}
