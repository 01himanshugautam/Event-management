import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pn_204_sam/Auth/events.dart';
import 'package:pn_204_sam/Auth/shifts.dart';
import 'package:pn_204_sam/utilites/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> showExitPopup(context, String userId) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Do you want to exit?"),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
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
                              prefs.setBool("start", true);
                              print('yes selected');
                              exit(0);
                            });
                          });
                        },
                        child: Text("Yes"),
                        style: ElevatedButton.styleFrom(
                            primary: AppColors.appColor),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        print('no selected');
                        Navigator.of(context).pop();
                      },
                      child: Text("No", style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        );
      });
}
