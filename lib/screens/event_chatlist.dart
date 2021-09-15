import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pn_204_sam/Auth/chat.dart';
import 'package:pn_204_sam/Auth/events.dart';
import 'package:pn_204_sam/screens/conversation_screen.dart';
import 'package:pn_204_sam/utilites/size_configration.dart';
import 'package:pn_204_sam/utilites/styles.dart';
import 'package:pn_204_sam/widgets/custom_list_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventChatLists extends StatefulWidget {
  final String eventId;
  final String userId;
  EventChatLists({
    Key? key,
    required this.eventId,
    required this.userId,
  }) : super(key: key);

  @override
  _EventChatListsState createState() => _EventChatListsState();
}

class _EventChatListsState extends State<EventChatLists> {
  bool dropDown = false;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var device = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 100,
                width: device.width,
                decoration: BoxDecoration(
                  color: AppColors.appColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 15.0, left: 15),
                  child: Row(
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
                        width: 120,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15.0, left: 15),
                        child: Text(
                          "CHAT",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                future: Chat().eventChatThreads(
                    "${widget.userId}", "${widget.eventId}", "0", "0"),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print(snapshot.connectionState);
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        // child: CircularProgressIndicator(),
                        );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else {
                      var data = snapshot.data;

                      int groupLength = 0;
                      print(groupLength);
                      for (var i = 0; i < snapshot.data.length; i++) {
                        print(data[i]['type']);

                        if (data[i]['type'] == 'groups') {
                          print(data[i]['type']);
                          groupLength = groupLength + 1;
                        }
                      }

                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    SizedBox(
                                      width: 43 * SizeConfig.heightMultiplier,
                                      height: 600,
                                      child: groupLength != 0
                                          ? ListView.builder(
                                              itemCount: groupLength,
                                              padding: EdgeInsets.zero,
                                              itemBuilder: (context, index) {
                                                return CustomListTile(
                                                  name:
                                                      "${data[index]['name']}",
                                                  description:
                                                      "${data[index]['description']}",
                                                  time:
                                                      "${data[index]['create_date']}",
                                                  onPressed: () {
                                                    print(
                                                        "Channel Id:${data[index]['channel_id']}");
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ConversationScreen(
                                                          name:
                                                              "${data[index]['name']}",
                                                          img:
                                                              "https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHByb2ZpbGV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
                                                          userId:
                                                              "${widget.userId}",
                                                          channelId:
                                                              "${data[index]['channel_id']}",
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              })
                                          : Center(child: Text("")),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 15.0),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     children: [
                          //       Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           SizedBox(height: 10),
                          //           Container(
                          //             width: 360,
                          //             child: Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.spaceBetween,
                          //               children: [
                          //                 Text(
                          //                   "EVENT GROUP",
                          //                   style: TextStyle(
                          //                       fontSize: 18,
                          //                       color: Color(0xFF000000),
                          //                       fontWeight: FontWeight.w500),
                          //                 ),
                          //                 SizedBox(width: 2),
                          //                 Icon(Icons.arrow_drop_down)
                          //               ],
                          //             ),
                          //           ),
                          //           SizedBox(
                          //             width: 350,
                          //             height: 230,
                          //             child: ListView.builder(
                          //                 itemCount: 3,
                          //                 padding: EdgeInsets.zero,
                          //                 itemBuilder: (context, index) {
                          //                   return CustomListTile(
                          //                     name: 'Anna Furrow',
                          //                     onPressed: () {},
                          //                   );
                          //                 }),
                          //           ),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 15.0),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     children: [
                          //       Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           SizedBox(height: 10),
                          //           Text(
                          //             "SUPERVISOR & MANAGER CHAT",
                          //             style: TextStyle(
                          //                 fontSize: 18,
                          //                 color: Color(0xFF000000),
                          //                 fontWeight: FontWeight.w500),
                          //           ),
                          //           SizedBox(
                          //             width: 350,
                          //             height: 230,
                          //             child: ListView.builder(
                          //                 itemCount: 3,
                          //                 padding: EdgeInsets.zero,
                          //                 itemBuilder: (context, index) {
                          //                   return CustomListTile(
                          //                     name: 'Bryce Bradway',
                          //                     onPressed: () {},
                          //                   );
                          //                 }),
                          //           )
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      );
                    }
                    // else {
                    //   return Center(child: const Text('Empty data'));
                    // }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
