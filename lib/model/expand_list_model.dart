import 'package:flutter_list_view/model/task_model.dart';

class ExpandListModel {
  ///
  int sIndexTop;

  ///
  int eIndexTop;

  ///
  bool isExpandedTop;

  ///
  int sIndexOther;

  ///
  int eIndexOther;

  ///
  bool isExpandedOther;

  ///
  int sIndexComplete;

  ///
  int eIndexComplete;

  ///
  bool isExpandedComplete;

  ///
  List<TaskModel> list;

  ExpandListModel(
    this.list, {
    this.sIndexTop = -1,
    this.eIndexTop = -1,
    this.isExpandedTop = true,
    this.sIndexOther = -1,
    this.eIndexOther = -1,
    this.isExpandedOther = true,
    this.sIndexComplete = -1,
    this.eIndexComplete = -1,
    this.isExpandedComplete = true,
  });

  factory ExpandListModel.factory(List<TaskModel> list) {
    List<TaskModel> data = [];
    List<TaskModel> topList = [];
    List<TaskModel> otherList = [];
    List<TaskModel> completeList = [];
    list.forEach((element) {
      if (!element.isRoot) {
        if (element.isMarkTop) {
          // 置顶
          topList.add(element);
        } else if (element.isComplete) {
          // 已完成
          completeList.add(element);
        } else {
          // 其他日期
          otherList.add(element);
        }
      }
    });
    // 置顶
    int sIndexTop = -1;
    int eIndexTop = -1;
    if (topList.isNotEmpty) {
      sIndexTop = 0;
      data.add(TaskModel('置顶', DateTime.now(), false, false, isRoot: true));
      data.addAll(topList);
      eIndexTop = data.length - 1;
    }
    // 其他日期
    int sIndexOther = -1;
    int eIndexOther = -1;
    if (otherList.isNotEmpty) {
      sIndexOther = data.length;
      data.add(TaskModel('其他日期', DateTime.now(), false, false, isRoot: true));
      data.addAll(otherList);
      eIndexOther = data.length - 1;
    }
    // 已完成
    int sIndexComplete = -1;
    int eIndexComplete = -1;
    if (completeList.isNotEmpty) {
      sIndexComplete = data.length;
      data.add(TaskModel('已完成', DateTime.now(), false, false, isRoot: true));
      data.addAll(completeList);
      eIndexComplete = data.length - 1;
    }
    return ExpandListModel(
      data,
      sIndexTop: sIndexTop,
      eIndexTop: eIndexTop,
      sIndexOther: sIndexOther,
      eIndexOther: eIndexOther,
      sIndexComplete: sIndexComplete,
      eIndexComplete: eIndexComplete,
    );
  }

  ///
  bool isTopRange(int index) => sIndexTop <= index && index <= eIndexTop;

  ///
  bool isOtherRange(int index) => sIndexOther <= index && index <= eIndexOther;

  ///
  bool isCompleteRange(int index) => sIndexComplete <= index && index <= eIndexComplete;

}