import 'package:flutter_test/flutter_test.dart';
import 'package:just_todo/model/task.dart';
import 'package:just_todo/repository/task_repository.dart';

void main() {
  TaskRepository taskRepository = TaskRepository();
  Task task = Task(id: 0);

  group("Teste TaskRepository method", () {
    test("It should replace a task in list task", () {
      taskRepository.addTask(task);
      Task taskTest = Task(title: "ok", id: 0);
      expect(taskRepository.replace(taskTest), isA<TaskRepository>());
      expect(taskRepository.getTasks()[0].title, equals("ok"));
      taskRepository.removeTask(task);
    });

    test("It should add task to list task and return a TaskRepository", () {
      expect(taskRepository.addTaskReturningThis(task), isA<TaskRepository>());
      expect(taskRepository.getTasks().length, equals(2));
    });
    test("It should remove a task in list task and return TaskRepository", () {
      expect(
          taskRepository.removeTaskRetuningThis(task), isA<TaskRepository>());
      taskRepository.addTask(task);
    });
    test("It should add task to list task", () {
      expect(taskRepository.removeTask(task), isA<List<Task>>());
      taskRepository.addTask(task);
    });
    test("It should change the completed", () {
      taskRepository = TaskRepository();
      taskRepository.addTask(task);
      expect(
          taskRepository.changeCompleted(task), allOf(isA<TaskRepository>()));
      expect(taskRepository.getTasks()[0].completed, equals(true));
    });
    test("It should return a list of tasks", () {
      expect(taskRepository.getTasks(), isA<List<Task>>());
    });
    test("It should return 'this'", () {
      expect(taskRepository.getRepo(task), equals(taskRepository));
    });
    test("It should add task to task and return a list of tasks", () {
      expect(taskRepository.addTask(task)[0].id, equals(task.id));
    });
    test(
      "It should convert the TaskReposiory into json-like code and return this json-like code",
      () {
        Task task2 = Task(id: 0, title: "title");
        final taskRepository2 = TaskRepository();
        taskRepository2.addTask(task2);
        expect(
          taskRepository2.toJson(),
          isA<Map<String, dynamic>>(),
        );
      },
    );
  });
}
