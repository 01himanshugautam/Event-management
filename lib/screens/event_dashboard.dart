import 'package:flutter/material.dart';
import 'package:pn_204_sam/screens/event_ongoing_list.dart';
import 'package:pn_204_sam/utilites/size_configration.dart';
import 'package:pn_204_sam/widgets/event_dashboard_items.dart';
import 'package:pn_204_sam/widgets/nav_bar.dart';

class EventDashboardScreen extends StatefulWidget {
  final String userId;
  final String eventId;

  EventDashboardScreen({
    Key? key,
    required this.userId,
    required this.eventId,
  }) : super(key: key);

  @override
  _EventDashboardScreenState createState() => _EventDashboardScreenState();
}

class _EventDashboardScreenState extends State<EventDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: NavBar(text: "EVENT DASHBOARD"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 2 * SizeConfig.heightMultiplier,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Column(
                children: [
                  EventDashboardItem(
                    text: "Schedule Event",
                    count: 0,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventOngoingList(
                            text: "Schedule Event",
                            number: 1,
                            userId: "${widget.userId}",
                            state: "schedule",
                            eventId: "${widget.eventId}",
                          ),
                        ),
                      );
                    },
                    color: Color(0xFFD10074),
                    color1: Color(0xFF74296B),
                  ),
                  SizedBox(
                    height: 2 * SizeConfig.heightMultiplier,
                  ),
                  EventDashboardItem(
                    text: "Upcoming Events",
                    count: 0,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventOngoingList(
                            text: "Upcoming Events",
                            number: 2,
                            userId: "${widget.userId}",
                            state: "upcoming",
                            eventId: "${widget.eventId}",
                          ),
                        ),
                      );
                    },
                    color: Color(0xFFF3C753),
                    color1: Color(0xFFA09005),
                  ),
                  SizedBox(
                    height: 2 * SizeConfig.heightMultiplier,
                  ),
                  EventDashboardItem(
                    text: "Ongoing Event",
                    count: 1,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventOngoingList(
                            text: "Ongoing Event",
                            number: 3,
                            userId: "${widget.userId}",
                            eventId: "${widget.eventId}",
                            state: "ongoing",
                          ),
                        ),
                      );
                    },
                    color: Color(0xFF7BD860),
                    color1: Color(0xFF1183D8),
                  ),
                  SizedBox(
                    height: 2 * SizeConfig.heightMultiplier,
                  ),
                  EventDashboardItem(
                    text: "Completed Event",
                    count: 0,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventOngoingList(
                            text: "Completed Event",
                            number: 4,
                            userId: "${widget.userId}",
                            state: "completed",
                            eventId: "${widget.eventId}",
                          ),
                        ),
                      );
                    },
                    color: Color(0xFF1960F0),
                    color1: Color(0xFF1183D8),
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
