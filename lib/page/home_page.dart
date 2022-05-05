import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_list_view/model/task_model.dart';
import 'package:flutter_list_view/provider/revoke_provider.dart';
import 'package:flutter_list_view/revoke/revoke_queue.dart';
import 'package:flutter_list_view/widget/expand/model/expand_group_date_model.dart';
import 'package:flutter_list_view/widget/expand/model/expand_group_model.dart';
import 'package:flutter_list_view/widget/expand/expand_list_view.dart';
import 'package:flutter_list_view/widget/revoke_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RevokeQueue _queue = RevokeQueue();
  final StreamController<ExpandGroupModel> _controller = StreamController();

  ///
  void _loadData() {
    List<TaskModel> list = [];
    list.add(
      TaskModel('去打架', DateTime(2021, 5, 1, 15, 30, 0).toIso8601String(), true, false),
    ); // 置顶
    list.add(
      TaskModel('去打球', DateTime(2021, 12, 30, 18, 0, 0).toIso8601String(), true, false),
    ); // 置顶
    list.add(
      TaskModel('去洗澡', DateTime(2021, 12, 11, 10, 0, 0).toIso8601String(), false, false),
    ); // 已过期
    list.add(
      TaskModel('去洗碗', DateTime(2022, 1, 1, 8, 0, 0).toIso8601String(), false, false),
    ); // 已过期
    list.add(
      TaskModel('去旅游', DateTime(2022, 10, 1, 8, 0, 0).toIso8601String(), false, false),
    ); // 其他日期
    list.add(
      TaskModel('吃饺子', DateTime(2021, 12, 21, 20, 0, 0).toIso8601String(), false, true),
    ); // 已完成
    this._controller.sink.add(ExpandGroupDateModel.build(list));
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
        child: StreamBuilder<ExpandGroupModel>(
          builder: (_, snapshot) {
            var model = snapshot.requireData;
            return Stack(
              children: [
                Positioned.fill(
                  child: ExpandListView(
                    model,
                    (value) {
                      var model = ExpandGroupDateModel.build(value.list);
                      _controller.sink.add(model);
                    },
                    (value) {
                      _controller.sink.add(ExpandGroupDateModel.build(value));
                      _queue.delay(() {
                        Provider.of<RevokeProvider>(context, listen: false).clear();
                      });
                    },
                  ),
                ),
                Positioned(
                  child: RevokeView(
                    valueChanged: (value) {
                      var list = model.list;
                      value.forEach((element) {
                        list.add(TaskModel.fromJson(element));
                      });
                      _controller.sink.add(ExpandGroupDateModel.build(list));
                      //
                      _queue.cancel();
                    },
                  ),
                  right: 10,
                  bottom: 10,
                ),
              ],
            );
          },
          stream: _controller.stream,
          initialData: ExpandGroupDateModel(),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
