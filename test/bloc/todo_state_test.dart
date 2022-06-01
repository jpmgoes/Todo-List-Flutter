import 'package:flutter_test/flutter_test.dart';
import 'package:just_todo/bloc/todo_state.dart';
import 'package:just_todo/model/task.dart';

void main() {
  List<Task> tasks = [];
  InicialTaskState inicialTaskState = InicialTaskState();
  TaskSuccessState taskSuccessState = TaskSuccessState(tasks: tasks);

  group("Teste TaskRepository method", () {
    test("AddTaskEvent extends TaskEvent", () {
      expect(inicialTaskState, allOf(isA<TaskState>()));
      expect(inicialTaskState.tasks, equals([]));
    });
    test("RemoveTaskEvent extends TaskEvent", () {
      expect(taskSuccessState, isA<TaskState>());
    });
  });
}
