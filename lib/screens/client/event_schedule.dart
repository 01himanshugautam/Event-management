import 'package:flutter/material.dart';
import 'package:pn_204_sam/screens/activities.dart';
import 'package:pn_204_sam/screens/event_location_detail.dart';
import 'package:pn_204_sam/screens/feedback.dart';
import 'package:pn_204_sam/screens/client/team_detail.dart';
import 'package:pn_204_sam/screens/incident_list.dart';
import 'package:pn_204_sam/screens/staff/event_doc_list.dart';
import 'package:pn_204_sam/screens/staff/event_time_sheet.dart';
import 'package:pn_204_sam/screens/staff/special_instruction_list.dart';
import 'package:table_calendar/table_calendar.dart';

class EventScheduleScreen extends StatefulWidget {
  const EventScheduleScreen({Key? key}) : super(key: key);

  @override
  _EventScheduleScreenState createState() => _EventScheduleScreenState();
}

class _EventScheduleScreenState extends State<EventScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Container(
          color: Colors.blue[900],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    "EVENT SCHEDULE",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EventDocListScreen()));
                      },
                      child: Icon(
                        Icons.manage_accounts,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
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
              height: 20,
            ),
            Container(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SpecialInstructionListScreen()));
                    },
                    child: Container(
                      width: 160,
                      decoration: BoxDecoration(
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(13)),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "TOTAL ACTIVITY",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "TODAY",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                ),
                                Text(
                                  " | ",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                ),
                                Text(
                                  "PREVIOUS",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 160,
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(13)),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "YOUR SOS TRIGGED",
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "TODAY",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                              Text(
                                " | ",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                              Text(
                                "PREVIOUS",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 160,
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(13)),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "TOTAL INCIDENT REPORT",
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "TODAY",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                              Text(
                                " | ",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                              Text(
                                "PREVIOUS",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 160,
                    decoration: BoxDecoration(
                        color: Colors.tealAccent[400],
                        borderRadius: BorderRadius.circular(13)),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "TOTAL ACTIVITY",
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "TODAY",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                              Text(
                                " | ",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                              Text(
                                "PREVIOUS",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 160,
                    decoration: BoxDecoration(
                        color: Colors.yellow[700],
                        borderRadius: BorderRadius.circular(13)),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "TOTAL ACTIVITY",
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "TODAY",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                              Text(
                                " | ",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                              Text(
                                "PREVIOUS",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue[900]),
              ),
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonShowsNext: false,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EventTimeShiftScreen()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(Icons.event, size: 70, color: Colors.white),
                      ),
                    ),
                    Text("Event Detail")
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TeamDetailScreen()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(Icons.group, size: 70, color: Colors.white),
                      ),
                    ),
                    Text("Teams")
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ActivitiesScreen()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(Icons.local_activity,
                            size: 70, color: Colors.white),
                      ),
                    ),
                    Text("Activity")
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EventLocationDetail()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[300],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(Icons.location_searching_sharp,
                            size: 70, color: Colors.white),
                      ),
                    ),
                    Text("Live Tracking")
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => IncidentList()));
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[900],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(Icons.error, size: 70, color: Colors.white),
                      ),
                      Text("Total Incident")
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FeedBack()));
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(13),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[300],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(Icons.messenger_outline,
                            size: 70, color: Colors.white),
                      ),
                      Text("Feedback")
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
