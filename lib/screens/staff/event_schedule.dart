import 'package:flutter/material.dart';
import 'package:pn_204_sam/Auth/auth.dart';
import 'package:pn_204_sam/Auth/events.dart';
import 'package:pn_204_sam/screens/activities.dart';
import 'package:pn_204_sam/screens/event_chatlist.dart';
import 'package:pn_204_sam/screens/event_incident.dart';
import 'package:pn_204_sam/screens/event_time_sheet.dart';
import 'package:pn_204_sam/screens/feedback.dart';
import 'package:pn_204_sam/screens/client/team_detail.dart';
import 'package:pn_204_sam/screens/staff/notifications.dart';
import 'package:pn_204_sam/screens/staff/special_instruction_list.dart';
import 'package:pn_204_sam/utilites/size_configration.dart';
import 'package:pn_204_sam/utilites/styles.dart';
import 'package:pn_204_sam/widgets/analitics_container.dart';
import 'package:pn_204_sam/widgets/nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class EventScheduleStaffScreen extends StatefulWidget {
  String? eventId;
  String? userId;
  final String state;
  String startday;
  String endday;
  EventScheduleStaffScreen({
    Key? key,
    this.eventId,
    this.userId,
    required this.state,
    required this.endday,
    required this.startday,
  }) : super(key: key);

  @override
  _EventScheduleStaffScreenState createState() =>
      _EventScheduleStaffScreenState();
}

class _EventScheduleStaffScreenState extends State<EventScheduleStaffScreen> {
  DateTime _selectedDay = DateTime(2021, 9, 5),
      _focusedDay = DateTime(2021, 9, 15);
  bool timesheet = true;
  var data;
  getgAnalyticData() async {
    // String a=
    // int? a, b, c, d, e, f;
    // a = int.parse("${widget.endday}".split("-")[0]);
    // b = int.parse("${widget.endday}".split("-")[1]);
    // print("Date $a $b $c  $d $e $f");
    // print("Date ${widget.endday}   ${widget.startday}");

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId");
    print(userId);
    Event().getEventLIstbyUser("$userId").then((userEventdata) {
      print(userEventdata);
      var eventId = userEventdata[0]['event_id'];
      Auth().getEvetnScheduleAnalyticStaff("$userId", "$eventId").then((value) {
        setState(() {
          data = value['data'];
        });
        print("Value ${value['data']}");
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getgAnalyticData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: NavBar(text: "EVENT SCHEDULE"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  data != null
                      ? AnalyticContainer(
                          text: "Event Incidents",
                          today: data['today_incident_reports'] ?? 0,
                          total: data['previous_incident_reports'] ?? 0,
                          color: AppColors.appColor,
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                              left: 25, top: 15, bottom: 15, right: 20),
                          child: CircularProgressIndicator(),
                        ),
                  data != null
                      ? AnalyticContainer(
                          text: "Activities",
                          today: data['today_activities'] ?? 0,
                          total: data['previous_activities'] ?? 0,
                          color: Colors.blue,
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                              left: 25, top: 15, bottom: 15, right: 20),
                          child: CircularProgressIndicator(),
                        ),
                  data != null
                      ? AnalyticContainer(
                          text: "Instructions",
                          today: data['today_instructions'] ?? 0,
                          total: data['previous_instructions'] ?? 0,
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                              left: 25, top: 15, bottom: 15, right: 20),
                          child: CircularProgressIndicator(),
                        ),
                ],
              ),
            ),
            SizedBox(height: 30),
            TableCalendar(
              rowHeight: 30,
              currentDay: _focusedDay,
              focusedDay: _focusedDay,
              firstDay: DateTime(2021, 9, 1),
              lastDay: DateTime(2021, 9, 30),
              calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: AppColors.alert,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: AppColors.success,
                  )),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              // onDaySelected: (selectedDay, focusedDay) {
              //   setState(() {
              //     _selectedDay = selectedDay;
              //     _focusedDay = focusedDay; // update `_focusedDay` here as well
              //   });
              // },
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonShowsNext: false,
              ),
            ),
            SizedBox(height: 5 * SizeConfig.heightMultiplier),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          timesheet = false;
                        });
                        Event()
                            .getEventLIstbyUser("${widget.userId}")
                            .then((userEventdata) {
                          var eventId = userEventdata[0]['event_id'];
                          print(eventId);
                          print(
                              "userEventdata ${userEventdata[0]['event_id']}");
                          Event()
                              .getTeamDetail("$eventId", "${widget.userId}")
                              .then((useTeamDetails) {
                            print("useTeamDetails ${useTeamDetails[0]}");
                            var teamId = useTeamDetails[0]['team_id'];
                            var teamHours = useTeamDetails[0]['total_hours'];
                            var teamend = useTeamDetails[0]['end_time'];
                            var teamstart = useTeamDetails[0]['start_time'];
                            setState(() {
                              timesheet = true;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EventTimeSheet(
                                  eventId: "$eventId",
                                  userId: "${widget.userId}",
                                  limit: "10",
                                  teamId: "$teamId",
                                  offset: "",
                                  teamEnd: "$teamend",
                                  teamHours: "$teamHours",
                                  teamStart: "$teamstart",
                                ),
                              ),
                            );
                          });
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: timesheet == true
                            ? Icon(Icons.event, size: 35, color: Colors.white)
                            : CircularProgressIndicator(),
                      ),
                    ),
                    Text("Timesheet")
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
                        child: Icon(Icons.group, size: 35, color: Colors.white),
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
                            size: 35, color: Colors.white),
                      ),
                    ),
                    Text("Activity")
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Event().getEventId("${widget.userId}").then((value) {
                          var id = value['event_id'];
                          print(id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventChatLists(
                                eventId: "$id",
                                userId: "${widget.userId}",
                              ),
                            ),
                          );
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(Icons.chat, size: 35, color: Colors.white),
                      ),
                    ),
                    Text("Live Chat")
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
                // Column(
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => EventLocationDetail()));
                //       },
                //       child: Container(
                //         padding: EdgeInsets.all(10),
                //         decoration: BoxDecoration(
                //           color: Colors.blueGrey[300],
                //           borderRadius: BorderRadius.circular(50),
                //         ),
                //         child: Icon(Icons.location_searching_sharp,
                //             size: 50, color: Colors.white),
                //       ),
                //     ),
                //     Text("Live Tracking")
                //   ],
                // ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EventIncidentScreen()));
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[900],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(Icons.error, size: 35, color: Colors.white),
                      ),
                      Text("Task/Incident")
                    ],
                  ),
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationScreen()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(Icons.notification_important,
                            size: 35, color: Colors.white),
                      ),
                    ),
                    Text("Notifications")
                  ],
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
                            size: 35, color: Colors.white),
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
