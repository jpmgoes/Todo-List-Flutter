import 'package:flutter/material.dart';
import 'package:just_todo/pages/add_task_page.dart';
import 'package:just_todo/pages/edit_task_page.dart';
import 'package:just_todo/pages/todo_bloc_page.dart';
import 'package:just_todo/routes/page_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoList',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: PageRoutes.todoBloc,
      routes: {
        PageRoutes.todoBloc: (context) => const TodoBlocPage(),
        PageRoutes.addTaskPage: (context) => const AddTaskPage(),
        PageRoutes.editTaskPage: (context) => const EditTaskPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
