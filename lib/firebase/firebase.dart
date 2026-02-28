import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:habits/firebase/auth.dart';
import 'package:habits/model/habits_model.dart';
import 'package:habits/model/topic_model.dart';

class FB {
  static final CollectionReference _users = FirebaseFirestore.instance
      .collection('Users');
  static CollectionReference _topicsReference() =>
      _users.doc(FBAuth.user!.id!).collection('topics');

  static CollectionReference _habitsDataReference(String topicId) =>
      _topicsReference().doc(topicId).collection('Habits');

  static Stream<List<HabitsModel>> allHabits(String topicId) =>
      _habitsDataReference(topicId).snapshots().map((event) {
        return event.docs
            .map((e) => HabitsModel.fromJson(e.data() as Map<String, dynamic>))
            .toList()
          ..sort((a, b) => a.date.compareTo(b.date));
      });

  static Future<void> addHabit(HabitsModel model) async {
    final list = await allHabits(model.topicId).first;
    final index = list.indexOf(model);
    final oldItem = index != -1 ? list[index] : null;
    model.times += oldItem?.times ?? 0;
    model.streak += oldItem?.streak ?? 0;

    final doc = _habitsDataReference(model.topicId).doc(oldItem?.id);
    if (model.id.isEmpty) model.id = doc.id;
    await doc.set(model.toJson());
  }

  static void deleteHabit(HabitsModel model) {
    _habitsDataReference(model.topicId).doc(model.id).delete();
  }

  static void addTopic(TopicModel topicModel) {
    final doc = _topicsReference().doc(topicModel.id);
    topicModel.id ??= doc.id;
    doc.set(topicModel.toJson());
  }

  static get allTopics {
    return _topicsReference().snapshots().map((event) {
      return event.docs
          .map((e) => TopicModel.fromJson(e.data() as Map<String, dynamic>))
          .toList()
        ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    });
  }

  static void deleteTopic(TopicModel topic) {
    _topicsReference().doc(topic.id).delete();
  }
}
