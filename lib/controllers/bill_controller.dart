import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BillController extends GetxController {
  DateTime time;
  double _charges = 0;
  
  BillController({this.time}) {
    time ??= DateTime.now();
  }

  int charges(DateTime currentTime) {
    return (currentTime.difference(time).inHours + 1) * 50;
  }
}