import 'package:just_todo/constants/preferences_keys.dart';
import 'package:just_todo/constants/shared_pref.dart';
import 'package:just_todo/model/task.dart';

class TaskRepository {
  List<Task> _tasks = [];

  TaskRepository();

  TaskRepository.fromJson(Map<String, dynamic> json) {
    var newTaskRepo = TaskRepository();
    final List<dynamic> taskList = json["task"];

    var id = 0;
    for (var task in taskList) {
      final title = task["title"];
      final description = task["description"];
      final completed = task["completed"];
      final newTask = Task(
        title: title,
        description: description,
        completed: completed,
        id: id,
      );
      newTaskRepo = newTaskRepo.addTaskReturningThis(newTask);
      id++;
    }

    final tasks = newTaskRepo.getTasks();
    _tasks = tasks;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task'] = _tasks;
    return data;
  }

  // events
  Future<List<Task>> loadTasks() async {
    final sharedPref = SharedPref();
    final value = await sharedPref.read(PreferencesKeys.tasks);

    if (value == null) {
      final tasks = TaskRepository();
      sharedPref.save(PreferencesKeys.tasks, tasks);
      return _tasks;
    }

    final newInstance = TaskRepository.fromJson(value).getTasks();
    return newInstance;
  }

  TaskRepository getRepo(Task task) {
    return this;
  }

  TaskRepository addTaskReturningThis(Task task) {
    addTask(task);
    return this;
  }

  TaskRepository removeTaskRetuningThis(Task task) {
    final intId = task.id!.toInt();
    _tasks.removeAt(intId);

    return this;
  }

  List<Task> addTask(Task task) {
    _tasks.add(task);

    return _tasks;
  }

  List<Task> removeTask(Task task) {
    _tasks.remove(task);
    return _tasks;
  }

  List<Task> getTasks() {
    return _tasks;
  }

  TaskRepository changeCompleted(Task task) {
    for (var i = 0; i < _tasks.length; i++) {
      if (_tasks[i].id == task.id) {
        // print("${_tasks[i].id} = ${task.id}");
        _tasks[i].completed = !_tasks[i].completed;
      }
    }
    // print("Changed -> $_tasks");
    return this;
  }

  TaskRepository replace(Task task) {
    _tasks = List.from(_tasks.map((Task e) {
      if (e.id == task.id) return task;
      return e;
    }));

    return this;
  }

  @override
  String toString() {
    return _tasks.toString();
  }
}
