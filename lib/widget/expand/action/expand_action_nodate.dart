import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_list_view/widget/expand/action/expand_action.dart';
import 'package:flutter_list_view/widget/expand/model/expand_group_model.dart';

class ExpandActionNoDate extends ExpandAction {
  ExpandActionNoDate() : super(Colors.grey[200]);

  @override
  bool isExpanded(ExpandGroupModel model) {
    return model.isExpandedNoDate();
  }

  @override
  void toggle(ExpandGroupModel model) {
    bool isExpanded = model.isExpandedNoDate();
    model.setExpandedNoDate(!isExpanded);
  }
}
