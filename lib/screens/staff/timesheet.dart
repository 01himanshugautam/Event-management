import 'package:flutter/material.dart';
import 'package:pn_204_sam/Auth/shifts.dart';
import 'package:pn_204_sam/utilites/size_configration.dart';
import 'package:pn_204_sam/utilites/styles.dart';
import 'package:pn_204_sam/widgets/custom_buttom.dart';
import 'package:pn_204_sam/widgets/nav_bar.dart';

class TimeSheet extends StatefulWidget {
  final String eventId;
  final String userId;
  final String limit;
  final String offset;
  final String teamId;
  final String teamStart;
  final String teamEnd;
  final String teamHours;
  TimeSheet({
    Key? key,
    required this.eventId,
    required this.limit,
    required this.offset,
    required this.teamId,
    required this.userId,
    required this.teamStart,
    required this.teamEnd,
    required this.teamHours,
  }) : super(key: key);

  @override
  _TimeSheetState createState() => _TimeSheetState();
}

class _TimeSheetState extends State<TimeSheet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

//  NavBar(text: "TIMESHEET"),
  @override
  Widget build(BuildContext context) {
    var device = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: NavBar(text: "TIMESHEET"),
      ),
      body: Container(
          height: device.height,
          width: device.width,
          child: FutureBuilder(
            future: Shifts().timeSheetDetail(
                "${widget.eventId}",
                "${widget.userId}",
                "${widget.limit}",
                "${widget.offset}",
                "${widget.teamId}"),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print(snapshot.connectionState);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else {
                  var timeSheet = snapshot.data[0];
                  double totaltime = 0;

                  for (var i = 0; i < snapshot.data.length; i++) {
                    totaltime += timeSheet['worked_hours'];
                  }
                  String totalworkedtime = "$totaltime".substring(0, 5);
                  return Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "From",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.appColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(width: 150),
                                Text(
                                  "To",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.appColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 25 * SizeConfig.heightMultiplier,
                                  height: 8 * SizeConfig.heightMultiplier,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(color: Colors.grey),
                                      right: BorderSide(color: Colors.grey),
                                      top: BorderSide(color: Colors.grey),
                                      bottom: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Center(
                                    child: Text(
                                      "${widget.teamStart}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF696969),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 25 * SizeConfig.heightMultiplier,
                                  height: 8 * SizeConfig.heightMultiplier,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: Colors.grey),
                                      bottom: BorderSide(color: Colors.grey),
                                      right: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Center(
                                    child: Text(
                                      "${widget.teamEnd}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF696969),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 25 * SizeConfig.heightMultiplier,
                              height: 8 * SizeConfig.heightMultiplier,
                              color: Color(0xFF02AD1F),
                              child: Center(
                                child: Text(
                                  "Team Hours: ${widget.teamHours} H",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Container(
                              width: 25 * SizeConfig.heightMultiplier,
                              height: 8 * SizeConfig.heightMultiplier,
                              color: Color(0xFFDAC400),
                              child: Center(
                                child: Text(
                                  "Worked Hours: $totalworkedtime H",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFF525457))),
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 10),
                              Container(
                                width: 8 * SizeConfig.heightMultiplier,
                                height: 6 * SizeConfig.heightMultiplier,
                                // color: AppColors.appColor,
                                child: Center(
                                  child: Text(
                                    "DATE",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF000000),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              // SizedBox(width: 8),
                              Container(
                                width: 7.5 * SizeConfig.heightMultiplier,
                                height: 6 * SizeConfig.heightMultiplier,
                                // color: AppColors.appColor,
                                child: Center(
                                  child: Text(
                                    "START",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF000000),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              Container(
                                width: 7.5 * SizeConfig.heightMultiplier,
                                height: 6 * SizeConfig.heightMultiplier,
                                // color: AppColors.appColor,
                                child: Center(
                                  child: Text(
                                    "END",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                width: 8 * SizeConfig.heightMultiplier,
                                height: 6 * SizeConfig.heightMultiplier,
                                // color: AppColors.appColor,
                                child: Center(
                                  child: Text(
                                    "HOURS",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF000000),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                width: 7 * SizeConfig.heightMultiplier,
                                height: 6 * SizeConfig.heightMultiplier,
                                // color: AppColors.appColor,
                                child: Center(
                                  child: Text(
                                    "STATUS",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF000000),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                width: 8 * SizeConfig.heightMultiplier,
                                height: 6 * SizeConfig.heightMultiplier,
                                // color: AppColors.appColor,
                                child: Center(
                                  child: Text(
                                    "REMARK",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: device.width,
                          height: 40 * SizeConfig.heightMultiplier,
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xFF525457),
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 10),
                                    Container(
                                      width: 10 * SizeConfig.heightMultiplier,
                                      margin: EdgeInsets.only(left: 5),
                                      child: Text(
                                        "${snapshot.data[index]['check_in']}"
                                            .substring(0, 10),
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xFF525457),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 8 * SizeConfig.heightMultiplier,
                                      child: Text(
                                        "${snapshot.data[index]['check_in']}"
                                            .substring(10, 19),
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xFF525457),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 8 * SizeConfig.heightMultiplier,
                                      child: Text(
                                        snapshot.data[index]['check_in']
                                                .toString()
                                                .isNotEmpty
                                            ? "${snapshot.data[index]['check_in']}"
                                                .substring(10, 19)
                                            : "",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xFF525457),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 6 * SizeConfig.heightMultiplier,
                                      child: Text(
                                        "${snapshot.data[index]['worked_hours']}"
                                            .substring(0, 5),
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xFF525457),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                      width: 7 * SizeConfig.heightMultiplier,
                                      child: Text(
                                        "${snapshot.data[index]['status']}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xFF525457),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 6.5 * SizeConfig.heightMultiplier,
                                      child: Text(
                                        "${snapshot.data[index]['remark']}"
                                            .substring(0, 5),
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xFF525457),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CuatomButton(
                          width: 50 * SizeConfig.heightMultiplier,
                          height: 7 * SizeConfig.heightMultiplier,
                          text: 'REQUEST FOR APPROVAL',
                          loading: true,
                          onPressed: () {
                            print("Click on Login page");
                          },
                        ),
                      ],
                    ),
                  );
                }
                // else {
                //   return Center(child: const Text('Empty data'));
                // }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          )),
    );
  }
}
