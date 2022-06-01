import 'dart:async';

import 'package:just_todo/bloc/todo_event.dart';
import 'package:just_todo/bloc/todo_state.dart';
import 'package:just_todo/model/task.dart';
import 'package:just_todo/repository/task_repository.dart';

class TodoBloc {
  final _taskRepo = TaskRepository();

  final _inputTaskController = StreamController<TaskEvent>();
  final _outputTaskController = StreamController<TaskState>();

  StreamSink<TaskEvent> get inputClient => _inputTaskController.sink;
  Stream<TaskState> get stream => _outputTaskController.stream;

  TodoBloc() {
    _inputTaskController.stream.listen(_mapEventToState);
  }

  _mapEventToState(TaskEvent event) async {
    List<Task> tasks = [];

    if (event is LoadTaskEvent) {
      final loadedTasks = await _taskRepo.loadTasks();
      tasks = loadedTasks;
      print("Load -> $loadedTasks");
    } else if (event is AddTaskEvent) {
      tasks = _taskRepo.addTask(event.task);
    } else if (event is RemoveTaskEvent) {
      tasks = _taskRepo.removeTask(event.task);
    }

    _outputTaskController.add(TaskSuccessState(tasks: tasks));
  }
}
