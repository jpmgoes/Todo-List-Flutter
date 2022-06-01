import 'package:flutter/material.dart';
import 'package:just_todo/constants/intent_keys.dart';
import 'package:just_todo/widgets/form_widgets.dart';

import '../constants/app_colors.dart';
import '../constants/preferences_keys.dart';
import '../constants/shared_pref.dart';
import '../model/task.dart';
import '../repository/task_repository.dart';
import '../routes/page_routes.dart';
import '../validation/form_validations.dart';

class TaskButtonWidget extends StatefulWidget {
  const TaskButtonWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<Task> data;

  @override
  State<TaskButtonWidget> createState() => _TaskButtonWidgetState();
}

class _TaskButtonWidgetState extends State<TaskButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    final List<Task> dataToShow = List.from(data.reversed);

    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, top: 30),
      child: Column(
        children: [
          FormWidgets.titleDraw("TASK"),
          SizedBox(
            height: MediaQuery.of(context).size.height - 180,
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: data.length,
                separatorBuilder: (context, index) =>
                    const Divider(color: Colors.transparent),
                itemBuilder: (context, index) {
                  return _viewButton(data, index, setState, context);
                }),
          ),
        ],
      ),
    );
  }
}

Widget _viewButton(List<Task> data, int index, setState, BuildContext context) {
  final List<Task> dataToShow = List.from(data.reversed);
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: AppColors.primaryColor,
      minimumSize: const Size(double.infinity, 80),
    ),
    onLongPress: () => showMyDialog(context, data: dataToShow, index: index),
    onPressed: () {
      Navigator.pushNamed(context, PageRoutes.editTaskPage, arguments: {
        IntentKey.intentKeyTask: dataToShow[index],
        IntentKey.intentKeyData: dataToShow,
        IntentKey.intentKeyIndex: index
      });
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buttonInfoWidget(dataToShow, index),
        confirmedCheckBox(data, index, setState, context),
      ],
    ),
  );
}

Widget _buttonInfoWidget(List<Task> dataToShow, int index) {
  final task = dataToShow.elementAt(index);
  // description
  final descTam = task.description!.length;
  final titleTam = task.title!.length;

  String desc = task.description!.trim();
  String title = task.title!.trim();
  if (descTam >= 20) desc = "${desc.substring(0, 20).trim()}...";
  if (titleTam >= 20) title = "${title.substring(0, 20).trim()}...";

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title.toUpperCase()),
      Text(desc),
    ],
  );
}

Widget confirmedCheckBox(
    List<Task> data, int index, setState, BuildContext context) {
  final List<Task> dataToShow = List.from(data.reversed);
  final task = dataToShow.elementAt(index);
  return Checkbox(
      value: dataToShow.elementAt(index).completed,
      activeColor: AppColors.secondColor,
      side: MaterialStateBorderSide.resolveWith(
        (states) => BorderSide(width: 1.0, color: AppColors.weakWhite),
      ),
      onChanged: (value) {
        setState(() {
          task.completed = !task.completed;
          final realPosition = data.length - index - 1;
          scaffoldMessager(data.elementAt(realPosition), context);
          changingCompleted(data.elementAt(realPosition));
        });
      });
}

changingCompleted(Task task) async {
  final sharedPref = SharedPref();
  final value = await sharedPref.read(PreferencesKeys.tasks);
  var newTaskRepo = TaskRepository.fromJson(value);
  // print("$value == $newTaskRepo");
  newTaskRepo = newTaskRepo.changeCompleted(task);
  sharedPref.save(PreferencesKeys.tasks, newTaskRepo);
}

Future<void> showMyDialog(
  BuildContext context, {
  List<Task>? data,
  int? index,
  Task? taskArg,
}) async {
  late Task task;

  if (data != null && index != null && taskArg == null) {
    task = data[index];
  } else {
    task = taskArg!;
  }

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Remover Task ${task.title!.toUpperCase()}'),
        content: const SingleChildScrollView(
          child: Text('Você gostaria de remover essa task?'),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              primary: AppColors.alertColor,
            ),
            child: const Text('REMOVER'),
            onPressed: () {
              removeTask(task).then((value) {
                FormValidation.scaffoldMessenger(
                  value,
                  context,
                  "TASK ${value?.toUpperCase()} REMOVIDA",
                  "TASK NÃO FOI REMOVIDA",
                );
                PageRoutes.toHomePage(context);
              });
            },
          ),
          TextButton(
            child: const Text('CANCELAR'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<String?> removeTask(Task task) async {
  final sharedPref = SharedPref();
  final value = await sharedPref.read(PreferencesKeys.tasks);

  TaskRepository newTaskRepo = TaskRepository.fromJson(value);
  newTaskRepo = newTaskRepo.removeTaskRetuningThis(task);

  sharedPref.save(PreferencesKeys.tasks, newTaskRepo);
  return task.title;
}

Widget addTaskButtonWidget(BuildContext context) {
  return Stack(
    children: [
      Center(
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              width: 2,
              color: AppColors.primaryColor,
            ),
            // ),
          ),
        ),
      ),
      Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: AppColors.primaryColor,
            minimumSize: const Size(40, 40),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))),
          ),
          onPressed: () {
            Navigator.pushNamed(context, PageRoutes.addTaskPage);
          },
          child: const Text("+"),
        ),
      ),
    ],
  );
}
