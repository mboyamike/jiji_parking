import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiji_parking/controllers/bill_controller.dart';
import 'package:get/get.dart';
import 'package:jiji_parking/screens/home.dart';

class BillingPage extends StatefulWidget {
  @override
  _BillingPageState createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  Timer myTimer;
  BillController billController = BillController();
  Duration dateDifference;
  DateTime stopTime;
  bool isTimerRunning = true;

  _BillingPageState() {
    dateDifference = billController.time.difference(DateTime.now());
    myTimer = Timer.periodic(Duration(seconds: 1), (myTimer) {
      setState(() {
        dateDifference = DateTime.now().difference(billController.time);
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Billing Page"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Time: ",
                  style: TextStyle(fontSize: 28),
                ),
                Text(
                  displayRemainingTime(dateDifference),
                  style: TextStyle(fontSize: 28),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 3 - 50,),
            Row(
              children: [
                Text(
                  "Charges: Ksh ",
                  style: TextStyle(fontSize: 28),
                ),
                Text(
                  billController.charges(isTimerRunning ? DateTime.now() : stopTime).toString(),
                  style: TextStyle(fontSize: 28),
                ),
              ],
            ),
            SizedBox(height: 32,),
            RaisedButton(
              color: Colors.red,
              onPressed: () {
                if(isTimerRunning) {
                  isTimerRunning = false;
                  stopTime = DateTime.now();
                  myTimer.cancel();
                }
              },
              child: Text(
                "End Session",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 32,),
            RaisedButton(
              color: Colors.green,
              onPressed: isTimerRunning ? null : () {
                Get.offAll(HomePage());
              },
              child: Text(
                "Home Page",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  String displayRemainingTime(Duration d) {
    String hours = d.inHours.toString().padLeft(2);
    String minutes = d.inMinutes.remainder(60).toString().padLeft(2);
    String seconds = d.inSeconds.remainder(60).toString().padLeft(2);
    
    return "$hours:$minutes:$seconds";
  }
}
