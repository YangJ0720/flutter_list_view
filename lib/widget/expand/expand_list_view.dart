import 'package:flutter/material.dart';
import 'package:flutter_list_view/provider/revoke_provider.dart';
import 'package:flutter_list_view/widget/expand/model/expand_group_model.dart';
import 'package:flutter_list_view/widget/expand/wrap/expand_wrap.dart';
import 'package:flutter_list_view/widget/slide_view.dart';
import 'package:provider/provider.dart';

class ExpandListView extends StatelessWidget {
  final ExpandGroupModel model;
  final ValueChanged<ExpandGroupModel> valueChanged;
  final ValueChanged<List<ExpandWrap>> listValueChanged;

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
            Text(item.model.name),
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
  Widget _createItemView(context, int index, ExpandWrap item, bool isExpanded) {
    if (isExpanded) {
      // 展开
      return SlideView(
        item.model,
        key: ValueKey(index),
        onTap: () => print('item = ${item.toString()}'),
        callback: () {
          var list = model.list;
          list.remove(item);
          listValueChanged.call(list);
          //
          String json = item.model.toJson();
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
        var action = item.action;
        bool isExpanded = action.isExpanded(model);
        if (item.model.isRoot) {
          return _createItemGroupView(
            index,
            item,
            action.color,
            isExpanded, () {
              action.toggle(model);
              valueChanged.call(model);
            },
          );
        } else {
          return _createItemView(context, index, item, isExpanded);
        }
      },
      itemCount: list.length,
      onReorder: (int oldIndex, int newIndex) {
        print('oldIndex = $oldIndex, newIndex = $newIndex');
        if (oldIndex < newIndex) {
          newIndex -= 1;
          var oldIndexItem = list[oldIndex].model;
          var newIndexItem = list[newIndex].model;
          // 向下拖拽至分组item边界检查
          if (newIndexItem.isRoot) {
            newIndexItem = list[newIndex + 1].model;
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
          var oldIndexItem = list[oldIndex].model;
          var newIndexItem = list[newIndex].model;
          // 向上拖拽至分组item边界检查
          if (newIndexItem.isRoot) {
            newIndexItem = list[newIndex - 1].model;
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
