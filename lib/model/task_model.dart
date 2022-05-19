// To parse this JSON data, do
//
//     final taskModel = taskModelFromMap(jsonString);

import 'dart:convert';

class TaskModel {
  TaskModel(
    this.name,
    this.dateTime,
    this.isMarkTop,
    this.isComplete,
    {this.hasStar = false, this.isRoot = false}
  );

  String name;
  String dateTime;
  bool isMarkTop;
  bool isComplete;
  bool hasStar;
  bool isRoot;

  factory TaskModel.fromJson(String str) => TaskModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TaskModel.fromMap(Map<String, dynamic> json) => TaskModel(
    json["name"],
    json["dateTime"],
    json["isMarkTop"],
    json["isComplete"],
    hasStar: json["hasStar"],
    isRoot: json["isRoot"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "dateTime": dateTime,
    "isMarkTop": isMarkTop,
    "isComplete": isComplete,
    "hasStar": hasStar,
    "isRoot": isRoot,
  };

  @override
  String toString() {
    return 'TaskModel{name: $name, dateTime: $dateTime, isMarkTop: $isMarkTop, isComplete: $isComplete, hasStar: $hasStar, isRoot: $isRoot}';
  }
}
