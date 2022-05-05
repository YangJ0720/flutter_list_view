import 'package:flutter/material.dart';
import 'package:flutter_list_view/model/task_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlideView extends StatelessWidget {
  final TaskModel model;

  final VoidCallback callback;

  const SlideView(this.model, {Key key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: ValueKey(model),

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {}),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            // An action can be bigger than the others.
            flex: 2,
            onPressed: (_) {},
            backgroundColor: Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),
          SlidableAction(
            onPressed: (_) {},
            backgroundColor: Color(0xFF0392CF),
            foregroundColor: Colors.white,
            icon: Icons.save,
            label: 'Save',
          ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => this.callback?.call(),
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (_) {},
            backgroundColor: Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: 'Share',
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: ListTile(title: Text(model.name), subtitle: Text(model.dateTime)),
    );
  }
}
