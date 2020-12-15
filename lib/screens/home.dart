import 'package:flutter/material.dart';

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
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            return Container(
              child: Column(
                children: [
                  Container(
                    color: index % 2 == 0 ? Colors.red[900] : Colors.green,
                    height: 120,
                    child: Center(
                      child: Text(
                        "$index",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  RaisedButton(
                    color: index % 2 == 0 ? Colors.red[900] : Colors.green,
                    onPressed: () {},
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
          },
        ),
      ),
    );
  }
}
