import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:pn_204_sam/Auth/events.dart';
import 'package:pn_204_sam/Auth/incident.dart';
import 'package:pn_204_sam/screens/add_incident_report.dart';
import 'package:pn_204_sam/screens/event_document_screen.dart';
import 'package:pn_204_sam/utilites/images.dart';
import 'package:pn_204_sam/utilites/size_configration.dart';
import 'package:pn_204_sam/utilites/styles.dart';
import 'package:pn_204_sam/widgets/analitics_container.dart';
import 'package:pn_204_sam/widgets/event_analitics_container.dart';
import 'package:pn_204_sam/widgets/row_imgae_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventIncidentScreen extends StatefulWidget {
  EventIncidentScreen({
    Key? key,
  }) : super(key: key);

  @override
  _EventIncidentScreenState createState() => _EventIncidentScreenState();
}

class _EventIncidentScreenState extends State<EventIncidentScreen> {
  String? eventId, userId;
  int? today_incident_reports,
      previous_incident_reports,
      today_pending_incident_reports,
      previous_pending_incident_reports,
      today_resolved_incident_reports,
      previous_resolved_incident_reports;
  // var data;
  int? supervisorId, mangerId;
  LocationData? _currentPosition;
  _getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await Location.instance.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await Location.instance.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await Location.instance.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await Location.instance.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await Location.instance.getLocation();
    // print(_currentPosition!.latitude);
    // print(_currentPosition!.longitude);
  }

  _getUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString("userId");
    });
    Event().getEventLIstbyUser("$userId").then((userEventdata) {
      eventId = "${userEventdata[0]['event_id']}";
      print("Event id $eventId $userId");
      Incident().getEventIncident("$eventId").then((data) {
        print("data $data");
        setState(() {
          today_incident_reports = data['today_incident_reports'];
          previous_incident_reports = data['previous_incident_reports'];
          today_pending_incident_reports =
              data['today_pending_incident_reports'];
          previous_pending_incident_reports =
              data['previous_pending_incident_reports'];
          today_resolved_incident_reports =
              data['today_resolved_incident_reports'];
          previous_resolved_incident_reports =
              data['previous_resolved_incident_reports'];
        });
        Event().getTeamDetail("$eventId", "$userId").then((data) {
          // print("Data ${data[0]}");
          mangerId = data[0]['manager_ids'][0]['id'];
          supervisorId = data[0]['supervisor_ids'][0]['id'];
          // print("$supervisorId $mangerId");
        });
      });
    });
  }

