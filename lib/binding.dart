import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:habits/fire_store_habits.dart';

class Binding extends Bindings{
  @override
  void dependencies(){
    Get.put(FireStoreHabits(), permanent: true);
  }
}