import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:location/location.dart';
import 'package:pn_204_sam/Auth/auth.dart';
import 'package:pn_204_sam/Auth/events.dart';
import 'package:pn_204_sam/Auth/shifts.dart';
import 'package:pn_204_sam/models/common_functions.dart';
import 'package:pn_204_sam/screens/event_dashboard.dart';
import 'package:pn_204_sam/screens/staff/timesheet.dart';
import 'package:pn_204_sam/utilites/images.dart';
import 'package:pn_204_sam/utilites/size_configration.dart';
import 'package:pn_204_sam/utilites/styles.dart';
import 'package:pn_204_sam/widgets/row_imgae_text.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String formatTime(int milliseconds) {
  var secs = milliseconds ~/ 1000;
  var hours = (secs ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (secs % 60).toString().padLeft(2, '0');

  return "$hours:$minutes:$seconds";
}

class StartShift extends StatefulWidget {
  final double? lat;
  final double? lang;
  final String? name;
  StartShift({Key? key, this.lat, this.lang, this.name}) : super(key: key);

  @override
  _StartShiftState createState() => _StartShiftState();
}

class _StartShiftState extends State<StartShift> {
  String? clat, clong;
  String? image, name, userId, startTime, stopWatchTime;
  bool? start, startBreak;
  bool loading = false,
      scolor = true,
      bcolor = true,
      bloading = false,
      timesheet = false;
  Stopwatch stopwatch = Stopwatch();
  LocationData? _currentPosition, mycurrentPosition;

  isShiftStart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      start = prefs.getBool("start");
      startBreak = prefs.getBool("startBreak");
      if (start != true) {
        scolor = false;
        if (startBreak != true) {
          bcolor = false;
        }
      }
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

  _getUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(
      () {
        image = prefs.getString("image");
        name = prefs.getString("name");
        userId = prefs.getString("userId");
        startTime = prefs.getString("startTime");
        start = prefs.getBool("start");
        stopWatchTime = prefs.getString("stopWatchTime");
      },
    );
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

