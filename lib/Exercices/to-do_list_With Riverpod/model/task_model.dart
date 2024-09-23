import 'dart:convert';

// Class that will be the Model for a Task Object
class TaskModel {
  final String id;
  String title;
  bool isCompleted;

  //this is a constructor
  //for TaskModel that allows us to create instances of this class
  TaskModel({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  @override
  String toString() =>
      'TaskModel(id: $id, title: $title, isCompleted: $isCompleted)';
  //method that converts a TaskModel object into a map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  // a factory constructor that constructs a TaskModel object from a map
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as String,
      title: map['title'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }
  // method that converts a TaskModel object into a JSON-encoded string
  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
