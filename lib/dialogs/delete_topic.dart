import 'package:flutter/material.dart';
import 'package:habits/firebase/firebase.dart';
import 'package:habits/model/topic_model.dart';
import 'package:habits/widgets/custom_text.dart';
import 'package:habits/generated/l10n.dart';

class DeleteTopic extends StatefulWidget {
  final TopicModel item;

  const DeleteTopic({super.key, required this.item});

  static show(BuildContext context, TopicModel item) {
    showDialog(
      context: context,
      builder: (context) {
        return DeleteTopic(item: item);
      },
    );
  }

  @override
  _DeleteTopicState createState() => _DeleteTopicState();
}

class _DeleteTopicState extends State<DeleteTopic> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Icon(
            Icons.warning_rounded,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(width: 8),
          TextCustom(S.of(context).delete, fontSize: 18, bold: true),
        ],
      ),
      content: TextCustom(S.of(context).delete_topic_confirm, fontSize: 14),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: TextCustom(
            S.of(context).cancel,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            FB.deleteTopic(widget.item);
          },
          child: TextCustom(
            S.of(context).delete,
            color: Theme.of(context).colorScheme.error,
            bold: true,
          ),
        ),
      ],
    );
  }
}
