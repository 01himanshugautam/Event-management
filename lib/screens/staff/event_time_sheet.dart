import 'package:flutter/material.dart';

class EventTimeShiftScreen extends StatefulWidget {
  EventTimeShiftScreen({Key? key}) : super(key: key);

  @override
  _EventTimeShiftScreenState createState() => _EventTimeShiftScreenState();
}

class _EventTimeShiftScreenState extends State<EventTimeShiftScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            color: Colors.blue[900],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "EVENT TIME SHEET",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 140,
                    decoration: BoxDecoration(
                        color: Colors.yellow[700],
                        borderRadius: BorderRadius.circular(13)),
                    child: Center(
                      child: Text(
                        "TOTAL \nHOURS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 140,
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(13)),
                    child: Center(
                      child: Text(
                        "TOTAL\nHOURS\nWORKED",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 140,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(13)),
                    child: Center(
                      child: Text(
                        "TOTAL\nLATE",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 140,
                    decoration: BoxDecoration(
                        color: Colors.tealAccent[400],
                        borderRadius: BorderRadius.circular(13)),
                    child: Center(
                      child: Text(
                        "TOTAL\nOVERCOME",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Container(
                    height: 230,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.start,
      
                          children: [
                            Text(
                              "Jhon Smith",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            Text(
                              "10447901",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            Text(
                              "Music Night Event",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            Text(
                              "Gio Lattitude",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ],
                        ),
                        Container(
                          height: 228,
                          width: 1,
                          color: Colors.grey,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.start,
      
                          children: [
                            Text(
                              "Gio Longitude",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            Text(
                              "09:00AM 09|10|2020",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            Text(
                              "09:00PM 09|10|2020",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            Text(
                              "12Hour",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                   SizedBox(
              height: 20,
            ),
                  Container(
                    height: 230,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.start,
      
                          children: [
                            Text(
                              "Jhon Smith",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            Text(
                              "10447901",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            Text(
                              "Music Night Event",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            Text(
                              "Gio Lattitude",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ],
                        ),
                        Container(
                          height: 228,
                          width: 1,
                          color: Colors.grey,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.start,
      
                          children: [
                            Text(
                              "Gio Longitude",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            Text(
                              "09:00AM 09|10|2020",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            Text(
                              "09:00PM 09|10|2020",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            Text(
                              "12Hour",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                   SizedBox(
              height: 20,
            ),
                  Container(
                    height: 230,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.start,
      
                          children: [
                            Text(
                              "Jhon Smith",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            Text(
                              "10447901",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            Text(
                              "Music Night Event",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            Text(
                              "Gio Lattitude",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ],
                        ),
                        Container(
                          height: 228,
                          width: 1,
                          color: Colors.grey,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.start,
      
                          children: [
                            Text(
                              "Gio Longitude",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            Text(
                              "09:00AM 09|10|2020",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            Text(
                              "09:00PM 09|10|2020",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            Text(
                              "12Hour",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