// manager_ids
// supervisor_ids
  @override
  void initState() {
    super.initState();
    _getUserDetails();
    _getLoc();
  }

  @override
  Widget build(BuildContext context) {
    var device = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              child: Image.asset(
                Images.background,
                fit: BoxFit.fill,
                width: device.width,
              ),
            ),
            Container(
              height: 15 * SizeConfig.heightMultiplier,
              decoration: BoxDecoration(
                // color: AppColors.appColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 15.0, left: 15),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4 * SizeConfig.heightMultiplier,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, left: 15),
                      child: Text(
                        "EVENT TASK/INCIDENTS",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 2 * SizeConfig.heightMultiplier,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: previous_incident_reports == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),

                  // Row(
                  //   children: [
                  //     GestureDetector(
                  //       onTap: () {
                  //         print(
                  //             "Data Fetch $userId $eventId $mangerId $supervisorId");
                  //         // print(
                  //         //     "Location ${_currentPosition!.latitude} ${_currentPosition!.longitude}");
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => AddIncidentReport(
                  //               eventId: "$eventId",
                  //               reportedBy: "$userId",
                  //               incGeoLocation: [
                  //                 _currentPosition!.latitude,
                  //                 _currentPosition!.longitude
                  //               ],
                  //               incGuardMa: '$mangerId',
                  //               incGuardSup: '$supervisorId',
                  //             ),
                  //           ),
                  //         );
                  //       },
                  //       child: Padding(
                  //         padding: EdgeInsets.only(top: 15),
                  //         child: Container(
                  //           height: 4 * SizeConfig.heightMultiplier,
                  //           width: 4 * SizeConfig.heightMultiplier,
                  //           decoration: BoxDecoration(
                  //               color: AppColors.appColor,
                  //               borderRadius: BorderRadius.circular(25)),
                  //           child: Icon(
                  //             Icons.add,
                  //             color: Colors.blue,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 15,
                  //     ),
                  //     GestureDetector(
                  //         onTap: () {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //               builder: (context) => EVENTDOCUMENTLIST(
                  //                 eventId: "$eventId",
                  //               ),
                  //             ),
                  //           );
                  //         },
                  //         child: Padding(
                  //           padding: EdgeInsets.only(top: 15),
                  //           child: Image.asset(
                  //             Images.notes,
                  //             height: 25,
                  //             // width: 20,
                  //             color: Colors.white,
                  //           ),
                  //         )),
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            child: Row(
                              children: [
                                EventContainer(
                                  text: "Total Incident",
                                  today: today_pending_incident_reports!,
                                  total: previous_incident_reports!,
                                  color: AppColors.alert,
                                ),
                                EventContainer(
                                  text: "Pending Incident",
                                  today: today_pending_incident_reports!,
                                  total: previous_pending_incident_reports!,
                                  color: AppColors.pending,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 100,
                            child: Row(
                              children: [
                                EventContainer(
                                  text: "Resolved Incidents",
                                  today: today_resolved_incident_reports!,
                                  total: previous_pending_incident_reports!,
                                  color: AppColors.success,
                                ),
                                EventContainer(
                                  text: "Event Incidents",
                                  today: 0,
                                  total: 0,
                                  color: AppColors.appColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20 * SizeConfig.heightMultiplier,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RowImageText(
                          onPressed: () {
                            print(
                                "Data Fetch $userId $eventId $mangerId $supervisorId");
                            // print(
                            //     "Location ${_currentPosition!.latitude} ${_currentPosition!.longitude}");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddIncidentReport(
                                  eventId: "$eventId",
                                  reportedBy: "$userId",
                                  incGeoLocation: [
                                    _currentPosition!.latitude,
                                    _currentPosition!.longitude
                                  ],
                                  incGuardMa: '$mangerId',
                                  incGuardSup: '$supervisorId',
                                ),
                              ),
                            );
                          },
                          text: 'ADD',
                          img: true,
                          loading: false,
                          image: Images.notes,
                        ),
                        RowImageText(
                          text: 'VIEW',
                          img: true,
                          loading: false,
                          image: Images.notes,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EVENTDOCUMENTLIST(
                                  eventId: "$eventId",
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  // Image.asset(
                  //   "assets/images/eventImg.png",
                  //   height: 18 * SizeConfig.heightMultiplier,
                  //   // width: 25 * SizeConfig.heightMultiplier,
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Container(
                  //       height: 20,
                  //       width: 20,
                  //       decoration: BoxDecoration(
                  //           color: Colors.blue[900],
                  //           borderRadius: BorderRadius.circular(10)),
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Text(
                  //       "Previous Incident Reports",
                  //       style: TextStyle(
                  //           color: Colors.blue[900],
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w700),
                  //     )
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Container(
                  //       height: 20,
                  //       width: 20,
                  //       decoration: BoxDecoration(
                  //           color: Colors.pink,
                  //           borderRadius: BorderRadius.circular(10)),
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Text(
                  //       "Today Pending Incident Reports",
                  //       style: TextStyle(
                  //           color: Colors.pink,
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w700),
                  //     )
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Container(
                  //       height: 20,
                  //       width: 20,
                  //       decoration: BoxDecoration(
                  //           color: Colors.blue,
                  //           borderRadius: BorderRadius.circular(10)),
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Text(
                  //       "Previous Pending Incident Reports",
                  //       style: TextStyle(
                  //           color: Colors.blue,
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w700),
                  //     )
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Container(
                  //       height: 20,
                  //       width: 20,
                  //       decoration: BoxDecoration(
                  //           color: Colors.purple,
                  //           borderRadius: BorderRadius.circular(10)),
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Text(
                  //       "Today Resolved Incident Reports",
                  //       style: TextStyle(
                  //           color: Colors.purple,
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w700),
                  //     )
                  //   ],
                  // ),
                ],
              ),
            ),
    );
  }
}
