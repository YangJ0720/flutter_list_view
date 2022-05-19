import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_list_view/widget/expand/action/expand_action.dart';
import 'package:flutter_list_view/widget/expand/model/expand_group_model.dart';

class ExpandActionComplete extends ExpandAction {
  ExpandActionComplete() : super(Colors.blue[200]);

  @override
  bool isExpanded(ExpandGroupModel model) {
    return model.isExpandedComplete();
  }

  @override
  void toggle(ExpandGroupModel model) {
    bool isExpanded = model.isExpandedComplete();
    model.setExpandedComplete(!isExpanded);
  }
}
