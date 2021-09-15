import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pn_204_sam/Auth/auth.dart';
import 'package:pn_204_sam/Auth/chat.dart';
import 'package:pn_204_sam/Auth/events.dart';
import 'package:pn_204_sam/Auth/shifts.dart';
import 'package:pn_204_sam/main.dart';
import 'package:pn_204_sam/models/UserPreferences.dart';
import 'package:pn_204_sam/models/common_functions.dart';
import 'package:pn_204_sam/screens/chat.dart';
import 'package:pn_204_sam/screens/chat_lists.dart';
import 'package:pn_204_sam/screens/event_dashboard.dart';
import 'package:pn_204_sam/screens/event_incident.dart';
import 'package:pn_204_sam/screens/exit_app.dart';
import 'package:pn_204_sam/screens/incident_list.dart';
import 'package:pn_204_sam/screens/staff/event_schedule.dart';
import 'package:pn_204_sam/screens/staff/start_shift.dart';
import 'package:pn_204_sam/screens/staff/timesheet.dart';
import 'package:pn_204_sam/utilites/images.dart';
import 'package:pn_204_sam/utilites/size_configration.dart';
import 'package:pn_204_sam/utilites/styles.dart';
import 'package:pn_204_sam/widgets/analitics_container.dart';
import 'package:pn_204_sam/widgets/custom_buttom.dart';
import 'package:pn_204_sam/widgets/row_imgae_text.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class StaffDashboard extends StatefulWidget {
  StaffDashboard({Key? key}) : super(key: key);

  @override
  _StaffDashboardState createState() => _StaffDashboardState();
}

