import 'package:flutter/material.dart';
import 'package:habits/home_view_new.dart';
import 'package:habits/model/topic_model.dart';
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
          'Habits',
          fontSize: 25,
          bold: true,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        // backgroundColor: ,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddTopic.show(context),
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


          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: TextCustom(
                  topics[index].title,
                  fontSize: 20,
                  bold: true,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                subtitle: TextCustom(
                  topics[index].description ?? '',
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).colorScheme.error,
                  onPressed: () => FB.deleteTopic(topics[index]),
                ),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView(topic: topics[index]))),
              );
            },
          );
        },
      ),

    );
  }
}
