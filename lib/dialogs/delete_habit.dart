import 'package:flutter/material.dart';
import 'package:habits/fire_store_habits.dart';
import 'package:habits/widgets/custom_text.dart';

class DeleteHabit extends StatefulWidget {
  final String id;


  DeleteHabit({required this.id});

  static show(BuildContext context, String id){
    showDialog(
        context: context,
        builder: (context){
          return DeleteHabit(id: id,);
        });
  }
  @override
  _DeleteHabitState createState() => _DeleteHabitState();
}

class _DeleteHabitState extends State<DeleteHabit> {
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
              FireStoreHabits().delete(widget.id);
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
