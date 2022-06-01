import 'package:flutter_test/flutter_test.dart';
import 'package:just_todo/model/task.dart';
import 'package:just_todo/repository/task_repository.dart';

void main() {
  TaskRepository taskRepository = TaskRepository();
  Task task = Task(id: 0);

  group("Teste TaskRepository method", () {
    test("replace method", () {
      taskRepository.addTask(task);
      Task taskTest = Task(title: "ok", id: 0);
      expect(taskRepository.replace(taskTest), isA<TaskRepository>());
      expect(taskRepository.getTasks()[0].title, equals("ok"));
      taskRepository.removeTask(task);
    });
    test("addTaskReturningThis method", () {
      expect(taskRepository.addTaskReturningThis(task), isA<TaskRepository>());
      expect(taskRepository.getTasks().length, equals(2));
    });
    test("removeTaskRetuningThis method", () {
      expect(
          taskRepository.removeTaskRetuningThis(task), isA<TaskRepository>());
      taskRepository.addTask(task);
    });
    test("removeTask method", () {
      expect(taskRepository.removeTask(task), isA<List<Task>>());
      taskRepository.addTask(task);
    });
    test("changeCompleted method", () {
      taskRepository = TaskRepository();
      taskRepository.addTask(task);
      expect(
          taskRepository.changeCompleted(task), allOf(isA<TaskRepository>()));
      expect(taskRepository.getTasks()[0].completed, equals(true));
    });
    test("getTasks method", () {
      expect(taskRepository.getTasks(), isA<List<Task>>());
    });

    test("getRepo method", () {
      expect(taskRepository.getRepo(task), equals(taskRepository));
    });
    test("add method", () {
      expect(taskRepository.addTask(task)[0].id, equals(task.id));
    });
    test("json method", () {
      taskRepository = TaskRepository();
      taskRepository.addTask(task);

      expect(taskRepository.toJson(), isA<Map<String, dynamic>>());

      expect(TaskRepository.fromJson(taskRepository.toJson()),
          isA<TaskRepository>());
    });
  });
}
