import 'package:flutter/material.dart';

import '../model/task.dart';

Widget loadingWidgets() {
  return const Center(child: CircularProgressIndicator());
}

Widget semTaskWarnWidget(List<Task> tasks) {
  if (tasks.isEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text("Não há nada aqui"),
          Text("Adicione uma nova task"),
        ],
      ),
    );
  }
  return Container();
}

Widget erroFindTaskWidget() {
  return const Text("Um error foi encontrado 😥");
}
