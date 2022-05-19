import 'package:flutter/material.dart';
import 'package:flutter_list_view/widget/expand/action/expand_action.dart';
import 'package:flutter_list_view/widget/expand/model/expand_group_model.dart';

class ExpandActionTop extends ExpandAction {
  ExpandActionTop() : super(Colors.green[200]);

  @override
  bool isExpanded(ExpandGroupModel model) {
    return model.isExpandedTop();
  }

  @override
  void toggle(ExpandGroupModel model) {
    bool isExpanded = model.isExpandedTop();
    model.setExpandedTop(!isExpanded);
  }

}
