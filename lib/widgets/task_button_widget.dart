import 'package:flutter/material.dart';
import 'package:just_todo/constants/intent_keys.dart';
import 'package:just_todo/functions/dialog.dart';
import 'package:just_todo/functions/task_edti_functions.dart';
import 'package:just_todo/widgets/form_widgets.dart';

import '../constants/app_colors.dart';
import '../model/task.dart';
import '../routes/page_routes.dart';

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
          FormWidgets.titleDraw("TASKS"),
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
    onLongPress: () =>
        Dialogs.showMyDialog(context, data: dataToShow, index: index),
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
        Row(
          children: [
            _editTaskIcon(),
            Container(width: 10),
            _buttonInfoWidget(dataToShow, index),
          ],
        ),
        confirmedCheckBox(data, index, setState, context),
      ],
    ),
  );
}

Widget _editTaskIcon() {
  return Container(
    padding: const EdgeInsets.all(2),
    decoration: BoxDecoration(
      border: Border.all(
        width: 1,
        color: AppColors.weakWhite,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(2)),
    ),
    child: const Icon(Icons.edit_note),
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
          TaskEditFunctions.changingCompleted(data.elementAt(realPosition));
        });
      });
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
