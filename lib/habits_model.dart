import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HabitsModel{
  String? id, times, streak;
  DateTime? date, created_at;

  HabitsModel(this.id, this.times, this.streak, this.date, this.created_at);

  HabitsModel.fromJson(Map<dynamic, dynamic> map){
    if(map == null) return;
    id=map['id'];
    times = map['times'];
    streak = map['streak'];
    date = (map['date'] as Timestamp).toDate();
    created_at = (map['created_at'] as Timestamp).toDate();
  }
  toJson(){
    return {
      'id':id,
      'times':times,
      'streak': streak,
      'date':date,
      'created_at':created_at,
    };
  }
}