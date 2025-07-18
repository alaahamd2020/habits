import 'package:flutter/material.dart';
import 'package:habits/dialogs/delete_habit.dart';
import 'package:habits/extension/on_num.dart';
import 'package:habits/firebase/firebase.dart';
import 'package:habits/model/habits_model.dart';
import 'package:habits/widgets/custom_text.dart';
import 'package:intl/intl.dart';
import 'model/topic_model.dart';

class History extends StatelessWidget {
  final TopicModel topicModel;
  const History({super.key, required this.topicModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FB.allHabits(topicModel.id!),
        builder: (context,snapshot) {
          final list = snapshot.data ?? [];
          return
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  Theme.of(context).colorScheme.surface,
                ],
              ),
            ),
            child: CustomScrollView(
              slivers: [
                // Custom App Bar
                SliverAppBar(
                  expandedHeight: 120,
                  floating: true,
                  snap: true,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: [
                      StretchMode.fadeTitle
                    ],
                    background: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32),bottomRight: Radius.circular(32)),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(top: 64,start:16),
                        child: Row(
                          children: [
                            40.space,
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.history_rounded,
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextCustom(
                                  '${topicModel.title} History',
                                  fontSize: 24,
                                  bold: true,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                                const SizedBox(height: 4),
                                TextCustom(
                                  'Track your journey',
                                  fontSize: 14,
                                  color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  leading: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),

                // Content
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Stats Summary Card
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildStatItem(
                                context,
                                icon: Icons.calendar_today,
                                title: 'Total Days',
                                value: "${list.totalDays(topicModel.createdAt)}",
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              _buildVerticalDivider(context),
                              _buildStatItem(
                                context,
                                icon: Icons.repeat,
                                title: 'Total Times',
                                value: "${list.totalTimes}",
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              _buildVerticalDivider(context),
                              _buildStatItem(
                                context,
                                icon: Icons.trending_up,
                                title: 'Streak',
                                value: list.totalStreak(topicModel.createdAt).toString(),
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ),

                        // History List
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // List Header
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.list_alt_rounded,
                                      color: Theme.of(context).colorScheme.primary,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    TextCustom(
                                      'History Records',
                                      fontSize: 16,
                                      bold: true,
                                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                                    ),
                                  ],
                                ),
                              ),

                              // History Items
                              snapshot.connectionState == ConnectionState.waiting && list.isNotEmpty ? Center(child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator()),
                              ),) :
                              ListView.separated(
                                shrinkWrap: true,
                                reverse: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: list.length, // Sample data
                                separatorBuilder: (context, index) => Divider(
                                  height: 1,
                                  color: Theme.of(context).colorScheme.outline.withAlpha(80),
                                ),
                                itemBuilder: (context, index) => _buildHistoryItem(
                                  context,list[index],
                                  list.length - index
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, {
    required IconData icon,
    required String title,
    required  value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        TextCustom(
          value.toString(),
          fontSize: 20,
          bold: true,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        const SizedBox(height: 4),
        TextCustom(
          title,
          fontSize: 12,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ],
    );
  }

  Widget _buildVerticalDivider(BuildContext context) {
    return Container(
      width: 1,
      height: 40,
      color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
    );
  }

  Widget _buildHistoryItem(BuildContext context, HabitsModel item,int index) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // ID Badge
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: TextCustom(
                "$index",
                fontSize: 14,
                bold: true,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    TextCustom(
                      DateFormat('MM/dd - EEE').format(item.date.toDate()),
                      fontSize: 16,
                      bold: true,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    const Spacer(),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: EdgeInsets.only(right: 13),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.repeat,
                            size: 14,
                            color: Theme.of(context).colorScheme.onSecondaryContainer,
                          ),
                          const SizedBox(width: 4),
                          TextCustom(
                            "${item.times}",
                            fontSize: 14,
                            bold: true,
                            color: Theme.of(context).colorScheme.onSecondaryContainer,
                          ),
                        ],
                      ),
                    ),
                    // const Spacer(),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: EdgeInsets.only(right: 13),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.trending_up,
                            size: 14,
                            color: Theme.of(context).colorScheme.onSecondaryContainer,
                          ),
                          const SizedBox(width: 4),
                          TextCustom(
                            "${item.streak}",
                            fontSize: 14,
                            bold: true,
                            color: Theme.of(context).colorScheme.onSecondaryContainer,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    TextCustom(
                      'Created: ${DateFormat('yyyy/MM/dd HH:mm').format(item.createdAt)}',
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),

                  ],
                ),
              ],
            ),
          ),

          // Delete Button
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: Icon(
                Icons.delete_outline_rounded,
                color: Theme.of(context).colorScheme.onErrorContainer,
                size: 20,
              ),
              onPressed: () {
                DeleteHabit.show(context, item);
              },
            ),
          ),
        ],
      ),
    );
  }
}