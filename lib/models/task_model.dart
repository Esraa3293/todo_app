class TaskModel {
  String id;
  String title;
  String description;
  int date;
  int dateTime;
  bool status;
  String userId;

  TaskModel({
    this.id = '',
    required this.title,
    required this.description,
    required this.date,
    required this.dateTime,
    required this.status,
    required this.userId,
  });

  TaskModel.fromJson(Map<String, dynamic> json)
    : this(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        date: json['date'],
        dateTime: json['dateTime'],
        status: json['status'],
        userId: json['userId'],
      );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "dateTime": dateTime,
      "status": status,
      "userId": userId,
    };
  }
}
