class TaskModel {
  String name;
  DateTime dateTime;
  bool isMarkTop;
  bool isComplete;
  final bool isRoot;

  TaskModel(this.name, this.dateTime, this.isMarkTop, this.isComplete, {this.isRoot = false});

  @override
  String toString() {
    return 'TaskModel{name: $name, dateTime: $dateTime, isMarkTop: $isMarkTop, isComplete: $isComplete, isRoot: $isRoot}';
  }
}
