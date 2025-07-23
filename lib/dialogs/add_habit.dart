import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habits/extension/on_date_time.dart';
import 'package:habits/firebase/firebase.dart';
import 'package:habits/model/habits_model.dart';
import 'package:habits/model/topic_model.dart';
import 'package:intl/intl.dart';
import '../widgets/custom_text.dart';

class AddHabit extends StatefulWidget {
  final TopicModel topicModel;
  const AddHabit({super.key, required this.topicModel});
  static show(BuildContext context, TopicModel topicModel) {
    showDialog(
      context: context,
      builder: (context) {
        return AddHabit(topicModel: topicModel,);
      },
    );
  }
  @override
  State<AddHabit> createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  DateTime _dateTime = DateTime.now();

  int _count = 1;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FB.allHabits( widget.topicModel.id!),
      builder: (context, asyncSnapshot) {
        final list = asyncSnapshot.data ?? [];
        DateTime lastDay = list.lastOrNull?.date.toDate() ?? widget.topicModel.createdAt;
        final canAdd = _dateTime.withoutTime.isBefore(DateTime.now().withoutTime);
        final canSubtract = _dateTime.withoutTime.isAfter(lastDay);
        final canSubmit = _dateTime.subtract(Duration(days: 1)).withoutTime.isBefore(DateTime.now().withoutTime) &&  _dateTime.add(Duration(days: 1)).withoutTime.isAfter(lastDay);
        final canCount =  _count == 1;
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.surface,
                    Theme.of(
                      context,
                    ).colorScheme.surfaceVariant.withOpacity(0.8),
                  ],
                ),
                
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(
                      context,
                    ).colorScheme.shadow.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header with icon and title
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.primary,
                                Theme.of(context).colorScheme.secondary,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.add_task_rounded,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextCustom(
                                'Add New Habit',
                                fontSize: 22,
                                bold: true,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              const SizedBox(height: 4),
                              TextCustom(
                                'Track your target',
                                fontSize: 14,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Date Selection Section
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primaryContainer.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).colorScheme.outline.withOpacity(0.2),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_rounded,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                TextCustom(
                                  'Select Date',
                                  fontSize: 16,
                                  bold: true,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color:  Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                // Previous Day Button
                                IconButton(
                                  onPressed: canSubtract ? () {
                                    setState(() {
                                        _dateTime = _dateTime.subtract(
                                            Duration(days: 1));
                                    });
                                  }:null,
                                  icon: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: !canSubtract ? Colors.grey.shade200 : Theme.of(
                                        context,
                                      ).colorScheme.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.chevron_left_rounded,
                                      color:!canSubtract ? Colors.grey.shade500: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      size: 24,
                                    ),
                                  ),
                                ),

                                // Date Display
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      final newDate = await addDate(lastDay);
                                      setState(() {
                                        _dateTime = newDate ?? _dateTime;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer
                                            .withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        children: [
                                          TextCustom(
                                            DateFormat.EEEE(
                                              'ar',
                                            ).format(_dateTime),
                                            alignment: TextAlign.center,
                                            fontSize: 16,
                                            bold: true,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onPrimaryContainer,
                                          ),
                                          const SizedBox(height: 4),
                                          TextCustom(
                                            DateFormat('M/d').format(_dateTime),
                                            alignment: TextAlign.center,
                                            fontSize: 14,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimaryContainer
                                                .withOpacity(0.8),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                // Next Day Button
                                IconButton(
                                  onPressed: canAdd?() {
                                    setState(() {
                                      _dateTime = _dateTime.add(
                                        Duration(days: 1),
                                      );
                                    });
                                  }:null,
                                  icon: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: !canAdd ? Colors.grey.shade200 : Theme.of(
                                        context,
                                      ).colorScheme.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.chevron_right_rounded,
                                      color:  !canAdd ? Colors.grey.shade500 : Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),
                    // Count Selection Section
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.secondaryContainer.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).colorScheme.outline.withOpacity(0.2),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.repeat_rounded,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                TextCustom(
                                  'Times',
                                  fontSize: 16,
                                  bold: true,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                // Decrease Button
                                IconButton(
                                  onPressed: !canCount ? () {
                                    setState(() {
                                     _count--;
                                    });
                                  } : null,
                                  icon: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: canCount ? Colors.grey.shade200 : Theme.of(
                                        context,
                                      ).colorScheme.error.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.remove_rounded,
                                      color: canCount ? Colors.grey.shade500 : Theme.of(
                                        context,
                                      ).colorScheme.error,
                                      size: 24,
                                    ),
                                  ),
                                ),

                                // Count Display
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Theme.of(context)
                                              .colorScheme
                                              .secondary
                                              .withOpacity(0.1),
                                          Theme.of(context)
                                              .colorScheme
                                              .secondary
                                              .withOpacity(0.05),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        TextCustom(
                                          _count.toString(),
                                          alignment: TextAlign.center,
                                          fontSize: 32,
                                          bold: true,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                        ),
                                        TextCustom(
                                          'times',
                                          alignment: TextAlign.center,
                                          fontSize: 12,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSecondaryContainer,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // Increase Button
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _count++;
                                    });
                                  },
                                  icon: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.add_rounded,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Action Buttons
                    Row(
                      children: [
                        // Cancel Button
                        Expanded(
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.outline.withOpacity(0.3),
                                ),
                              ),
                            ),
                            child: TextCustom(
                              'Cancel',
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                              fontSize: 16,
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Add Button
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).colorScheme.primary,
                                  Theme.of(context).colorScheme.secondary,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: TextButton(
                              onPressed: canSubmit ? ()  {
                                final HabitsModel newData = HabitsModel(
                                  '',
                                  _count,
                                  widget.topicModel.currentStreakAdd(lastDay, _dateTime),
                                  _dateTime.toTimestamp,
                                  widget.topicModel.id!,
                                );
                                FB.addHabit(
                                  newData,
                                );
                                Navigator.pop(context);
                              } : null,
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                backgroundColor: canSubmit ? Colors.transparent : Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_rounded,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  TextCustom(
                                    'Add Habit',
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                    fontSize: 16,
                                    bold: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

      },

    );
  }



  Future<DateTime?> addDate(DateTime lastDay) {
    return showDatePicker(
      context: context,
      firstDate: lastDay,
      lastDate: Timestamp.now().toDate(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Theme.of(context).colorScheme.primary,
              surface: Theme.of(context).colorScheme.surface,
            ),
          ),
          child: child!,
        );
      },
    );
  }

}


