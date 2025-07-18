import 'package:flutter/material.dart';
import 'package:habits/dialogs/add_habit.dart';
import 'package:habits/dialogs/profile.dart';
import 'package:habits/extension/on_num.dart';
import 'package:habits/firebase/firebase.dart';
import 'package:habits/history_new.dart';
import 'package:habits/model/habits_model.dart';
import 'package:habits/widgets/custom_text.dart';
import 'package:intl/intl.dart';
import 'model/topic_model.dart';

class HomeView extends StatelessWidget {
  final TopicModel topic;
  const HomeView({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextCustom(
          topic.title,
          fontSize: 25,
          bold: true,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Profile.show(context),
                borderRadius: BorderRadius.circular(20),
                splashColor: Colors.white.withOpacity(0.3),
                highlightColor: Colors.white.withOpacity(0.1),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddHabit.show(context, topic),
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.surface,
                Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              ],
            ),
          ),
          width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.all(16),
          child: StreamBuilder(
            stream: FB.allHabits(topic.id!),
            builder: (context, asyncSnapshot) {
              final list = asyncSnapshot.data ?? [];
              DateTime lastDay = list.lastOrNull?.date.toDate() ?? topic.createdAt;
              final double targetProgress = (topic.currentStreak(lastDay) / topic.target).clamp(0, 1);
              final listSortedStreak = list.where((element) => element.streak > 0).toList()..sort((a, b) => b.streak.compareTo(a.streak));
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Header Goal Card
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.primary.withOpacity(0.7),
                          Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                          spreadRadius: 2,
                        ),
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).colorScheme.secondary.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(28),
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      children: [
                        // Header with icon and title
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimary.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.track_changes,
                                size: 28,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            12.space,
                            TextCustom(
                              "Goal",
                              fontSize: 24,
                              alignment: TextAlign.center,
                              color: Theme.of(context).colorScheme.onPrimary,
                              bold: true,
                            ),
                          ],
                        ),

                        20.space,

                        // Goal Display
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimary.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Large Goal number
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [
                                    Theme.of(context).colorScheme.primary,
                                    Theme.of(context).colorScheme.secondary,
                                  ],
                                ).createShader(bounds),
                                child: Text(
                                  "${ topic.currentStreak(lastDay) }",
                                  style: TextStyle(
                                    fontSize: 56,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              8.space,

                              // Goal description
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TextCustom(
                                  "Days",
                                  fontSize: 14,
                                  color: Theme.of(context).colorScheme.primary,
                                  alignment: TextAlign.center,
                                  bold: true,
                                ),
                              ),
                            ],
                          ),
                        ),

                        16.space,

                        // Progress indicator
                        Container(
                          width: double.infinity,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimary.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: FractionallySizedBox(
                            widthFactor: targetProgress, // 60% progress
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).colorScheme.onPrimary,
                                    Theme.of(
                                      context,
                                    ).colorScheme.onPrimary.withOpacity(0.8),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),

                        16.space,

                        // Progress text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextCustom(
                              "Target",
                              fontSize: 12,
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimary.withOpacity(0.8),
                            ),
                            TextCustom(
                              "${(targetProgress * 100).round()}%",
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onPrimary,
                              bold: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Last Activity Card
                  _buildInfoCard(
                    context,
                    title: 'The Last',
                    icon: Icons.history,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).colorScheme.outline.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildInfoColumn(
                            context,
                            "Day",
                            DateFormat('EEEE').format(lastDay),
                            Icons.calendar_today,
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: Theme.of(
                              context,
                            ).colorScheme.outline.withOpacity(0.3),
                          ),
                          _buildInfoColumn(
                            context,
                            "Date",
                            DateFormat('yyyy/MM/dd').format(lastDay),
                            Icons.date_range,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Total Days Card
                  _buildInfoCard(
                    context,
                    title: 'Total Times in This Period',
                    icon: Icons.today,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).colorScheme.outline.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatsColumn(context, "This Month",
                              list.where((e) => e.isThisMonth).totalTimes.toString(),
                              false),
                          _buildStatsColumn(context, "This Week",
                              list.where((e) => e.isThisWeek).totalTimes.toString(),
                              true),
                          _buildStatsColumn(context, "Last 3 Months",
                              list.where((e) => e.isThis3Months).totalTimes.toString(),
                              false),
                        ],
                      ),
                    ),
                  ),

                  // Longest Streak Card
                  _buildInfoCard(
                    context,
                    title: 'Longest Streak',
                    icon: Icons.trending_up,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).colorScheme.outline.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildRankColumn(context, "2th", "${listSortedStreak.length > 1 ? listSortedStreak[1].streak : 0} Days", "🥈"),
                          _buildRankColumn(context, "1st", "${listSortedStreak.firstOrNull?.streak??0} Days", "🥇"),
                          _buildRankColumn(context, "3th", "${listSortedStreak.length > 2 ? listSortedStreak[2].streak : 0} Days", "🥉"),
                        ],
                      ),
                    ),
                  ),

                  32.space,

                  // Action Button
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.primary.withOpacity(0.8),
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
                    child: TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => History(topicModel: topic,)),
                      ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                        minimumSize: WidgetStateProperty.all(
                          Size(MediaQuery.sizeOf(context).width * 0.9, 56),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.history,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 24,
                          ),
                          12.space,
                          TextCustom(
                            '${topic.title} History',
                            fontSize: 18,
                            bold: true,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );

  }

  // Helper Methods
  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 24,
                color: Theme.of(context).colorScheme.primary,
              ),
              8.space,
              TextCustom(
                title,
                fontSize: 20,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                alignment: TextAlign.center,
                bold: true,
              ),
            ],
          ),
          16.space,
          child,
        ],
      ),
    );
  }

  Widget _buildInfoColumn(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          4.space,
          TextCustom(
            label,
            fontSize: 14,
            alignment: TextAlign.center,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          4.space,
          TextCustom(
            value,
            fontSize: 16,
            alignment: TextAlign.center,
            color: Theme.of(context).colorScheme.onSurface,
            bold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsColumn(
    BuildContext context,
    String period,
    String days,
    bool isHighlighted,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: isHighlighted
            ? BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              )
            : null,
        child: Column(
          children: [
            TextCustom(
              period,
              fontSize: isHighlighted ? 16 : 14,
              alignment: TextAlign.center,
              color: isHighlighted
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              bold: isHighlighted,
            ),
            4.space,
            TextCustom(
              days,
              fontSize: isHighlighted ? 18 : 16,
              alignment: TextAlign.center,
              color: isHighlighted
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface,
              bold: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRankColumn(
    BuildContext context,
    String rank,
    String days,
    String emoji,
  ) {
    bool isFirst = rank == "First";
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: isFirst
            ? BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.amber.withOpacity(0.1),
                    Colors.amber.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.withOpacity(0.3)),
              )
            : null,
        child: Column(
          children: [
            Text(emoji, style: TextStyle(fontSize: isFirst ? 28 : 24)),
            4.space,
            TextCustom(
              rank,
              fontSize: isFirst ? 16 : 14,
              alignment: TextAlign.center,
              color: isFirst
                  ? Colors.amber[700]
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              bold: isFirst,
            ),
            4.space,
            TextCustom(
              days,
              fontSize: isFirst ? 18 : 16,
              alignment: TextAlign.center,
              color: isFirst
                  ? Colors.amber[700]
                  : Theme.of(context).colorScheme.onSurface,
              bold: true,
            ),
          ],
        ),
      ),
    );
  }
}
