import 'package:flutter/material.dart';
import 'package:flutter_list_view/model/expand_list_model.dart';
import 'package:flutter_list_view/model/task_model.dart';
import 'package:flutter_list_view/widget/slide_view.dart';

class ExpandListView extends StatelessWidget {
  final ExpandListModel model;
  final ValueChanged<ExpandListModel> valueChanged;

  const ExpandListView(this.model, this.valueChanged, {Key key})
      : super(key: key);

  ///
  Widget _createItemGroupView(index, item, color, isExpanded, callback) {
    return InkWell(
      key: ValueKey(index),
      child: Container(
        child: Row(
          children: [
            Text(item.name),
            Spacer(),
            Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
          ],
        ),
        color: color,
        padding: EdgeInsets.all(10),
      ),
      onTap: () => callback.call(),
      onLongPress: () {},
    );
  }

  ///
  Widget _createItemView(int index, TaskModel item, bool isExpanded) {
    if (isExpanded) {
      // 展开
      return SlideView(item, key: ValueKey(index));
    }
    // 折叠
    return SizedBox(key: ValueKey(index));
  }

  @override
  Widget build(BuildContext context) {
    var list = model.list;
    return ReorderableListView.builder(
      itemBuilder: (_, index) {
        var item = list[index];
        if (model.isTopRange(index)) {
          // 置顶
          if (index == model.sIndexTop) {
            return _createItemGroupView(
              index,
              item,
              Colors.green[200],
              model.isExpandedTop,
              () {
                model.isExpandedTop = !model.isExpandedTop;
                valueChanged.call(model);
              },
            );
          } else {
            return _createItemView(index, item, model.isExpandedTop);
          }
        } else if (model.isOtherRange(index)) {
          // 其他日期
          if (index == model.sIndexOther) {
            return _createItemGroupView(
              index,
              item,
              Colors.red[200],
              model.isExpandedOther,
              () {
                model.isExpandedOther = !model.isExpandedOther;
                valueChanged.call(model);
              },
            );
          } else {
            return _createItemView(index, item, model.isExpandedOther);
          }
        } else if (model.isCompleteRange(index)) {
          // 已完成
          if (index == model.sIndexComplete) {
            return _createItemGroupView(
              index,
              item,
              Colors.blue[200],
              model.isExpandedComplete,
              () {
                model.isExpandedComplete = !model.isExpandedComplete;
                valueChanged.call(model);
              },
            );
          } else {
            return _createItemView(index, item, model.isExpandedComplete);
          }
        }
        return _createItemView(index, item, true);
      },
      itemCount: list.length,
      onReorder: (int oldIndex, int newIndex) {
        print('oldIndex = $oldIndex, newIndex = $newIndex');
        if (oldIndex < newIndex) {
          newIndex -= 1;
          var oldIndexItem = list[oldIndex];
          var newIndexItem = list[newIndex];
          // 向下拖拽至分组item边界检查
          if (newIndexItem.isRoot) {
            newIndexItem = list[newIndex + 1];
          }
          //
          oldIndexItem.isMarkTop = newIndexItem.isMarkTop;
          oldIndexItem.isComplete = newIndexItem.isComplete;
          //
          print('oldIndexItem = ${oldIndexItem.toString()}');
          print('newIndexItem = ${newIndexItem.toString()}');
        } else {
          // 向上拖拽至顶部边界检查
          if (newIndex == 0) {
            newIndex = 1;
          }
          var oldIndexItem = list[oldIndex];
          var newIndexItem = list[newIndex];
          // 向上拖拽至分组item边界检查
          if (newIndexItem.isRoot) {
            newIndexItem = list[newIndex - 1];
          }
          //
          oldIndexItem.isMarkTop = newIndexItem.isMarkTop;
          oldIndexItem.isComplete = newIndexItem.isComplete;
          //
          print('oldIndexItem = ${oldIndexItem.toString()}');
          print('newIndexItem = ${newIndexItem.toString()}');
        }
        //
        var child = list.removeAt(oldIndex);
        list.insert(newIndex, child);
        valueChanged.call(ExpandListModel.factory(list));
      },
    );
  }
}
