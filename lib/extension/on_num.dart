import 'package:flutter/cupertino.dart';

extension MyNum on num{
  SizedBox get space => SizedBox(height: toDouble(), width: toDouble(),);
}