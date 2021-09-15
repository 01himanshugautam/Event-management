import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventLocationDetail extends StatefulWidget {
  EventLocationDetail({Key? key}) : super(key: key);

  @override
  _EventLocationDetailState createState() => _EventLocationDetailState();
}

class _EventLocationDetailState extends State<EventLocationDetail> {
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  Completer<GoogleMapController> controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

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
                "EVENT LOCATION DETAILS",
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("General Info",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue[900])),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rishtan Konope",
                            style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          ),
                          Text(
                            "Boyd82@gmail.com",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Active",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10)),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.lock_clock_outlined,
                    color: Colors.blue[900],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "06:30 pm",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Colors.blue[900],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  // Text(
                  //   "114 Retta Summit, Jenkinsfurt, DE, GY",
                  //   style: TextStyle(fontSize: 14, color: Colors.grey),
                  // ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 300,
                width: 380,
                // color: Colors.grey,
                child: SizedBox(
                  height: 300,
                  width: 380,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 11.0,
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // Text("Start Date and End Date",
              //     style: TextStyle(
              //         fontSize: 16,
              //         fontWeight: FontWeight.w500,
              //         color: Colors.blue[900])),
              // SizedBox(
              //   height: 15,
              // ),
              // TableCalendar(
              //   focusedDay: DateTime.now(),
              //   firstDay: DateTime(2021, 8, 1),
              //   lastDay: DateTime(2021, 8, 30),
              //   calendarStyle: CalendarStyle(
              //     todayDecoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(15),
              //         color: Colors.blue[900]),
              //   ),
              //   headerStyle: HeaderStyle(
              //     titleCentered: true,
              //     formatButtonVisible: false,
              //     formatButtonTextStyle: TextStyle(color: Colors.white),
              //     formatButtonShowsNext: false,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
// amitsengh2002@gmail.com 123456