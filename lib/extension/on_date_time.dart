import 'package:cloud_firestore/cloud_firestore.dart';

extension MyDateTime on DateTime {
  DateTime get withoutTime => DateTime(year, month, day);
  Timestamp get toTimestamp => Timestamp.fromDate(this);
}

extension MyTimestamp on Timestamp {
  Timestamp get withoutTime => Timestamp.fromDate(toDate().withoutTime);
}