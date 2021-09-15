import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pn_204_sam/utilites/size_configration.dart';
import 'dart:math';

class CustomListTile extends StatelessWidget {
  final String name;
  final String? image;
  final String description;
  final String time;
  final Function() onPressed;
  CustomListTile({
    Key? key,
    required this.name,
    required this.onPressed,
    required this.description,
    required this.time,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: 40 * SizeConfig.heightMultiplier,
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
                    radius: 25,
                  ),
                  SizedBox(width: 10),
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 20 * SizeConfig.heightMultiplier,
                            child: Text(
                              name,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 1 * SizeConfig.heightMultiplier,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "$time".substring(10, 16),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF6B6B6B),
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: 2),
                              Icon(Icons.navigate_next)
                            ],
                          ),
                        ],
                      ),
                      Text(
                        "$description",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6B6B6B),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 5),
              Container(
                width: 43 * SizeConfig.heightMultiplier,
                height: 1,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
