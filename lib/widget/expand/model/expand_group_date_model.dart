import 'package:flutter_list_view/widget/expand/action/expand_action_complete.dart';
import 'package:flutter_list_view/widget/expand/action/expand_action_invalid.dart';
import 'package:flutter_list_view/widget/expand/action/expand_action_nodate.dart';
import 'package:flutter_list_view/widget/expand/action/expand_action_other.dart';
import 'package:flutter_list_view/widget/expand/action/expand_action_today.dart';
import 'package:flutter_list_view/widget/expand/action/expand_action_top.dart';
import 'package:flutter_list_view/widget/expand/model/expand_group_item_model.dart';
import 'package:flutter_list_view/model/task_model.dart';
import 'package:flutter_list_view/widget/expand/model/expand_group_model.dart';
import 'package:flutter_list_view/widget/expand/wrap/expand_wrap.dart';

/// 按日期
class ExpandGroupDateModel extends ExpandGroupModel {
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
  ExpandGroupItemModel other = ExpandGroupItemModel([]);

  @override
  bool isOtherRange(int index) => other.isRange(index);

  @override
  bool isExpandedOther() => other.isExpanded;

  @override
  void setExpandedOther(bool isExpanded) => other.isExpanded = isExpanded;

  /// 没有日期
  ExpandGroupItemModel noDate = ExpandGroupItemModel([]);

  @override
  bool isNoDateRange(int index) => noDate.isRange(index);

  @override
  bool isExpandedNoDate() => noDate.isExpanded;

  @override
  void setExpandedNoDate(bool isExpanded) => noDate.isExpanded = isExpanded;

  /// 有星标

  @override
  bool isHasStarRange(int index) => false;

  @override
  bool isExpandedHasStar() => false;

  @override
  void setExpandedHasStar(bool isExpanded) {}

  /// 无星标

  @override
  bool isNoStarRange(int index) => false;

  @override
  bool isExpandedNoStar() => false;

  @override
  void setExpandedNoStar(bool isExpanded) {}

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
      top.list.add(ExpandWrap(model, ExpandActionTop()));
    } else if (model.isComplete) {
      // 已完成
      complete.list.add(ExpandWrap(model, ExpandActionComplete()));
    } else if (currentDateTime.difference(DateTime.parse(model.dateTime)).inDays > 0) {
      // 已过期
      invalid.list.add(ExpandWrap(model, ExpandActionInvalid()));
    } else if (currentDateTime.difference(DateTime.parse(model.dateTime)).inDays == 0) {
      // 今天
      today.list.add(ExpandWrap(model, ExpandActionToday()));
    } else {
      // 其他日期
      other.list.add(ExpandWrap(model, ExpandActionOther()));
    }
  }

  List<ExpandWrap> toList() {
    List<ExpandWrap> list = [];
    // 置顶
    var topList = top.list;
    if (topList.isNotEmpty) {
      top.sIndex = list.length;
      var taskModel = TaskModel(
        '置顶',
        DateTime.now().toIso8601String(),
        false,
        false,
        isRoot: true,
      );
      list.add(ExpandWrap(taskModel, ExpandActionTop()));
      list.addAll(topList);
      top.eIndex = list.length - 1;
    }
    // 已过期
    var invalidList = invalid.list;
    if (invalidList.isNotEmpty) {
      invalid.sIndex = list.length;
      var taskModel = TaskModel(
        '已过期',
        DateTime.now().toIso8601String(),
        false,
        false,
        isRoot: true,
      );
      list.add(ExpandWrap(taskModel, ExpandActionInvalid()));
      list.addAll(invalidList);
      invalid.eIndex = list.length - 1;
    }
    // 今天
    var todayList = today.list;
    if (todayList.isNotEmpty) {
      today.sIndex = list.length;
      var taskModel = TaskModel(
        '今天',
        DateTime.now().toIso8601String(),
        false,
        false,
        isRoot: true,
      );
      list.add(ExpandWrap(taskModel, ExpandActionToday()));
      list.addAll(todayList);
      today.eIndex = list.length - 1;
    }
    // 其他日期
    var otherList = other.list;
    if (otherList.isNotEmpty) {
      other.sIndex = list.length;
      var taskModel = TaskModel(
        '其他日期',
        DateTime.now().toIso8601String(),
        false,
        false,
        isRoot: true,
      );
      list.add(ExpandWrap(taskModel, ExpandActionOther()));
      list.addAll(otherList);
      other.eIndex = list.length - 1;
    }
    // 没有日期
    var noDateList = noDate.list;
    if (noDateList.isNotEmpty) {
      noDate.sIndex = list.length;
      var taskModel = TaskModel(
        '没有日期',
        DateTime.now().toIso8601String(),
        false,
        false,
        isRoot: true,
      );
      list.add(ExpandWrap(taskModel, ExpandActionNoDate()));
      list.addAll(noDateList);
      noDate.eIndex = list.length - 1;
    }
    // 已完成
    var completeList = complete.list;
    if (completeList.isNotEmpty) {
      complete.sIndex = list.length;
      var taskModel = TaskModel(
        '已完成',
        DateTime.now().toIso8601String(),
        false,
        false,
        isRoot: true,
      );
      list.add(ExpandWrap(taskModel, ExpandActionComplete()));
      list.addAll(completeList);
      complete.eIndex = list.length - 1;
    }
    return list;
  }

  static ExpandGroupModel buildByTaskModel(List<TaskModel> list) {
    ExpandGroupDateModel model = ExpandGroupDateModel();
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

  static ExpandGroupModel buildByExpandWrap(List<ExpandWrap> list) {
    ExpandGroupDateModel model = ExpandGroupDateModel();
    DateTime currentDateTime = DateTime.now();
    list.forEach((element) {
      var item = element.model;
      if (item.isRoot) {
        //
      } else {
        model.contains(currentDateTime, item);
      }
    });
    model.list.addAll(model.toList());
    return model;
  }
}
