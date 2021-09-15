import 'package:flutter/material.dart';
import 'package:pn_204_sam/utilites/images.dart';
import 'package:pn_204_sam/utilites/styles.dart';
import 'package:pn_204_sam/widgets/custom_buttom.dart';
import 'package:pn_204_sam/widgets/nav_bar.dart';

class FeedBack extends StatelessWidget {
  FeedBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var device = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: NavBar(text: "FEEDBACK"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "WRITE YOUR REVIEW",
                            style: TextStyle(
                                fontSize: 18,
                                color: AppColors.appColor,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.grey,
                                size: 40,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.grey,
                                size: 40,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.grey,
                                size: 40,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.grey,
                                size: 40,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.grey,
                                size: 40,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: SizedBox(
                              width: 350,
                              // height: 50,
                              child: TextField(
                                style: TextStyle(
                                  color: Color(0xFF7E7E7E),
                                ),
                                maxLines: 6,
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText:
                                      "SHARE DETAILS OF YOUR OWN EXPERIENCE",
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                        color: Color(0xFF7E7E7E),
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: new BorderSide(
                                        color: Color(0xFF7E7E7E),
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                  hintStyle: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF7E7E7E),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 150,
                            width: 170,
                            decoration: BoxDecoration(
                                color: Color(0xFF9AA3AF),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset(
                                      Images.logo,
                                      fit: BoxFit.cover,
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "UPLOAD PHOTO",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          CuatomButton(
                            text: 'POST',
                            height: 60,
                            width: 150,
                            onPressed: () {
                              print("Click on POST");
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
