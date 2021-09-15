import 'package:flutter/material.dart';
import 'package:pn_204_sam/utilites/size_configration.dart';
import 'package:pn_204_sam/utilites/styles.dart';

class RowImageText extends StatelessWidget {
  final String text;
  final String? image;
  bool? img = false;
  bool? loading = true, color = false;
  final Function() onPressed;
  RowImageText(
      {Key? key,
      this.image,
      required this.text,
      required this.onPressed,
      this.img,
      required this.loading,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          height: 9 * SizeConfig.heightMultiplier,
          width: 22 * SizeConfig.heightMultiplier,
          decoration: BoxDecoration(
              color: color != false ? AppColors.appColor : Colors.red,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                    color: AppColors.appColor, blurRadius: 2, spreadRadius: 1)
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              img == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 5),
                        Image.asset(
                          "$image",
                          height: 25,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        loading == false
                            ? Text(
                                text,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )
                            : Container(
                                padding: EdgeInsets.only(left: 20),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                )),
                      ],
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: loading == false
                            ? Text(
                                text,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )
                            : Container(
                                padding: EdgeInsets.only(left: 20),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                )),
                      ),
                    ),
              // Icon(
              //   Icons.navigate_next,
              //   color: Colors.white,
              // )
            ],
          )),
    );
  }
}
