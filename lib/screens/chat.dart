// import 'dart:async';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:dash_chat/dash_chat.dart';
// import 'package:flutter/material.dart';
// import 'package:pn_204_sam/Auth/chat.dart';
// import 'package:socket_io_client/socket_io_client.dart';

// class ChatS extends StatefulWidget {
//   final String userId;
//   final String channelId;
//   ChatS({
//     Key? key,
//     required this.channelId,
//     required this.userId,
//   }) : super(key: key);

//   @override
//   State<ChatS> createState() => _ChatSState();
// }

// // STEP1:  Stream setup
// class StreamSocket {
//   final _socketResponse = StreamController<String>();

//   void Function(String) get addResponse => _socketResponse.sink.add;

//   Stream<String> get getResponse => _socketResponse.stream;

//   void dispose() {
//     _socketResponse.close();
//   }
// }

// StreamSocket streamSocket = StreamSocket();

// //STEP2: Add this function in main function in main.dart file and add incoming data to the stream
// void connectAndListen() {
//   IO.Socket socket = IO.io('http://localhost:3000',
//       OptionBuilder().setTransports(['websocket']).build());

//   socket.onConnect((_) {
//     print('connect');
//     socket.emit('msg', 'test');
//   });

//   //When an event recieved from server, data is added to the stream
//   socket.on('event', (data) => streamSocket.addResponse);
//   socket.onDisconnect((_) => print('disconnect'));
// }

// class _ChatSState extends State<ChatS> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//           stream: null,
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return Center(
//                 child: CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>(
//                     Theme.of(context).primaryColor,
//                   ),
//                 ),
//               );
//             } else {
//               return DashChat(
//                 key: _chatViewKey,
//                 inverted: false,
//                 onSend: onSend,
//                 sendOnEnter: true,
//                 textInputAction: TextInputAction.send,
//                 user: user,
//                 inputDecoration:
//                     InputDecoration.collapsed(hintText: "Add message here..."),
//                 dateFormat: DateFormat('yyyy-MMM-dd'),
//                 timeFormat: DateFormat('HH:mm'),
//                 messages: messages,
//                 showUserAvatar: false,
//                 showAvatarForEveryMessage: false,
//                 scrollToBottom: false,
//                 onPressAvatar: (ChatUser user) {
//                   print("OnPressAvatar: ${user.name}");
//                 },
//                 onLongPressAvatar: (ChatUser user) {
//                   print("OnLongPressAvatar: ${user.name}");
//                 },
//                 inputMaxLines: 5,
//                 messageContainerPadding: EdgeInsets.only(left: 5.0, right: 5.0),
//                 alwaysShowSend: true,
//                 inputTextStyle: TextStyle(fontSize: 16.0),
//                 inputContainerStyle: BoxDecoration(
//                   border: Border.all(width: 0.0),
//                   color: Colors.white,
//                 ),
//                 onQuickReply: (Reply reply) {
//                   setState(() {
//                     messages.add(ChatMessage(
//                         text: reply.value,
//                         createdAt: DateTime.now(),
//                         user: user));

//                     messages = [...messages];
//                   });

//                   Timer(Duration(milliseconds: 300), () {
//                     _chatViewKey.currentState!.scrollController
//                       ..animateTo(
//                         _chatViewKey.currentState!.scrollController.position
//                             .maxScrollExtent,
//                         curve: Curves.easeOut,
//                         duration: const Duration(milliseconds: 300),
//                       );

//                     if (i == 0) {
//                       systemMessage();
//                       Timer(Duration(milliseconds: 600), () {
//                         systemMessage();
//                       });
//                     } else {
//                       systemMessage();
//                     }
//                   });
//                 },
//                 onLoadEarlier: () {
//                   print("laoding...");
//                 },
//                 shouldShowLoadEarlier: false,
//                 showTraillingBeforeSend: true,
//               );
//             }
//           }),
//     );
//   }
// }
