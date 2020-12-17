import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiji_parking/screens/billing.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parking Status"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: StreamBuilder(
          stream: FirebaseDatabase().reference().onValue,
          builder: (context, AsyncSnapshot<Event> snapshot) {
            if (snapshot.hasData && snapshot.data.snapshot.value != null) {
              String parkingslot1 =
                  snapshot.data.snapshot.value["parkingslot1"];
              String parkingslot2 =
                  snapshot.data.snapshot.value["parkingslot2"];

              return Row(
                children: [
                  ParkingSlot(
                    title: "parkingslot1",
                    available: parkingslot1 == "available",
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  ParkingSlot(
                    title: "parkingslot2",
                    available: parkingslot2 == "available",
                  ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class ParkingSlot extends StatelessWidget {
  final String title;
  final bool available;

  ParkingSlot({@required this.title, this.available = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            color: available ? Colors.green : Colors.red[900],
            height: 120,
            width: 97,
            child: Center(
              child: Text(
                "$title",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          RaisedButton(
            color: available ? Colors.green : Colors.red[900],
            disabledColor: Colors.red[100],
            onPressed: available ? book : null,
            child: Text(
              "Book Now",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void book() async {
    DatabaseReference ref = FirebaseDatabase().reference().child(title);
    await ref.set("booked").then(
          (value) => Get.snackbar(
            "successfully booked",
            "$title is waiting for you",
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 1),
          ),
        );

    Get.put(ParkingSlot(title: title, available: false,));
    Get.offAll(BillingPage());
  }
}
