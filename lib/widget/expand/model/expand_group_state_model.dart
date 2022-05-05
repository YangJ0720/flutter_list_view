import 'package:flutter_list_view/widget/expand/model/expand_group_item_model.dart';
import 'package:flutter_list_view/widget/expand/model/expand_group_model.dart';
import 'package:flutter_list_view/model/task_model.dart';

/// 按状态
class ExpandGroupStateModel extends ExpandGroupModel {
  /// 置顶
  ExpandGroupItemModel top = ExpandGroupItemModel([]);

  @override
  bool isTopRange(int index) => top.isRange(index);

  @override
  bool isExpandedTop() => top.isExpanded;

  @override
  void setExpandedTop(bool isExpanded) => top.isExpanded = isExpanded;

  /// 已过期
  ExpandGroupItemModel invalid = ExpandGroupItemModel([]);

  @override
  bool isInvalidRange(int index) => invalid.isRange(index);

  @override
  bool isExpandedInvalid() => invalid.isExpanded;

  @override
  void setExpandedInvalid(bool isExpanded) => invalid.isExpanded = isExpanded;

  /// 今天
  ExpandGroupItemModel today = ExpandGroupItemModel([]);

  @override
  bool isTodayRange(int index) => today.isRange(index);

  @override
  bool isExpandedToday() => today.isExpanded;

  @override
  void setExpandedToday(bool isExpanded) => today.isExpanded = isExpanded;

  /// 其他日期

  @override
  bool isOtherRange(int index) => false;

  @override
  bool isExpandedOther() => false;

  @override
  void setExpandedOther(bool isExpanded) {}

  /// 没有日期

  @override
  bool isNoDateRange(int index) => false;

  @override
  bool isExpandedNoDate() => false;

  @override
  void setExpandedNoDate(bool isExpanded) {}

  /// 有星标
  ExpandGroupItemModel hasStar = ExpandGroupItemModel([]);

  @override
  bool isHasStarRange(int index) => hasStar.isRange(index);

  @override
  bool isExpandedHasStar() => hasStar.isExpanded;

  @override
  void setExpandedHasStar(bool isExpanded) => hasStar.isExpanded = isExpanded;

  /// 无星标
  ExpandGroupItemModel noStar = ExpandGroupItemModel([]);

  @override
  bool isNoStarRange(int index) => noStar.isRange(index);

  @override
  bool isExpandedNoStar() => noStar.isExpanded;

  @override
  void setExpandedNoStar(bool isExpanded) => noStar.isExpanded = isExpanded;

  /// 已完成
  ExpandGroupItemModel complete = ExpandGroupItemModel([]);

  @override
  bool isCompleteRange(int index) => complete.isRange(index);

  @override
  bool isExpandedComplete() => complete.isExpanded;

  @override
  void setExpandedComplete(bool isExpanded) => complete.isExpanded = isExpanded;

  @override
  void contains(DateTime currentDateTime, TaskModel model) {
    if (model.isMarkTop) {
      // 置顶
      top.list.add(model);
    } else if (model.isComplete) {
      // 已完成
      complete.list.add(model);
    } else if (model.hasStar) {
      // 有星标
      hasStar.list.add(model);
    } else if (currentDateTime.difference(model.dateTime).inDays > 0) {
      // 已过期
      invalid.list.add(model);
    } else {
      // 无星标
      noStar.list.add(model);
    }
  }

  List<TaskModel> toList() {
    List<TaskModel> list = [];
    // 置顶
    var topList = top.list;
    if (topList.isNotEmpty) {
      top.sIndex = list.length;
      list.add(TaskModel('置顶', DateTime.now(), false, false, isRoot: true));
      list.addAll(topList);
      top.eIndex = list.length - 1;
    }
    // 已过期
    var invalidList = invalid.list;
    if (invalidList.isNotEmpty) {
      invalid.sIndex = list.length;
      list.add(TaskModel('已过期', DateTime.now(), false, false, isRoot: true));
      list.addAll(invalidList);
      invalid.eIndex = list.length - 1;
    }
    // 今天
    var todayList = today.list;
    if (todayList.isNotEmpty) {
      today.sIndex = list.length;
      list.add(TaskModel('今天', DateTime.now(), false, false, isRoot: true));
      list.addAll(todayList);
      today.eIndex = list.length - 1;
    }
    // 其他日期

    // 没有日期

    // 有星标
    var hasStarList = hasStar.list;
    if (hasStarList.isNotEmpty) {
      hasStar.sIndex = list.length;
      list.add(TaskModel('有星标', DateTime.now(), false, false, isRoot: true));
      list.addAll(hasStarList);
      hasStar.eIndex = list.length - 1;
    }
    // 无星标
    var noStarList = noStar.list;
    if (noStarList.isNotEmpty) {
      noStar.sIndex = list.length;
      list.add(TaskModel('无星标', DateTime.now(), false, false, isRoot: true));
      list.addAll(noStarList);
      noStar.eIndex = list.length - 1;
    }
    // 已完成
    var completeList = complete.list;
    if (completeList.isNotEmpty) {
      complete.sIndex = list.length;
      list.add(TaskModel('已完成', DateTime.now(), false, false, isRoot: true));
      list.addAll(completeList);
      complete.eIndex = list.length - 1;
    }
    return list;
  }

  static ExpandGroupModel build(List<TaskModel> list) {
    ExpandGroupStateModel model = ExpandGroupStateModel();
    DateTime currentDateTime = DateTime.now();
    list.forEach((element) {
      if (element.isRoot) {
        //
      } else {
        model.contains(currentDateTime, element);
      }
    });
    model.list.addAll(model.toList());
    return model;
  }
}
