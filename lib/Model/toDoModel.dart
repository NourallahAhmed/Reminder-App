class ToDo {
  int id;
  String title;
  String description;
  DateTime startTime;
  DateTime endTime;
  bool isDone;

  ToDo(this.id ,
      { required this.title,
        this.description = '',
        required this.startTime,
        required this.endTime,
        this.isDone = false});


  ///serialization

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "startTime": startTime.toIso8601String(),
      "endTime": endTime.toIso8601String(),

      "isDone": isDone ? 1 : 0 ,
    };
  }
}