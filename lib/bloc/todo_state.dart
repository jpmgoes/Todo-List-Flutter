import 'package:just_todo/model/task.dart';

abstract class TaskState {
  List<Task> tasks;

  TaskState({required this.tasks});
}

class InicialTaskState extends TaskState {
  InicialTaskState() : super(tasks: []);
}

class TaskSuccessState extends TaskState {
  TaskSuccessState({required List<Task> tasks}) : super(tasks: tasks);
}
