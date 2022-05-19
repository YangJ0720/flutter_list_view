import 'package:flutter_list_view/model/task_model.dart';
import 'package:flutter_list_view/widget/expand/wrap/expand_wrap.dart';

abstract class ExpandGroupModel {

  ///
  List<ExpandWrap> list = [];

  /// 置顶
  bool isTopRange(int index);
  bool isExpandedTop();
  void setExpandedTop(bool isExpanded) {}

  /// 已过期
  bool isInvalidRange(int index);
  bool isExpandedInvalid();
  void setExpandedInvalid(bool isExpanded) {}

  /// 今天
  bool isTodayRange(int index);
  bool isExpandedToday();
  void setExpandedToday(bool isExpanded) {}

  /// 其他日期
  bool isOtherRange(int index);
  bool isExpandedOther();
  void setExpandedOther(bool isExpanded) {}

  /// 没有日期
  bool isNoDateRange(int index);
  bool isExpandedNoDate();
  void setExpandedNoDate(bool isExpanded) {}

  /// 有星标
  bool isHasStarRange(int index);
  bool isExpandedHasStar();
  void setExpandedHasStar(bool isExpanded) {}

  /// 无星标
  bool isNoStarRange(int index);
  bool isExpandedNoStar();
  void setExpandedNoStar(bool isExpanded) {}

  /// 已完成
  bool isCompleteRange(int index);
  bool isExpandedComplete();
  void setExpandedComplete(bool isExpanded) {}

  void contains(DateTime currentDateTime, TaskModel model);

  List<ExpandWrap> toList();
}
