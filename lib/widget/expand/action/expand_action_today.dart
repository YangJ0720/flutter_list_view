import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_list_view/widget/expand/action/expand_action.dart';
import 'package:flutter_list_view/widget/expand/model/expand_group_model.dart';

class ExpandActionToday extends ExpandAction {
  ExpandActionToday() : super(Colors.green[200]);

  @override
  bool isExpanded(ExpandGroupModel model) {
    return model.isExpandedToday();
  }

  @override
  void toggle(ExpandGroupModel model) {
    bool isExpanded = model.isExpandedToday();
    model.setExpandedToday(!isExpanded);
  }
}
