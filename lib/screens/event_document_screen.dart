import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:pn_204_sam/Auth/incident.dart';
import 'package:pn_204_sam/screens/edit_incident.dart';
import 'package:pn_204_sam/utilites/images.dart';
import 'package:pn_204_sam/utilites/styles.dart';
import 'package:pn_204_sam/widgets/nav_bar.dart';

class EVENTDOCUMENTLIST extends StatefulWidget {
  final String eventId;
  EVENTDOCUMENTLIST({
    Key? key,
    required this.eventId,
  }) : super(key: key);

  @override
  _EVENTDOCUMENTLISTState createState() => _EVENTDOCUMENTLISTState();
}

class _EVENTDOCUMENTLISTState extends State<EVENTDOCUMENTLIST> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLoc();
    // Incident().getIncidentReport("9");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(90),
            child: NavBar(text: "EVENT INCIDENTS")),
        body: FutureBuilder(
          future: Incident().getIncidentReport("${widget.eventId}"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.connectionState);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else {
                print(snapshot.data);
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      print(snapshot.data[index]['profile']);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditIncident(
                                eventId: "${widget.eventId}",
                                incidentId: "${snapshot.data[index]['id']}",
                                comment: "${snapshot.data[index]['comment']}",
                                daysPassed:
                                    "${snapshot.data[index]['days_passed']}",
                                incGuardMa:
                                    "${snapshot.data[index]['inc_guard_man']}",
                                incGuardSup:
                                    "${snapshot.data[index]['inc_guard_sup']}",
                                incTeamArea: "10",
                                incType: "${snapshot.data[index]['inc_type']}",
                                incGeoLocation: "10",
                                reportedBy:
                                    "${snapshot.data[index]['reported_by']}",
                                resolvedState:
                                    "${snapshot.data[index]['status']}",
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 15, top: 10, right: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              color: snapshot.data[index]['status'] == "pending"
                                  ? AppColors.pending
                                  : AppColors.success,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            ),
                            padding:
                                EdgeInsets.only(left: 15, top: 10, right: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Reported Date: ${snapshot.data[index]['date'].toString().substring(0, 16)}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.backgroundColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Reported By: ${snapshot.data[index]['reported_by']}',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.backgroundColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Inceident Type: ${snapshot.data[index]['inc_type']}',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.backgroundColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Days Passed: ${snapshot.data[index]['days_passed']}',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.backgroundColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Status: ${snapshot.data[index]['status']}',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.backgroundColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
              // else {
              //   return Center(child: const Text('Empty data'));
              // }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          },
        ));
  }
}
