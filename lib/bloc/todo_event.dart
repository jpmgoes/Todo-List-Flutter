import 'package:just_todo/model/task.dart';

abstract class TaskEvent {}

class LoadTaskEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  Task task;
  AddTaskEvent({required this.task});
}

class RemoveTaskEvent extends TaskEvent {
  Task task;
  RemoveTaskEvent({required this.task});
}
