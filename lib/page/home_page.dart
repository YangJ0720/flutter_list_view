import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_list_view/model/expand_list_model.dart';
import 'package:flutter_list_view/widget/expand_list_view.dart';

import '../model/task_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final StreamController<ExpandListModel> _controller = StreamController();

  ///
  void _loadData() {
    List<TaskModel> list = [];
    list.add(TaskModel('下午茶', DateTime(2021, 5, 1, 15, 30, 0), true, false)); // 置顶
    list.add(TaskModel('去打球', DateTime(2021, 12, 30, 18, 0, 0), true, false)); // 置顶
    list.add(TaskModel('去学车', DateTime(2021, 12, 11, 10, 0, 0), false, false)); // 其他日期
    list.add(TaskModel('去爬山', DateTime(2022, 1, 1, 8, 0, 0), false, false)); // 其他日期
    list.add(TaskModel('去旅游', DateTime(2022, 10, 1, 8, 0, 0), false, false)); // 其他日期
    list.add(TaskModel('吃饺子', DateTime(2021, 12, 21, 20, 0, 0), false, true)); // 已完成
    list.add(TaskModel('看电影', DateTime(2022, 1, 1, 20, 0, 0), true, false)); // 置顶
    this._controller.sink.add(ExpandListModel.factory(list));
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    this._controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(DateTime.now().toIso8601String())),
      body: SafeArea(
        child: StreamBuilder<ExpandListModel>(
          builder: (_, snapshot) {
            var model = snapshot.requireData;
            return ExpandListView(model, (value) {
              _controller.sink.add(value);
            });
          },
          stream: _controller.stream,
          initialData: ExpandListModel([]),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
