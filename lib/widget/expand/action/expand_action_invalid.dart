import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_list_view/widget/expand/action/expand_action.dart';
import 'package:flutter_list_view/widget/expand/model/expand_group_model.dart';

class ExpandActionInvalid extends ExpandAction {
  ExpandActionInvalid() : super(Colors.red[200]);

  @override
  bool isExpanded(ExpandGroupModel model) {
    return model.isExpandedInvalid();
  }

  @override
  void toggle(ExpandGroupModel model) {
    bool isExpanded = model.isExpandedInvalid();
    model.setExpandedInvalid(!isExpanded);
  }
}
