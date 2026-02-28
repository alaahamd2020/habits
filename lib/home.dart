import 'package:flutter/material.dart';
import 'package:habits/dialogs/delete_topic.dart';
import 'package:habits/dialogs/profile.dart';
import 'package:habits/home_view_new.dart';
import 'package:habits/model/topic_model.dart';
import 'package:habits/generated/l10n.dart';
import 'dialogs/add_topic.dart';
import 'firebase/firebase.dart';
import 'widgets/custom_text.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextCustom(
          S.of(context).topics,
          fontSize: 25,
          bold: true,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 16.0, start: 8.0),
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
        onPressed: () => AddTopic.show(context, null),
        child: Icon(Icons.add),
      ),

      body: StreamBuilder<List<TopicModel>>(
        stream: FB.allTopics,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final topics = snapshot.data ?? [];

          if (topics.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.assignment_add,
                      size: 100,
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.3),
                    ),
                    const SizedBox(height: 24),
                    TextCustom(
                      S.of(context).no_habits_yet,
                      fontSize: 18,
                      alignment: TextAlign.center,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      bold: true,
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: topics.length,
            itemBuilder: (context, index) {
              final topic = topics[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: TextCustom(
                    topic.title,
                    fontSize: 20,
                    bold: true,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (topic.description != null &&
                          topic.description!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: TextCustom(
                            topic.description!,
                            fontSize: 14,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      if (topic.target != 0)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              Icon(
                                Icons.flag,
                                size: 16,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 4),
                              TextCustom(
                                '${S.of(context).target}: ${topic.target}',
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () => AddTopic.show(context, topic),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Theme.of(context).colorScheme.error,
                        onPressed: () => DeleteTopic.show(context, topic),
                      ),
                    ],
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeView(topic: topic),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
