import 'dart:convert';
import 'dart:ui';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pn_204_sam/Auth/chat.dart';
import 'package:pn_204_sam/utilites/images.dart';
import 'package:pn_204_sam/utilites/styles.dart';
import 'package:pn_204_sam/widgets/nav_bar.dart';

class ConversationScreen extends StatefulWidget {
  final String name;
  final String img;
  final String userId;
  final String channelId;

  ConversationScreen({
    Key? key,
    required this.name,
    required this.img,
    required this.channelId,
    required this.userId,
  }) : super(key: key);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  TextEditingController _messageController = TextEditingController();
  late final FirebaseMessaging _firebaseMessaging;
  ScrollController _scrollController = ScrollController();
  bool chat = false;
  late IO.Socket socket;
  getLatestMessage() {
    _scrollController.animateTo(0.0,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var device = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: NavBar(text: "${widget.name}"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: device.height,
          width: device.width,
          // color: Colors.black,
          child: Column(
            children: [
              chat
                  ? SizedBox(
                      height: 120,
                    )
                  : Container(),
              Container(
                height: device.height * .75,
                child: FutureBuilder(
                  future: Chat().messageThreads(
                    "${widget.userId}",
                    "${widget.channelId}",
                  ),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Container(
                            // child: Center(
                            //   child: CircularProgressIndicator(),
                            // ),
                            );
                      default:
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');
                        // ignore: unnecessary_null_comparison
                        else {
                          var data = jsonEncode(snapshot.data);
                          var data1 = jsonDecode(data);
                          return ListView.builder(
                            controller: _scrollController,
                            itemCount: data1.length,
                            itemBuilder: (context, index) {
                              String msg = Bidi.stripHtmlIfNeeded(
                                  "${data1[index]['message']}");
                              // getLatestMessage();
                              // if (data1.length == index + 1) {
                              //   getLatestMessage();
                              //   print("object");
                              // }
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
                                                    // color: Colors.blue,
                                                    border: Border.all(
                                                        color:
                                                            AppColors.appColor),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "$msg",
                                                      style: TextStyle(
                                                          color: Colors.black),
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
                                                  width: 30,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: data1[index]
                                                                ['profile'] !=
                                                            ""
                                                        ? Image.network(
                                                            "${data1[index]['profile']}",
                                                          )
                                                        : Image.asset(
                                                            Images.manager),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "${data1[index]['message_from_user_name']}",
                                                          maxLines: 1,
                                                          overflow:
                                                              TextOverflow.fade,
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          "${data1[index]['date']}",
                                                          maxLines: 1,
                                                          overflow:
                                                              TextOverflow.fade,
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppColors.appColor,
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
                                                                  10),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "$msg",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
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
                        child: Icon(
                          Icons.attach_file,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
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
                        onTap: () {
                          setState(() {
                            chat = true;
                          });
                        },
                      ),
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
                        width: 40,
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
            ],
          ),
        ),
      ),
    );
  }
}
