import 'package:flutter/material.dart';
import 'package:pn_204_sam/utilites/styles.dart';
import 'package:pn_204_sam/widgets/nav_bar.dart';

class ActivitiesScreen extends StatefulWidget {
  ActivitiesScreen({Key? key}) : super(key: key);

  @override
  _ActivitiesScreenState createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: NavBar(text: "ACTIVITIES"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(9),
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHByb2ZpbGV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
                            radius: 30),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Anna Furrow",
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Activity Type",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  color: Colors.grey,
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 3),
                                  child: Text("Emergency",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Container(
                                  color: Colors.grey,
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 3),
                                  child: Text("Alert",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Container(
                                  color: Colors.grey,
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 3),
                                  child: Text("Critical",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Container(
                                  color: Colors.grey,
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 3),
                                  child: Text("Error",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Container(
                                  color: Colors.grey,
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 3),
                                  child: Text("Warning",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Container(
                                  color: Colors.grey,
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 3),
                                  child: Text("Notice",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Container(
                                  color: Colors.grey,
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 3),
                                  child: Text("Info",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Container(
                                  color: Colors.grey,
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 3),
                                  child: Text("Debug",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Date & Time ",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          children: [
                            Text(
                              "9|10|2020 10:29:20Am",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Message & Activity",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue[900])),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventoreveritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(9),
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHByb2ZpbGV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
                            radius: 30),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Anna Furrow",
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Activity Type",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  color: Colors.grey,
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 3),
                                  child: Text("Emergency",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Container(
                                  color: Colors.grey,
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 3),
                                  child: Text("Alert",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Container(
                                  color: Colors.grey,
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 3),
                                  child: Text("Critical",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Container(
                                  color: Colors.grey,
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 3),
                                  child: Text("Error",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Container(
                                  color: Colors.grey,
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 3),
                                  child: Text("Warning",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Container(
                                  color: Colors.grey,
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 3),
                                  child: Text("Notice",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Container(
                                  color: Colors.grey,
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 3),
                                  child: Text("Info",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Container(
                                  color: Colors.grey,
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 3),
                                  child: Text("Debug",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Date & Time ",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          children: [
                            Text(
                              "9|10|2020 10:29:20Am",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Message & Activity",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue[900])),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventoreveritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
