import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_todo/bloc/todo_bloc.dart';
import 'package:just_todo/bloc/todo_event.dart';
import 'package:just_todo/bloc/todo_state.dart';
import 'package:just_todo/constants/app_colors.dart';

import '../widgets/handle_widgets.dart';
import '../widgets/task_button_widget.dart';

class TodoBlocPage extends StatefulWidget {
  const TodoBlocPage({Key? key}) : super(key: key);

  @override
  State<TodoBlocPage> createState() => _TodoBlocPageState();
}

class _TodoBlocPageState extends State<TodoBlocPage> {
  late final TodoBloc tasksBloc;

  @override
  void initState() {
    tasksBloc = TodoBloc();
    tasksBloc.inputClient.add(LoadTaskEvent());
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // SharedPref().clean();
    // SharedPref.showStored();
    super.initState();
  }

  @override
  void dispose() {
    tasksBloc.inputClient.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: AppColors.background),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder<TaskState>(
              stream: tasksBloc.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final tasks = snapshot.data!.tasks;
                  if (tasks.isEmpty) return semTaskWarnWidget(tasks);
                  return TaskButtonWidget(data: tasks);
                } else if (snapshot.hasError) {
                  return erroFindTaskWidget();
                }
                return loadingWidgets();
              },
            ),
            const Divider(),
            addTaskButtonWidget(context)
          ],
        ),
      ),
    );
  }
}
