class TaskModel {
  int id;
  String text;
  bool isDone;
  int createdAt;

  TaskModel({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.isDone,
  });
}
