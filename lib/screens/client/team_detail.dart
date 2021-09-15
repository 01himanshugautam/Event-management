import 'package:flutter/material.dart';
import 'package:pn_204_sam/Auth/events.dart';
import 'package:pn_204_sam/utilites/images.dart';
import 'package:pn_204_sam/utilites/size_configration.dart';
import 'package:pn_204_sam/utilites/styles.dart';
import 'package:pn_204_sam/widgets/nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamDetailScreen extends StatefulWidget {
  TeamDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  _TeamDetailScreenState createState() => _TeamDetailScreenState();
}

class _TeamDetailScreenState extends State<TeamDetailScreen> {
  var data;
  getteamdetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId");
    Event().getEventLIstbyUser("$userId").then((userEventdata) {
      var eventId = userEventdata[0]['event_id'];
      Event().sGetTeamDetail("$eventId").then((value) {
        setState(() {
          data = value;
        });
        print(data);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getteamdetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: NavBar(text: "TEAM DETAILS"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
                child: Text("Manager",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: AppColors.appColor,
                    )),
              ),
              SizedBox(
                height: 150,
                width: 370,
                child: data != null
                    ? ListView.builder(
                        itemCount: data[0]['manager_ids'].length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              height: 200,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: AppColors.appColor,
                                        blurRadius: 2,
                                        // offset: Offset(2, 3),
                                        spreadRadius: 2)
                                  ],
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(25)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 35 * SizeConfig.heightMultiplier,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                                backgroundColor: Colors.grey,
                                                // backgroundImage: NetworkImage(
                                                //     "https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHByb2ZpbGV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
                                                radius: 30),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "${data[0]['manager_ids'][index]['name']}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.appColor),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: 35 * SizeConfig.heightMultiplier,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Icon(
                                            Icons.call,
                                            size: 30,
                                            color: AppColors.appColor,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Image.asset(
                                            Images.chat,
                                            height: 30,
                                            color: AppColors.appColor,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Icon(
                                            Icons.location_on,
                                            size: 30,
                                            color: AppColors.appColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${data[0]['manager_ids'][index]['status']}",
                                        style: TextStyle(
                                            color: AppColors.appColor,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      data[0]['manager_ids'][index]['status'] !=
                                              "offline"
                                          ? Container(
                                              height: 10,
                                              width: 10,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            )
                                          : Container(
                                              height: 10,
                                              width: 10,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        })
                    : Center(child: CircularProgressIndicator()),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Supervisor",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: AppColors.appColor,
                    )),
              ),
              SizedBox(
                height: 150,
                width: 370,
                child: data != null
                    ? ListView.builder(
                        itemCount: data[0]['supervisor_ids'].length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              height: 200,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: AppColors.appColor,
                                        blurRadius: 2,
                                        // offset: Offset(2, 3),
                                        spreadRadius: 2)
                                  ],
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(25)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor: Colors.grey,
                                              // backgroundImage: NetworkImage(
                                              //     "https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHByb2ZpbGV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
                                              radius: 30),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "${data[0]['supervisor_ids'][index]['name']}",
                                            style: TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.appColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: 35 * SizeConfig.heightMultiplier,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Icon(
                                            Icons.call,
                                            size: 30,
                                            color: AppColors.appColor,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Image.asset(
                                            Images.chat,
                                            height: 30,
                                            color: AppColors.appColor,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Icon(
                                            Icons.location_on,
                                            size: 30,
                                            color: AppColors.appColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${data[0]['supervisor_ids'][index]['status']}",
                                        style: TextStyle(
                                            color: AppColors.appColor,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      data[0]['supervisor_ids'][index]
                                                  ['status'] !=
                                              "offline"
                                          ? Container(
                                              height: 10,
                                              width: 10,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            )
                                          : Container(
                                              height: 10,
                                              width: 10,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        })
                    : Center(child: CircularProgressIndicator()),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text("Staff",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: AppColors.appColor,
                    )),
              ),
              SizedBox(
                height: 150,
                width: 370,
                child: data != null
                    ? ListView.builder(
                        itemCount: data[0]['security_personnals'].length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              height: 200,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: AppColors.appColor,
                                        blurRadius: 2,
                                        // offset: Offset(2, 3),
                                        spreadRadius: 2)
                                  ],
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(25)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor: Colors.grey,
                                              // backgroundImage: NetworkImage(
                                              //     "https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHByb2ZpbGV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
                                              radius: 30),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "${data[0]['security_personnals'][index]['user_name']}",
                                            style: TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.appColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: 35 * SizeConfig.heightMultiplier,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Icon(
                                            Icons.call,
                                            size: 30,
                                            color: AppColors.appColor,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Image.asset(
                                            Images.chat,
                                            height: 30,
                                            color: AppColors.appColor,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Icon(
                                            Icons.location_on,
                                            size: 30,
                                            color: AppColors.appColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${data[0]['security_personnals'][index]['status']}",
                                        style: TextStyle(
                                            color: AppColors.appColor,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      data[0]['security_personnals'][index]
                                                  ['status'] !=
                                              "offline"
                                          ? Container(
                                              height: 10,
                                              width: 10,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            )
                                          : Container(
                                              height: 10,
                                              width: 10,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        })
                    : Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
