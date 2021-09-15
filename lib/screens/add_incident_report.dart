import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pn_204_sam/Auth/incident.dart';
import 'package:pn_204_sam/models/common_functions.dart';
import 'package:pn_204_sam/utilites/images.dart';
import 'package:pn_204_sam/utilites/size_configration.dart';
import 'package:pn_204_sam/utilites/styles.dart';
import 'package:pn_204_sam/widgets/custom_buttom.dart';
import 'package:pn_204_sam/widgets/nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddIncidentReport extends StatefulWidget {
  String eventId;
  String incGuardSup;
  String incGuardMa;
  List incGeoLocation;
  String reportedBy;
  AddIncidentReport({
    Key? key,
    required this.incGeoLocation,
    required this.incGuardMa,
    required this.reportedBy,
    required this.incGuardSup,
    required this.eventId,
  }) : super(key: key);

  @override
  _AddIncidentReportState createState() => _AddIncidentReportState();
}

class _AddIncidentReportState extends State<AddIncidentReport> {
  String _dropDownValue = "SELECT";
  String _resolved = "SELECT";

  String? comment;
  String? incType;
  String? resolvedState;
  String? daysPassed = "10";
  String? incTeamArea = "10";

  var _image;

  _imgFromGallery() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(image!.path);
    });
    print(_image);
  }

  _imgFromCamera() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
    print(_image);
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      print(_image);
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    print(_image);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
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
        child: NavBar(text: "ADD INCIDENT"),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "SELECT INCIDENT TYPE",
                            style: TextStyle(
                                fontSize: 16,
                                color: AppColors.appColor,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 43 * SizeConfig.heightMultiplier,
                            // height: 50,
                            child: DropdownButton(
                              hint: _dropDownValue == null
                                  ? Text('Dropdown')
                                  : Text(
                                      _dropDownValue,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.appColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                              isExpanded: true,
                              iconSize: 30.0,
                              style: TextStyle(
                                color: AppColors.appColor,
                              ),
                              items: [
                                'Fire Incident',
                                'Car Accident',
                                'Fight Incident',
                                'Missing Incident',
                                'Lost Item',
                                'Police Onsite Support',
                                'Sucpicious Activity Report',
                                'Trespassing Report',
                                'Vendalism Report',
                                'Site Report',
                              ].map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(
                                      val,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.appColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                setState(() {
                                  _dropDownValue = "$val";
                                  incType = "$val";
                                });
                                print(_dropDownValue);
                              },
                            ),
                          ),

                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "DESCRIPTION",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.appColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: 43 * SizeConfig.heightMultiplier,
                                  // height: 50,
                                  child: TextFormField(
                                    style: TextStyle(
                                      color: AppColors.appColor,
                                    ),
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                      hintText: "Description Here",
                                      border: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                          color: AppColors.appColor,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                          color: AppColors.appColor,
                                        ),
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.appColor,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        comment = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Container(
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text(
                          //         "REPORTED BY",
                          //         style: TextStyle(
                          //             fontSize: 18,
                          //             color: AppColors.appColor,
                          //             fontWeight: FontWeight.bold),
                          //       ),
                          //       SizedBox(
                          //         height: 5,
                          //       ),
                          //       SizedBox(
                          //         width: 350,
                          //         height: 50,
                          //         child: TextFormField(
                          //           style: TextStyle(
                          //             color: AppColors.appColor,
                          //           ),
                          //           decoration: InputDecoration(
                          //             hintText: "Resported By",
                          //             border: new OutlineInputBorder(
                          //               borderSide: new BorderSide(
                          //                 color: AppColors.appColor,
                          //               ),
                          //             ),
                          //             enabledBorder: OutlineInputBorder(
                          //               borderSide: new BorderSide(
                          //                 color: AppColors.appColor,
                          //               ),
                          //             ),
                          //             hintStyle: TextStyle(
                          //               fontSize: 18,
                          //               color: AppColors.appColor,
                          //             ),
                          //           ),
                          //           onChanged: (value) {
                          //             setState(() {
                          //               reportedBy = value;
                          //             });
                          //           },
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "RESOLVED STATE",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.appColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: 43 * SizeConfig.heightMultiplier,
                                  // height: 50,
                                  child: DropdownButton(
                                    hint: Text(
                                      _resolved,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.appColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    isExpanded: true,
                                    iconSize: 30.0,
                                    style: TextStyle(
                                      color: AppColors.appColor,
                                    ),
                                    items: [
                                      'Yes',
                                      'No',
                                    ].map(
                                      (val) {
                                        return DropdownMenuItem<String>(
                                          value: val,
                                          child: Text(
                                            val,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: AppColors.appColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        _resolved = "$val";
                                        resolvedState = "$val";
                                      });
                                      print(_resolved);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "DAYS PASSED",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.appColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: 43 * SizeConfig.heightMultiplier,
                                  height: 50,
                                  child: TextFormField(
                                    style: TextStyle(
                                      color: AppColors.appColor,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Day Passed",
                                      border: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                          color: AppColors.appColor,
                                        ),
                                      ),
                                      // enabled: false,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                          color: AppColors.appColor,
                                        ),
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.appColor,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        daysPassed = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              _showPicker(context);
                            },
                            child: Container(
                              height: 40,
                              width: 43 * SizeConfig.heightMultiplier,
                              decoration: BoxDecoration(
                                color: AppColors.appColor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset(
                                      Images.upload,
                                      fit: BoxFit.cover,
                                      color: Colors.white,
                                    ),
                                  ),
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
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          CuatomButton(
                            text: 'SUBMIT',
                            height: 50,
                            width: 43 * SizeConfig.heightMultiplier,
                            loading: true,
                            onPressed: () {
                              print("Click on SUBMIT");
                              // print(
                              //     "${widget.incGeoLocation} ${widget.incGuardMa} ${widget.incGuardSup}");

                              if (incType != null &&
                                  resolvedState != null &&
                                  daysPassed != null &&
                                  comment != null) {
                                if (_image != null) {
                                  // print(
                                  //     "${widget.eventId} $comment $incType ${widget.reportedBy} $resolvedState  $daysPassed $incTeamArea  ${widget.incGeoLocation} ${widget.incGuardSup}  ${widget.incGuardMa}");
                                  Incident()
                                      .createIncidentReport(
                                          "${widget.eventId}",
                                          "$comment",
                                          "$incType",
                                          "${widget.reportedBy}",
                                          "$resolvedState",
                                          "$daysPassed",
                                          "$incTeamArea",
                                          "${widget.incGeoLocation}",
                                          "${widget.incGuardSup}",
                                          "${widget.incGuardMa}",
                                          "$_image")
                                      .then((data) {
                                    var data1 = jsonDecode(data.body);
                                    print(data1['data']['message']);
                                    var message = data1['data']['message'];

                                    CommonFunctions.showSuccessToast(message);
                                    Navigator.pop(context);
                                  });
                                } else {
                                  var errorMsg = 'Please Upload photo';
                                  CommonFunctions.showErrorDialog(
                                      "Submit Failed", errorMsg, context);
                                }
                              } else {
                                var errorMsg = 'Please fill all details';
                                CommonFunctions.showErrorDialog(
                                    "Submit Failed", errorMsg, context);
                              }
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
