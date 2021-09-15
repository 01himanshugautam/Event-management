import 'package:flutter/material.dart';
import 'package:pn_204_sam/Auth/events.dart';
import 'package:pn_204_sam/screens/staff/event_schedule.dart';
import 'package:pn_204_sam/utilites/images.dart';
import 'package:pn_204_sam/utilites/styles.dart';
import 'package:pn_204_sam/widgets/custom_buttom.dart';
import 'package:pn_204_sam/widgets/nav_bar.dart';

class EventOngoingList extends StatefulWidget {
  final String text;
  final String userId;
  final int number;
  final String state;
  final String eventId;
  EventOngoingList({
    Key? key,
    required this.text,
    required this.number,
    required this.userId,
    required this.state,
    required this.eventId,
  }) : super(key: key);

  @override
  State<EventOngoingList> createState() => _EventOngoingListState();
}

class _EventOngoingListState extends State<EventOngoingList> {
  List? data;
  bool loading = true;
  fetchData() {
    print(data);
    setState(() {
      loading = true;
    });
    print("Event ${widget.text}");
    Event().getEventLIstbyUser("${widget.userId}").then((value) {
      data = value;
      print("value ${data}");
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    var device = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: NavBar(text: "${widget.text}"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  loading != true
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 320,
                              height: 540,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: data!.length,
                                itemBuilder: (context, index) {
                                  if (data![index]['state'] ==
                                      "${widget.state}") {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EventScheduleStaffScreen(
                                              eventId:
                                                  "$data![index]['event_id']}",
                                              userId: "${widget.userId}",
                                              state: "${widget.state}",
                                              startday:
                                                  "${data![index]['start_time']}",
                                              endday:
                                                  "${data![index]['end_time']}",
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 8.0),
                                        child: Container(
                                          height: 190,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    color: AppColors.appColor,
                                                    blurRadius: 2,
                                                    offset: Offset(2, 5),
                                                    spreadRadius: 5)
                                              ],
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Color(0xFF444546),
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Event Number: ",
                                                          style: TextStyle(
                                                            fontSize: 22,
                                                            color: AppColors
                                                                .appColor,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${data![index]['event_number']}",
                                                          style: TextStyle(
                                                            fontSize: 22,
                                                            color: AppColors
                                                                .appColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Event: ",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: AppColors
                                                                .appColor,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${data![index]['event_name']}",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: AppColors
                                                                .appColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Costumer:",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: AppColors
                                                                .appColor,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${data![index]['customer']}",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: AppColors
                                                                .appColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 8),
                                                    Container(
                                                      width: 300,
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Manager",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  color: AppColors
                                                                      .appColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              Text(
                                                                "Supervisor",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  color: AppColors
                                                                      .appColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              Text(
                                                                "Staff",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  color: AppColors
                                                                      .appColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "${data![index]['total_manager']}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  color: Color(
                                                                      0xFF0045A4),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 110),
                                                              Text(
                                                                "${data![index]['total_supervisor']}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  color: Color(
                                                                      0xFF0045A4),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 110),
                                                              Text(
                                                                "${data![index]['how_may_staff']}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  color: Color(
                                                                      0xFF0045A4),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Container(
                                                            width: 320,
                                                            decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .success,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "Start Time: ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Color(
                                                                        0xFFFFFFFF),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "${data![index]['start_time']}",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Color(
                                                                        0xFFFFFFFF),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Container(
                                                            width: 320,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColors
                                                                  .alert,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "End Time: ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Color(
                                                                        0xFFFFFFFF),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  " ${data![index]['end_time']}",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Color(
                                                                        0xFFFFFFFF),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Container(
                            //       height: 60,
                            //       width: 150,
                            //       decoration: BoxDecoration(
                            //         color: Colors.blue[900],
                            //         borderRadius: BorderRadius.circular(15),
                            //       ),
                            //       child: Row(
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         children: [
                            //           Container(
                            //               height: 20,
                            //               width: 20,
                            //               child: Image.asset(
                            //                 Images.logo,
                            //                 fit: BoxFit.cover,
                            //               )),
                            //           SizedBox(
                            //             width: 5,
                            //           ),
                            //           Text(
                            //             "CREATE",
                            //             style: TextStyle(
                            //                 color: Colors.white, fontSize: 16),
                            //           )
                            //         ],
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: 15,
                            //     ),
                            //     Container(
                            //       height: 60,
                            //       width: 150,
                            //       decoration: BoxDecoration(
                            //         color: Colors.blue[900],
                            //         borderRadius: BorderRadius.circular(15),
                            //       ),
                            //       child: Row(
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         children: [
                            //           Container(
                            //               height: 20,
                            //               width: 20,
                            //               child: Image.asset(
                            //                 Images.logo,
                            //                 fit: BoxFit.cover,
                            //               )),
                            //           SizedBox(
                            //             width: 5,
                            //           ),
                            //           Text(
                            //             "EDIT",
                            //             style: TextStyle(
                            //                 color: Colors.white, fontSize: 16),
                            //           )
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        )
                      : CircularProgressIndicator(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
