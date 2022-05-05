import 'package:flutter/material.dart';
import 'package:flutter_list_view/provider/revoke_provider.dart';
import 'package:provider/provider.dart';

class RevokeView extends StatelessWidget {
  final ValueChanged<List<String>> valueChanged;

  const RevokeView({Key key, this.valueChanged}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<RevokeProvider>(builder: (_, value, child) {
      if (value.isEmpty()) {
        return Container();
      }
      return ClipOval(
        child: Container(
          child: IconButton(
            onPressed: () {
              valueChanged?.call(value.list);
              value.clear();
            },
            icon: Icon(Icons.refresh, color: Colors.white),
          ),
          color: Colors.blue,
        ),
      );
    });
  }

}