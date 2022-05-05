class TaskModel {
  String name;
  DateTime dateTime;
  bool isMarkTop;
  bool isComplete;
  bool hasStar;
  final bool isRoot;

  TaskModel(this.name, this.dateTime, this.isMarkTop, this.isComplete, {this.hasStar = false, this.isRoot = false});

  @override
  String toString() {
    return 'TaskModel{name: $name, dateTime: $dateTime, isMarkTop: $isMarkTop, isComplete: $isComplete, hasStar: $hasStar, isRoot: $isRoot}';
  }
}