  updateStopwatch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      stopWatchTime = "${formatTime(stopwatch.elapsedMilliseconds)}";
      prefs.setString("stopWatchTime", "$stopWatchTime");
    });
    print("Time update");
    // if (start != true) {
    //   interNetConnection();
    //   Event().getEventLIstbyUser("$userId").then(
    //     (userEventdata) {
    //       var eventId = userEventdata[0]['event_id'];
    //       print("$eventId $userId $clat $clong");
    //       Shifts()
    //           .updateLocation("$eventId", "$userId", "$clat", "$clong")
    //           .then((value) {
    //         print("Location Updated");
    //       });
    //     },
    //   );
    //   Event().getEventLIstbyUser("$userId").then((userEventdata) {
    //     var eventId = userEventdata[0]['event_id'];
    //     print(eventId);
    //     print("userEventdata ${userEventdata[0]['event_id']}");

    //     Event().getTeamDetail("$eventId", "$userId").then((useTeamDetails) {
    //       print("useTeamDetails ${useTeamDetails[0]}");
    //       String tlat = useTeamDetails[0]['latitude'];
    //       String tlong = "${useTeamDetails[0]['longitude']}";
    //       var teamId = useTeamDetails[0]['team_id'];

    //       var radius = Geolocator.distanceBetween(
    //           double.parse("$clat"),
    //           double.parse("$clong"),
    //           double.parse("$tlat"),
    //           double.parse("$tlong"));
    //       if (radius >= 100) {
    //         Event().getEventLIstbyUser("$userId").then((userEventdata) {
    //           var eventId = userEventdata[0]['event_id'];
    //           Shifts().endShift("$eventId", "$userId").then((value) async {
    //             final SharedPreferences prefs =
    //                 await SharedPreferences.getInstance();
    //             print("End shift $value");
    //             prefs.setBool("start", true);
    //           });
    //         });
    //         var errorMsg = 'Out of the zone!';
    //         CommonFunctions.showErrorDialog("Shift Ended", errorMsg, context);
    //       }
    //     });
    //   });
    // }
  }

  @override
  void initState() {
    super.initState();
    isShiftStart();
    getLoc();
    _getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    Shifts shifts = Provider.of<Shifts>(context);
    if (start != true) {
      Timer.periodic(Duration(seconds: 1), (Timer t) => updateStopwatch());
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    Column(
                      children: [
                        Container(
                          height: 23 * SizeConfig.heightMultiplier,
                          width: double.infinity,
                          color: AppColors.appColor,
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
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.arrow_back, size: 35),
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 8 * SizeConfig.heightMultiplier,
                          width: double.infinity,
                        ),
                      ],
                    ),
                    Positioned(
                      top: 62,
                      left: 50,
                      right: 50,
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
                                    // backgroundImage: NetworkImage(
                                    //     "https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHByb2ZpbGV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
                                    radius: 30),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "${widget.name}",
                            style: TextStyle(fontSize: 23, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "$stopWatchTime",
                                style:
                                    TextStyle(fontSize: 25, color: Colors.grey),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
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
                            text: start == true ? 'START SHIFT' : "END SHIFT",
                            image: Images.logo,
                            img: true,
                            loading: loading,
                            color: scolor,
                            onPressed: () {
                              print(startBreak);
                              if (startBreak == true) {
                                setState(() {
                                  loading = true;
                                });
                                if (start == true) {
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
                                      String tlat =
                                          useTeamDetails[0]['latitude'];
                                      String tlong =
                                          "${useTeamDetails[0]['longitude']}";
                                      var teamId = useTeamDetails[0]['team_id'];

                                      var radius = Geolocator.distanceBetween(
                                          double.parse("$clat"),
                                          double.parse("$clong"),
                                          double.parse("$tlat"),
                                          double.parse("$tlong"));
                                      if (radius <= 100) {
                                        print(
                                            "First Location Validator $teamId");

                                        DateTime currentDate =
                                            new DateTime.now();
                                        print(currentDate);
                                        DateTime startDateTime = DateTime.parse(
                                            useTeamDetails[0]['start_time']);
                                        DateTime endDateTime = DateTime.parse(
                                            useTeamDetails[0]['end_time']);
                                        if (startDateTime
                                                .isBefore(currentDate) &&
                                            endDateTime.isAfter(currentDate)) {
                                          print(
                                              "$radius \nSecond Time Validator");
                                          Shifts()
                                              .start("$eventId", "$userId",
                                                  "$clat", "$clong", "$teamId")
                                              .then((shiftdata) async {
                                            Stopwatch().start();
                                            final SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            print(shiftdata);
                                            // GeoCode geoCode = GeoCode();
                                            // final coordinates = new Coordinates(
                                            //   double.parse("$clat"),
                                            //   double.parse("$clong"),
                                            // );
                                            // var add = await Geocoder.local
                                            //     .findAddressesFromCoordinates(
                                            //         coordinates);
                                            // var add = geoCode.reverseGeocoding(
                                            //     latitude: double.parse("$clat"),
                                            //     longitude:
                                            //         double.parse("$clat"));
                                            print(shiftdata.data['data']
                                                ['message']);

                                            if (shiftdata.data['data']
                                                    ['message'] ==
                                                "Shift started successfully!") {
                                              print("isShift s $start");

                                              setState(() {
                                                prefs.setBool("start", false);
                                                start = false;
                                                scolor = false;
                                                loading = false;
                                                stopwatch.start();
                                                startTime =
                                                    "Started Shift at ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
                                                prefs.setString(
                                                    "startTime", "$startTime");
                                                prefs.setBool("start", start!);
                                              });
                                            } else {
                                              setState(() {
                                                loading = false;
                                              });
                                              CommonFunctions.showErrorDialog(
                                                  "Start Shift Failed",
                                                  "Cannot create new attendance record for ${widget.name}",
                                                  context);
                                            }
                                          });
                                        } else {
                                          CommonFunctions.showErrorDialog(
                                              "Start Shift Failed",
                                              "Do start shift on time",
                                              context);
                                          setState(() {
                                            loading = false;
                                          });
                                          print("Time not Match");
                                        }
                                      } else {
                                        CommonFunctions.showErrorDialog(
                                            "Start Shift Failed",
                                            "You are out of Zone",
                                            context);
                                        setState(() {
                                          loading = false;
                                        });
                                        print("Sift End Code");
                                      }
                                    });
                                  });
                                } else {
                                  Event()
                                      .getEventLIstbyUser("$userId")
                                      .then((userEventdata) {
                                    var eventId = userEventdata[0]['event_id'];
                                    Shifts()
                                        .endShift("$eventId", "$userId")
                                        .then((value) async {
                                      final SharedPreferences prefs =
                                          await SharedPreferences.getInstance();

                                      print("End shift $value");
                                      setState(() {
                                        prefs.setBool("start", true);
                                        stopwatch.stop();
                                        start = true;
                                        loading = false;
                                        scolor = true;
                                        startTime =
                                            "Shift Ended at ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
                                        prefs.setString(
                                            "startTime", "$startTime");
                                        prefs.setBool("start", start!);
                                        // stopwatch.stop();
                                      });
                                      print("isShift e $start");
                                    });
                                  });
                                }
                              } else {
                                CommonFunctions.showErrorDialog(
                                    "Start Shift Failed",
                                    "End break first",
                                    context);
                              }
                            },
                          ),
                          RowImageText(
                            loading: bloading,
                            text: startBreak == true
                                ? 'START BREAK'
                                : 'END BREAK',
                            image: Images.logo,
                            img: true,
                            color: bcolor,
                            onPressed: () async {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              if (start == true) {
                                setState(() {
                                  bloading = true;
                                });
                                if (startBreak == true) {
                                  Event()
                                      .getEventLIstbyUser("$userId")
                                      .then((userEventdata) {
                                    var eventId = userEventdata[0]['event_id'];
                                    Shifts()
                                        .startBreak("$eventId", "$userId")
                                        .then((value) async {
                                      final SharedPreferences prefs =
                                          await SharedPreferences.getInstance();

                                      print("Start Break $value");
                                      setState(() {
                                        prefs.setBool("startBreak", false);
                                        startBreak = false;
                                        bcolor = false;
                                        bloading = false;
                                        startTime =
                                            "Start Break at ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
                                        prefs.setString(
                                            "startTime", "$startTime");
                                        // stopwatch.stop();
                                      });
                                      print("isBreak s $start");
                                    });
                                  });
                                } else {
                                  setState(() {
                                    bloading = true;
                                  });
                                  Event()
                                      .getEventLIstbyUser("$userId")
                                      .then((userEventdata) {
                                    var eventId = userEventdata[0]['event_id'];
                                    Shifts()
                                        .endBreak("$eventId", "$userId")
                                        .then((value) async {
                                      final SharedPreferences prefs =
                                          await SharedPreferences.getInstance();

                                      print("End Break $value");
                                      setState(() {
                                        prefs.setBool("startBreak", true);
                                        startBreak = true;
                                        bcolor = true;
                                        bloading = false;
                                        startTime =
                                            "Ended break at ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
                                        prefs.setString(
                                            "startTime", "$startTime");
                                        // stopwatch.stop();
                                      });
                                      print("isBreak e $start");
                                    });
                                  });
                                }
                              } else {
                                CommonFunctions.showErrorDialog(
                                    "Start Break Failed",
                                    "End shift first",
                                    context);
                                print("Please start shit");
                              }
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF696969),
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: 45 * SizeConfig.heightMultiplier,
                            height: 186,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.lock_clock,
                                        color: Color(0xFF696969),
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        startTime != null
                                            ? "$startTime"
                                            : "00:00:00",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF696969),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 60,
                                          width:
                                              22 * SizeConfig.heightMultiplier,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                  color: Colors.grey),
                                              top: BorderSide(
                                                  color: Colors.grey),
                                              bottom: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "MEAL BREAK",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xFF696969),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                "Unpaid",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: AppColors.appColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 60,
                                          width:
                                              22 * SizeConfig.heightMultiplier,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                  color: Colors.grey),
                                              bottom: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "DURATION",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xFF696969),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                "30min",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: AppColors.appColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 60,
                                          width:
                                              22 * SizeConfig.heightMultiplier,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "REST BREAK",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xFF696969),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                "Paid",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: AppColors.appColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 60,
                                          width:
                                              22 * SizeConfig.heightMultiplier,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "DURATION",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xFF696969),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                "15min",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: AppColors.appColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RowImageText(
                            loading: false,
                            onPressed: () {
                              // Shifts().updateLocation(
                              //     "106", "169", "37.4219881", "-122.0840152");
                            },
                            text: 'REQUEST LEAVE',
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
                                  print("useTeamDetails ${useTeamDetails[0]}");
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
