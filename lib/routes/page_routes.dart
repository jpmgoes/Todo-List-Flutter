import 'package:flutter/material.dart';
import 'package:just_todo/pages/todo_bloc_page.dart';

class PageRoutes {
  static String todoBloc = "/";
  static String addTaskPage = "/add-task";
  static String editTaskPage = "/edit-task";

  static toHomePage(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const TodoBlocPage()),
      (Route<dynamic> route) => false,
    );
  }
}
