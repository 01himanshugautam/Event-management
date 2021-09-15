import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pn_204_sam/Auth/chat.dart';
import 'package:pn_204_sam/utilites/images.dart';
import 'package:pn_204_sam/utilites/size_configration.dart';
import 'package:pn_204_sam/utilites/styles.dart';

class EventConversationScreen extends StatefulWidget {
  final String name;
  final String img;
  final String userId;
  final String channelId;
  final String eventId;

  EventConversationScreen({
    Key? key,
    required this.name,
    required this.img,
    required this.channelId,
    required this.userId,
    required this.eventId,
  }) : super(key: key);

  @override
  _EventConversationScreenState createState() =>
      _EventConversationScreenState();
}

class _EventConversationScreenState extends State<EventConversationScreen> {
  TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var device = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Container(
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
                  width: 50,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, left: 15),
                  child: Text(
                    "${widget.name}",
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
      ),
      body: SingleChildScrollView(
        child: Container(
          height: device.height,
          width: device.width,
          // color: Colors.black,
          child: Column(
            children: [
              Container(
                height: 72 * SizeConfig.heightMultiplier,
                child: FutureBuilder(
                  future: Chat().eventMessageThreads("${widget.userId}",
                      "${widget.channelId}", "${widget.eventId}"),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Container(
                            child: Center(child: CircularProgressIndicator()));
                      default:
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');
                        // ignore: unnecessary_null_comparison
                        else {
                          var data = jsonEncode(snapshot.data);
                          var data1 = jsonDecode(data);
                          return ListView.builder(
                            itemCount: data1.length,
                            itemBuilder: (context, index) {
                              String msg = Bidi.stripHtmlIfNeeded(
                                  "${data1[index]['message']}");
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Container(
                                  width: 350,
                                  child:
                                      "${data1[index]['message_from_user_id']}" ==
                                              "${widget.userId}"
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10)),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "$msg",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10)),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "$msg",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                ),
                              );
                            },
                          );
                        }
                    }
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            50,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          child: Image.asset(
                            Images.emoji,
                            // color: Colors.black,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        // color: Colors.blueAccent,
                        height: 45,
                        width: 250,
                        child: Expanded(
                          child: TextField(
                            controller: _messageController,
                            decoration: InputDecoration(
                              filled: true,
                              hintText: "Enter message",
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(
                                  15,
                                ),
                              ),
                              contentPadding: EdgeInsets.only(top: 5, left: 15),
                              labelStyle:
                                  TextStyle(fontSize: 18, color: Colors.black),
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black.withOpacity(.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(
                                  15,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(
                                  15,
                                ),
                              ),
                              // suffixIcon: IconButton(
                              //     onPressed: () {},
                              //     icon: Icon(Icons.attach_file)),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          print(_messageController.text);
                          Chat()
                              .sendMessage(
                                  "${widget.userId}",
                                  "${widget.channelId}",
                                  "${_messageController.text}")
                              .then((value) {
                            print("Message Send");
                          });
                          setState(() {
                            _messageController.text = "";
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 5,
                            ),
                            child: Image.asset(
                              Images.send,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
