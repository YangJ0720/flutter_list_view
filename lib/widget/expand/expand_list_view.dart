import 'package:flutter/material.dart';
import 'package:flutter_list_view/provider/revoke_provider.dart';
import 'package:flutter_list_view/widget/expand/model/expand_group_model.dart';
import 'package:flutter_list_view/model/task_model.dart';
import 'package:flutter_list_view/widget/slide_view.dart';
import 'package:provider/provider.dart';

class ExpandListView extends StatelessWidget {
  final ExpandGroupModel model;
  final ValueChanged<ExpandGroupModel> valueChanged;
  final ValueChanged<List<TaskModel>> listValueChanged;

  const ExpandListView(this.model, this.valueChanged, this.listValueChanged,
      {Key key})
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
  Widget _createItemView(context, int index, TaskModel item, bool isExpanded) {
    if (isExpanded) {
      // 展开
      return SlideView(
        item,
        key: ValueKey(index),
        callback: () {
          var list = model.list;
          list.remove(item);
          listValueChanged.call(list);
          //
          String json = item.toJson();
          Provider.of<RevokeProvider>(context, listen: false).put(json);
        },
      );
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
          if (item.isRoot) {
            return _createItemGroupView(
              index,
              item,
              Colors.green[200],
              model.isExpandedTop(),
              () {
                model.setExpandedTop(!model.isExpandedTop());
                valueChanged.call(model);
              },
            );
          } else {
            return _createItemView(context, index, item, model.isExpandedTop());
          }
        } else if (model.isInvalidRange(index)) {
          // 已过期
          if (item.isRoot) {
            return _createItemGroupView(
              index,
              item,
              Colors.red[200],
              model.isExpandedInvalid(),
              () {
                model.setExpandedInvalid(!model.isExpandedInvalid());
                valueChanged.call(model);
              },
            );
          } else {
            return _createItemView(context, index, item, model.isExpandedInvalid());
          }
        } else if (model.isOtherRange(index)) {
          // 其他日期
          if (item.isRoot) {
            return _createItemGroupView(
              index,
              item,
              Colors.yellow[200],
              model.isExpandedOther(),
              () {
                model.setExpandedOther(!model.isExpandedOther());
                valueChanged.call(model);
              },
            );
          } else {
            return _createItemView(context, index, item, model.isExpandedOther());
          }
        } else if (model.isCompleteRange(index)) {
          // 已完成
          if (item.isRoot) {
            return _createItemGroupView(
              index,
              item,
              Colors.blue[200],
              model.isExpandedComplete(),
              () {
                model.setExpandedComplete(!model.isExpandedComplete());
                valueChanged.call(model);
              },
            );
          } else {
            return _createItemView(context, index, item, model.isExpandedComplete());
          }
        } else if (model.isHasStarRange(index)) {
          // 有星标
          if (item.isRoot) {
            return _createItemGroupView(
              index,
              item,
              Colors.orange[200],
              model.isExpandedHasStar(),
              () {
                model.setExpandedHasStar(!model.isExpandedHasStar());
                valueChanged.call(model);
              },
            );
          } else {
            return _createItemView(context, index, item, model.isExpandedHasStar());
          }
        } else {
          // 无星标
          if (item.isRoot) {
            return _createItemGroupView(
              index,
              item,
              Colors.brown[200],
              model.isExpandedNoStar(),
              () {
                model.setExpandedNoStar(!model.isExpandedNoStar());
                valueChanged.call(model);
              },
            );
          } else {
            return _createItemView(context, index, item, model.isExpandedNoStar());
          }
        }
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
          // oldIndexItem.isComplete = newIndexItem.isComplete;
          // oldIndexItem.hasStar = newIndexItem.hasStar;
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
          // oldIndexItem.isComplete = newIndexItem.isComplete;
          // oldIndexItem.hasStar = newIndexItem.hasStar;
          //
          print('oldIndexItem = ${oldIndexItem.toString()}');
          print('newIndexItem = ${newIndexItem.toString()}');
          print('hasStar = ${newIndexItem.toString()}');
        }
        //
        var child = list.removeAt(oldIndex);
        list.insert(newIndex, child);
        listValueChanged.call(list);
      },
    );
  }
}
