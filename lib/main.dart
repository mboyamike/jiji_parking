import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiji_parking/screens/billing.dart';
import 'package:jiji_parking/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: BillingPage(),
    );
  }
}

