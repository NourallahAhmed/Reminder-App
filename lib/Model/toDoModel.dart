class ToDo {
  String title;
  String description;
  DateTime startTime;
  DateTime endTime;
  bool isDone;

  ToDo(
      { required this.title,
        this.description = '',
        required this.startTime,
        required this.endTime,
        this.isDone = false});
}