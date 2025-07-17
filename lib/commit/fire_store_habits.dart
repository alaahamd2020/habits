/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:habits/model/habits_model.dart';

class FireStoreHabits extends GetxController{
  final CollectionReference _habitsCollectionReference = FirebaseFirestore.instance.collection('Habits');
  RxBool loading = true.obs;

  FireStoreHabits(){
    getAllHabits();
  }

  RxList<HabitsModel> habits = <HabitsModel>[].obs;
  RxList<HabitsModel> thisWeek = <HabitsModel>[].obs;
  RxList<HabitsModel> thisDay = <HabitsModel>[].obs;
  RxList<HabitsModel> thisMonth = <HabitsModel>[].obs;

  Future<List<QueryDocumentSnapshot>> getHabits() async{
    return (await _habitsCollectionReference.get()).docs;
  }
  getAllHabits(){
    _habitsCollectionReference.snapshots().listen((snapshot){
      habits.clear();
      for(var item in snapshot.docs){
        habits.add(HabitsModel.fromJson(item.data() as Map<String, dynamic>));
      }
      loading.value = false;
      habitsThisWeek();
      habitsThisDay();
      habitsThisMonth();
    });
  }

  addHabit(HabitsModel model)async{
    await _habitsCollectionReference.doc(model.id).set(model.toJson());
    await getAllHabits();
  }
  delete(String id) async{
    try {
      await _habitsCollectionReference.doc(id).delete();
      await getAllHabits();
      print('Delete habit id: $id');
      // habits.removeWhere((item)=> item.id ==id);
    } catch(e){
      print('Error: $e');
    }
  }

  */
/*getThisWeek(){
    _habitsCollectionReference.snapshots().listen((snapshot){
      thisWeek.clear();
      for (var item in snapshot.docs){
        thisWeek.add(HabitsModel.fromJson(item.data() as Map));
      }
    });
  }*//*


  habitsThisWeek(){
    thisWeek.clear();
    for(var item in habits){
      if(DateTime.now().difference(item.date.toDate()).inDays <=7)
        thisWeek.add(item);
    }
  }

  habitsThisDay(){
    thisDay.clear();
    for(var item in habits){
      if(DateTime.now().difference(item.date.toDate()).inDays ==0) {
        thisDay.add(item);
      }
    }
  }

  habitsThisMonth(){
      thisMonth.clear();
      for(var item in habits){
        if(DateTime.now().difference(item.date.toDate()).inDays <= 30) {
          thisMonth.add(item);
        }
      }
  }

  // String streak1St(){
  //   return habits
  // }

}*/
