class Task {
  String? title;
  String? description;
  bool completed = false;
  int? id;

  Task({
    this.title = "",
    this.description = "",
    this.completed = false,
    required this.id,
  });

  Task.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    completed = json['completed'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['completed'] = completed;
    data['id'] = id;

    return data;
  }

  @override
  String toString() {
    final mapToPrint = {
      "title": title,
      "description": description,
      "completed": completed,
      "id": id
    };
    return "[$title|$completed|id=$id]";
  }
}
