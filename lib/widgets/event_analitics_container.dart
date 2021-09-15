import 'package:flutter/material.dart';
import 'package:pn_204_sam/utilites/images.dart';

class EventContainer extends StatelessWidget {
  final String text;
  final int today;
  final int total;
  final Color? color;
  EventContainer({
    Key? key,
    required this.today,
    required this.total,
    required this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 15),
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            color: color ?? Colors.pink,
            borderRadius: BorderRadius.circular(10),
            // border: Border.all(color: Colors.black)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 5),
                    child: Container(
                      width: 25,
                      child: Image.asset(
                        Images.notes,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 60,
                            child: Text(
                              "Previous",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            width: 50,
                            child: Text(
                              "Today",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 50,
                            child: Text(
                              "$total",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            width: 50,
                            child: Text(
                              "$today",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        )
        // : Container(
        //     height: 10,
        //     padding:
        //         EdgeInsets.only(left: 25, top: 15, bottom: 15, right: 20),
        //     child: CircularProgressIndicator(),
        //   ),
        );
  }
}
