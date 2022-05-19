import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_list_view/widget/expand/action/expand_action.dart';
import 'package:flutter_list_view/widget/expand/model/expand_group_model.dart';

class ExpandActionOther extends ExpandAction {
  ExpandActionOther() : super(Colors.black12);

  @override
  bool isExpanded(ExpandGroupModel model) {
    return model.isExpandedOther();
  }

  @override
  void toggle(ExpandGroupModel model) {
    bool isExpanded = model.isExpandedOther();
    model.setExpandedOther(!isExpanded);
  }
}
