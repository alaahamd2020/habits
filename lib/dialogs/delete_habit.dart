import 'package:flutter/material.dart';
import 'package:habits/firebase/firebase.dart';
import 'package:habits/model/habits_model.dart';
import 'package:habits/widgets/custom_text.dart';
import 'package:habits/generated/l10n.dart';

class DeleteHabit extends StatefulWidget {
  final HabitsModel item;

  const DeleteHabit({super.key, required this.item});

  static show(BuildContext context, HabitsModel item) {
    showDialog(
      context: context,
      builder: (context) {
        return DeleteHabit(item: item);
      },
    );
  }

  @override
  _DeleteHabitState createState() => _DeleteHabitState();
}

class _DeleteHabitState extends State<DeleteHabit> {
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
      content: TextCustom(S.of(context).delete_habit_confirm, fontSize: 14),
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
            FB.deleteHabit(widget.item);
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