class _StaffDashboardState extends State<StaffDashboard>
    with WidgetsBindingObserver {
  late final FirebaseMessaging _messaging;
  void registerNotification() async {
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      // TODO: handle the received notifications
    } else {
      print('User declined or has not accepted permission');
    }
  }

  String? firebseToken;
  _getId() async {
    FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        firebseToken = value;
      });
      print("FirebaseToken $firebseToken");
    });
  }

  LocationData? _currentPosition, mycurrentPosition;
  String? _address, _dateTime, stopWatchTime;
  String? image, name, userId;
  String? clat, clong;
  bool? start, timesheet = false, dashboard = false;

  _launcherCaller() async {
    const url = "tel:+09715434535";
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  var data;
  // getdata() {
  //   Event().getEventLIstbyUser("$userId").then((userEventdata) {
  //     var eventId = "${userEventdata[0]['event_id']}";
  //     print(eventId);
  //   });
  // }

  String formatTime(int milliseconds) {
    var secs = milliseconds ~/ 1000;
    var hours = (secs ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (secs % 60).toString().padLeft(2, '0');

    return "$hours:$minutes:$seconds";
  }

  _getUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      image = prefs.getString("image");
      name = prefs.getString("name");
      userId = prefs.getString("userId");
      start = prefs.getBool("start");
    });

    // image = decodeImageFromPixels(base64Decode(image));
    getgAnalyticData("$userId");
  }

  getgAnalyticData(String userId) {
    Event().getEventLIstbyUser("$userId").then((userEventdata) {
      print(userEventdata);
      var eventId = userEventdata[0]['event_id'];
      Auth().getAnalyticStaff("$userId", "$eventId").then((value) {
        setState(() {
          data = value['data'];
        });
        print("Value ${value['data']}");
      });
    });
  }

  getLoc() async {
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
    setState(() {});
    setState(() {
      clat = "${_currentPosition!.latitude!}";
      clong = "${_currentPosition!.longitude!}";
    });

    print("Location : $clat $clong");
  }

  interNetConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      print('Internet Connected');
    } else {
      print('No internet :( Reason:');
      Event().getEventLIstbyUser("$userId").then((userEventdata) {
        var eventId = userEventdata[0]['event_id'];
        Shifts().endShift("$eventId", "$userId").then((value) async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          print("End shift $value");
          setState(() {
            prefs.setBool("start", true);
            start = true;
            // stopwatch.stop();
          });
          print("isShift e $start");
        });
      });
    }
  }

  updateStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Auth().updateOnlineStatus("$userId").then((value) {
      print("Updated Status in 110 Seconds");
      start = prefs.getBool("start");
      if (start != true) {
        interNetConnection();
        Event().getEventLIstbyUser("$userId").then(
          (userEventdata) {
            var eventId = userEventdata[0]['event_id'];
            print("$eventId $userId $clat $clong");
            Shifts()
                .updateLocation("$eventId", "$userId", "$clat", "$clong")
                .then((value) {
              print("Location Updated");
            });
          },
        );
        Event().getEventLIstbyUser("$userId").then((userEventdata) {
          var eventId = userEventdata[0]['event_id'];
          print(eventId);
          print("userEventdata ${userEventdata[0]['event_id']}");

          Event().getTeamDetail("$eventId", "$userId").then((useTeamDetails) {
            print("useTeamDetails ${useTeamDetails[0]}");
            String tlat = useTeamDetails[0]['latitude'];
            String tlong = "${useTeamDetails[0]['longitude']}";
            var teamId = useTeamDetails[0]['team_id'];

            var radius = Geolocator.distanceBetween(
                double.parse("$clat"),
                double.parse("$clong"),
                double.parse("$tlat"),
                double.parse("$tlong"));
            if (radius >= 100) {
              Event().getEventLIstbyUser("$userId").then((userEventdata) {
                var eventId = userEventdata[0]['event_id'];
                Shifts().endShift("$eventId", "$userId").then((value) async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  print("End shift $value");
                  prefs.setBool("start", true);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => StartShift()));
                  CommonFunctions.showSuccessToast('Shift Ended');
                });
              });
              // var errorMsg = 'Out of the zone!';
              // CommonFunctions.showErrorDialog("Shift Ended", errorMsg, context);

            }
          });
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getLoc();
    _getId();
    _getUserDetails();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("Hello");
    print('Current state = $state');
  }

  endShift() {
    print("end shift");
  }

  @override
  void dispose() {
    super.dispose();
    getLoc();
    endShift();
  }

  @override
  Widget build(BuildContext context) {
    Shifts shifts = Provider.of<Shifts>(context);
    Timer.periodic(Duration(seconds: 110), (Timer t) => updateStatus());
    return WillPopScope(
      onWillPop: () => showExitPopup(context, "$userId"),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: <Widget>[
                      Container(
                        height: 40 * SizeConfig.heightMultiplier,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(30)),
                          child: Image.asset(
                            Images.background,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            height: 40 * SizeConfig.heightMultiplier,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                // color: AppColors.appColor,
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(30))),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      // child: Icon(
                                      //   Icons.list,
                                      //   size: 35,
                                      //   color: Colors.white,
                                      // ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.error,
                                            size: 25,
                                            color: Colors.white,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 20),
                                            child: Text(
                                              "(1)",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Icon(
                                            Icons.message,
                                            size: 25,
                                            color: Colors.white,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 20),
                                            child: Text(
                                              "(1)",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Icon(
                                            Icons.manage_accounts,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 85,
                        left: 50,
                        right: 50,
                        // left: 125,
                        // right: 125,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(60)),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      // backgroundImage: NetworkImage("$image"),
                                      radius: 30),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => ChatS(
                                //               channelId: '',
                                //               userId: '',
                                //             )));
                              },
                              child: Text(
                                "$name",
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 10,
                    width: double.infinity,
                  ),
                  SizedBox(
                    height: 70,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        data != null
                            ? AnalyticContainer(
                                text: "Event Incidents",
                                today: data['event_incidents'],
                                total: data['total_incident_reports'],
                                color: AppColors.alert,
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                    left: 25, top: 15, bottom: 15, right: 20),
                                child: CircularProgressIndicator(),
                              ),
                        data != null
                            ? AnalyticContainer(
                                text: "Worked Hours",
                                today: data['today_incident_reports'],
                                total: data['today_incident_reports'],
                                color: Colors.blue,
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                    left: 25, top: 15, bottom: 15, right: 20),
                                child: CircularProgressIndicator(),
                              ),
                        data != null
                            ? AnalyticContainer(
                                text: "SOS",
                                today: data['total_event_sos'],
                                total: data['total_event_sos'],
                                color: AppColors.success,
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                    left: 25, top: 15, bottom: 15, right: 20),
                                child: CircularProgressIndicator(),
                              ),
                        data != null
                            ? AnalyticContainer(
                                text: "Instructions",
                                today: data['today_instructions'],
                                total: data['this_week_instructions'],
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                    left: 25, top: 15, bottom: 15, right: 20),
                                child: CircularProgressIndicator(),
                              ),
                        data != null
                            ? AnalyticContainer(
                                text: "Notifications",
                                today: data['today_notifications'],
                                total: data['total_notifications'],
                                color: Colors.blue,
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                    left: 25, top: 15, bottom: 15, right: 20),
                                child: CircularProgressIndicator(),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RowImageText(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StartShift(
                                      name: "$name",
                                    ),
                                  ),
                                );
                              },
                              text: 'MY SHIFT',
                              loading: false,
                              image: Images.clock,
                              img: true,
                            ),
                            RowImageText(
                              text: 'LIVE CHAT',
                              image: Images.chat,
                              img: true,
                              loading: false,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChatLists(userId: userId!),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RowImageText(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EventIncidentScreen(),
                                  ),
                                );
                              },
                              text: 'INCIDENT',
                              img: true,
                              loading: false,
                              image: Images.notes,
                            ),
                            RowImageText(
                              text: 'TIMESHEET',
                              img: true,
                              loading: timesheet,
                              image: Images.notes,
                              onPressed: () async {
                                setState(() {
                                  timesheet = true;
                                });
                                Event()
                                    .getEventLIstbyUser("$userId")
                                    .then((userEventdata) {
                                  var eventId = userEventdata[0]['event_id'];
                                  print(eventId);
                                  print(
                                      "userEventdata ${userEventdata[0]['event_id']}");
                                  Event()
                                      .getTeamDetail("$eventId", "$userId")
                                      .then((useTeamDetails) {
                                    print(
                                        "useTeamDetails ${useTeamDetails[0]}");
                                    var teamId = useTeamDetails[0]['team_id'];
                                    var teamHours =
                                        useTeamDetails[0]['total_hours'];
                                    var teamend = useTeamDetails[0]['end_time'];
                                    var teamstart =
                                        useTeamDetails[0]['start_time'];

                                    setState(() {
                                      timesheet = false;
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TimeSheet(
                                          eventId: "$eventId",
                                          userId: "$userId",
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
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RowImageText(
                              onPressed: () {
                                setState(() {
                                  dashboard = true;
                                });
                                Event()
                                    .getEventLIstbyUser("$userId")
                                    .then((userEventdata) {
                                  var eventId = userEventdata[0]['event_id'];
                                  print(eventId);
                                  setState(() {
                                    dashboard = false;
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EventDashboardScreen(
                                        userId: '$userId',
                                        eventId: "$eventId",
                                      ),
                                    ),
                                  );
                                });

                                // Event()
                                //     .getEventLIstbyUser("$userId")
                                //     .then((userEventdata) {
                                //   var eventId = "${userEventdata[0]['event_id']}";
                                //   print(eventId);

                                //   // Navigator.push(
                                //   //   context,
                                //   //   MaterialPageRoute(
                                //   //     builder: (context) =>
                                //   //         EventScheduleStaffScreen(
                                //   //       eventId: "$eventId",
                                //   //       userId: "$userId",
                                //   //     ),
                                //   //   ),
                                //   // );
                                // });
                              },
                              text: 'MY EVENT',
                              loading: dashboard,
                              img: true,
                              image: Images.notes,
                            ),
                            RowImageText(
                              text: 'LOGOUT',
                              img: true,
                              loading: false,
                              image: Images.logout,
                              onPressed: () async {
                                print("User is staff");
                                await Provider.of<Auth>(context, listen: false)
                                    .logout("$userId")
                                    .then((value) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MyApp(),
                                    ),
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        CuatomButton(
                          text: 'SOS',
                          loading: true,
                          backgourndColor: AppColors.alert,
                          img: true,
                          height: 40,
                          image: Images.error,
                          onPressed: () {
                            print("Click on SOS");
                            Event()
                                .getEventLIstbyUser("$userId")
                                .then((userEventdata) {
                              var eventId = userEventdata[0]['event_id'];

                              Event()
                                  .getTeamDetail("$eventId", "$userId")
                                  .then((useTeamDetails) {
                                var teamId = useTeamDetails[0]['team_id'];
                                Event()
                                    .sos("$userId", "$eventId", "$teamId")
                                    .then((value) {
                                  CommonFunctions.showSuccessToast(
                                      'Activity posted successfully !');
                                  print("Sent Sos ${value.body}");
                                });
                              });
                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CuatomButton(
                          text: 'CALL SUPERVISOR',
                          img: true,
                          loading: true,
                          image: Images.call,
                          backgourndColor: AppColors.success,
                          height: 40,
                          onPressed: () {
                            print("Click on  LIVE SUPERVISOR");
                            _launcherCaller();
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BASE64 {}
// EH796Q3l