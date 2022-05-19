import 'package:flutter/material.dart';
import 'package:flutter_list_view/widget/expand/model/expand_group_model.dart';

abstract class ExpandAction {
  Color color;

  ExpandAction(this.color);

  bool isExpanded(ExpandGroupModel model);

  void toggle(ExpandGroupModel model);

  @override
  String toString() {
    return 'ExpandAction{color: $color}';
  }
}
