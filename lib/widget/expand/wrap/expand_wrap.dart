import 'package:flutter_list_view/model/task_model.dart';
import 'package:flutter_list_view/widget/expand/action/expand_action.dart';

class ExpandWrap {
  TaskModel model;
  ExpandAction action;

  ExpandWrap(this.model, this.action);

  @override
  String toString() {
    return 'ExpandWrap{model: $model, action: $action}';
  }
}