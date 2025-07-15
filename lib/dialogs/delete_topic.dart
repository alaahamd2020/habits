import 'package:flutter/material.dart';
import 'package:habits/fire_store_habits.dart';
import 'package:habits/firebase/firebase.dart';
import 'package:habits/model/habits_model.dart';
import 'package:habits/model/topic_model.dart';
import 'package:habits/widgets/custom_text.dart';

class DeleteTopic extends StatefulWidget {
  final TopicModel item;


  const DeleteTopic({super.key, required this.item});

  static show(BuildContext context, TopicModel item) {
    showDialog(
        context: context,
        builder: (context){
          return DeleteTopic(item: item,);
        });
  }
  @override
  _DeleteTopicState createState() => _DeleteTopicState();
}

class _DeleteTopicState extends State<DeleteTopic> {
  @override
  Widget build(BuildContext context) {
     return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(
              Icons.warning_rounded,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(width: 8),
            TextCustom(
              'Delete Record',
              fontSize: 18,
              bold: true,
            ),
          ],
        ),
        content: TextCustom(
          'Are you sure you want to delete this record? This action cannot be undone.',
          fontSize: 14,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: TextCustom(
              'Cancel',
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              FB.deleteTopic(widget.item);
            },
            child: TextCustom(
              'Delete',
              color: Theme.of(context).colorScheme.error,
              bold: true,
            ),
          ),
        ],
     );
  }
}
