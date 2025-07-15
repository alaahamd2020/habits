import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habits/model/habits_model.dart';
import 'package:habits/model/topic_model.dart';

class FB {

  static final CollectionReference _users = FirebaseFirestore
      .instance
      .collection('Users');
  static  CollectionReference _topicsReference(String userId) => _users
      .doc(userId)
      .collection('topics');

  static  CollectionReference _habitsDataReference(String userId, String topicId) => _topicsReference(userId)
      .doc(topicId)
      .collection('Habits');

  static Stream<List<HabitsModel>> allHabits(String userId, String topicId) =>
      _habitsDataReference(userId, topicId).snapshots().map((event) {
        return event.docs
            .map((e) => HabitsModel.fromJson(e.data() as Map<String, dynamic>))
            .toList().. sort((a, b) => a.date.compareTo(b.date)); 
      });

  static Future<void> addHabit(HabitsModel model) async {
    final doc = _habitsDataReference(model.userId, model.topicId).doc();
    if(model.id.isEmpty) model.id = doc.id;
    await doc.set(model.toJson());
  }

  static void deleteHabit(HabitsModel model) {
    _habitsDataReference(model.userId, model.topicId).doc(model.id).delete();
  }

  static void addTopic(TopicModel topicModel) {
    final doc = _topicsReference(topicModel.userId).doc(topicModel.id);
    topicModel.id ??= doc.id;
    doc.set(topicModel.toJson());
  }
  static get allTopics {
    return _topicsReference('3XkMSppPiUbDU2fyjme0').snapshots().map((event) {
      return event.docs
          .map((e) => TopicModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    });
  }

  static void deleteTopic(TopicModel topic) {
    _topicsReference(topic.userId).doc(topic.id).delete();
  }

}
