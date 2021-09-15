import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pn_204_sam/utilites/size_configration.dart';

class EventDashboardItem extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final int count;
  final Color color;
  final Color color1;
  EventDashboardItem({
    Key? key,
    required this.text,
    required this.count,
    required this.onPressed,
    required this.color,
    required this.color1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 18 * SizeConfig.heightMultiplier,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          color,
          color1,
        ])),
        child: Column(children: [
          Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 20),
                  height: 11 * SizeConfig.heightMultiplier,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        text,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Center(
                          child: Text(
                            "$count",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: color),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    height: 5 * SizeConfig.heightMultiplier,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text("List View",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: color,
                              )),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: color,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
