import 'package:flutter/material.dart';
import 'package:pn_204_sam/utilites/images.dart';
import 'package:pn_204_sam/utilites/styles.dart';

class CuatomButton extends StatelessWidget {
  final String text;
  final String? image;
  final Function() onPressed;
  Color? backgourndColor;
  Color? textColor;
  double? height;
  double? fontSize;
  double? width;
  bool? img = false;
  bool? loading;
  CuatomButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.image,
      this.backgourndColor,
      this.textColor,
      this.width,
      this.img,
      this.height,
      this.fontSize,
      this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var device = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height ?? 40,
        width: width ?? device.width,
        decoration: BoxDecoration(
          color: backgourndColor ?? AppColors.appColor,
          borderRadius: BorderRadius.circular(30),
          // border: Border.all(
          //   color: AppColors.appColor,
          // ),
        ),
        child: loading == true
            ? Container(
                child: img == true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "$image",
                            height: 25,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            text,
                            style: TextStyle(
                                fontSize: fontSize ?? 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    : Center(
                        child: Text(
                          text,
                          style: TextStyle(
                              fontSize: fontSize ?? 18,
                              color: textColor ?? Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
              )
            : Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
