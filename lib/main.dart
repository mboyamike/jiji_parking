import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiji_parking/screens/billing.dart';
import 'package:jiji_parking/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AppInitialiser());
}

class MyApp extends StatelessWidget {
  final bool errorOccurred;
  MyApp(this.errorOccurred);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => HomePage(),
        "billing": (context) => BillingPage(),
      },
    );
  }
}

class AppInitialiser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done)
          return MyApp(false);
        if(snapshot.hasError)
          return MyApp(true);
        return LoadingPage();
      },
    );
  }
}

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
