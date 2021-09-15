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

class EditIncident extends StatefulWidget {
  String? eventId;
  String? incidentId;
  String? incGuardSup;
  String? incGuardMa;
  String? incGeoLocation;
  String? reportedBy;
  String? comment;
  String? incType;
  String? resolvedState;
  String? daysPassed;
  String? incTeamArea;
  EditIncident({
    Key? key,
    this.incGeoLocation,
    this.incGuardMa,
    this.incidentId,
    this.reportedBy,
    this.incGuardSup,
    this.eventId,
    this.comment,
    this.daysPassed,
    this.incTeamArea,
    this.incType,
    this.resolvedState,
  }) : super(key: key);

  @override
  _EditIncidentState createState() => _EditIncidentState();
}

class _EditIncidentState extends State<EditIncident> {
  String _dropDownValue = "SELECT";
  String _resolved = "SELECT";

  String? userId;

  TextEditingController _dayController = TextEditingController();
  TextEditingController _commentController = TextEditingController();
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

  getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString("userId");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    setState(() {
      _dayController.text = "${widget.daysPassed}";
      _commentController.text = "${widget.comment}";
      _resolved = "${widget.resolvedState}";
    });
    print(
        "${widget.eventId} ${widget.comment} ${widget.incType} ${widget.reportedBy} ${widget.resolvedState}  ${widget.daysPassed} ${widget.incTeamArea}  ${widget.incGeoLocation} ${widget.incGuardSup}  ${widget.incGuardMa} ${widget.incTeamArea}");
  }

  @override
  Widget build(BuildContext context) {
    var device = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: NavBar(text: "UPDATE INCIDENT REPORT"),
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
                          Container(
                            height: 5 * SizeConfig.heightMultiplier,
                            width: 43 * SizeConfig.heightMultiplier,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                border: Border.all(
                                  color: AppColors.appColor,
                                )),
                            child: Center(
                              child: Text(
                                "INCIDENT TYPE:            ${widget.incType}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.appColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 5 * SizeConfig.heightMultiplier,
                            width: 43 * SizeConfig.heightMultiplier,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                border: Border.all(
                                  color: AppColors.appColor,
                                )),
                            child: Center(
                              child: Text(
                                "REPORTED BY:               ${widget.reportedBy}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.appColor,
                                ),
                              ),
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
                                  child: TextFormField(
                                    controller: _commentController,
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
                                        fontSize: 18,
                                        color: AppColors.appColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          // SizedBox(
                          //   width: 350,
                          //   // height: 50,
                          //   child: DropdownButton(
                          //     hint: _dropDownValue == null
                          //         ? Text('Dropdown')
                          //         : Text(
                          //             _dropDownValue,
                          //             style: TextStyle(
                          //                 fontSize: 18,
                          //                 color: AppColors.appColor,
                          //                 fontWeight: FontWeight.w500),
                          //           ),
                          //     isExpanded: true,
                          //     iconSize: 30.0,
                          //     style: TextStyle(
                          //       color: AppColors.appColor,
                          //     ),
                          //     items: [
                          //       'Fire Incident',
                          //       'Car Accident',
                          //       'Fight Incident',
                          //       'Missing Incident',
                          //       'Lost Item',
                          //       'Police Onsite Support',
                          //       'Sucpicious Activity Report',
                          //       'Trespassing Report',
                          //       'Vendalism Report',
                          //       'Site Report',
                          //     ].map(
                          //       (val) {
                          //         return DropdownMenuItem<String>(
                          //           value: val,
                          //           child: Text(
                          //             val,
                          //             style: TextStyle(
                          //                 fontSize: 18,
                          //                 color: AppColors.appColor,
                          //                 fontWeight: FontWeight.w500),
                          //           ),
                          //         );
                          //       },
                          //     ).toList(),
                          //     onChanged: (val) {
                          //       setState(() {
                          //         _dropDownValue = "$val";
                          //         incType = "$val";
                          //       });
                          //       print(_dropDownValue);
                          //     },
                          //   ),
                          // ),

                          SizedBox(
                            height: 5,
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
                                          fontSize: 18,
                                          color: AppColors.appColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    isExpanded: true,
                                    iconSize: 30.0,
                                    style: TextStyle(
                                      color: AppColors.appColor,
                                    ),
                                    items: [
                                      'yes',
                                      'no',
                                    ].map(
                                      (val) {
                                        return DropdownMenuItem<String>(
                                          value: val,
                                          child: Text(
                                            val,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: AppColors.appColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        _resolved = "$val";
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
                                      fontSize: 18,
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
                                    controller: _dayController,
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
                                        fontSize: 18,
                                        color: AppColors.appColor,
                                      ),
                                    ),
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
                              height: 60,
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
                            text: 'UPDATE',
                            height: 50,
                            loading: true,
                            width: 43 * SizeConfig.heightMultiplier,
                            onPressed: () {
                              print("Click on SUBMIT");
                              // print(
                              //     "${widget.incGeoLocation} ${widget.incGuardMa} ${widget.incGuardSup}");
                              print(_resolved);
                              if (_resolved != null &&
                                  _dayController.text != "null" &&
                                  _commentController.text != "null") {
                                if (_image != null) {
                                  print(
                                      "${widget.eventId} ${_commentController.text} ${widget.incType} ${userId} $_resolved  ${_dayController.text} ${widget.incTeamArea}  ${widget.incGeoLocation} ${widget.incGuardSup}  ${widget.incGuardMa}");
                                  Incident()
                                      .updateIncidentReport(
                                          "${widget.eventId}",
                                          "${_commentController.text}",
                                          "${widget.incType}",
                                          "$userId",
                                          "$_resolved",
                                          "${_dayController.text}",
                                          "${widget.incTeamArea}",
                                          "${widget.incGeoLocation}",
                                          "${widget.incGuardSup}",
                                          "${widget.incGuardMa}",
                                          "${widget.incidentId}",
                                          "$_image")
                                      .then((data) {
                                    print(data);
                                    var data1 = jsonDecode(data.body);
                                    print(data1);
                                    var message = data1['data']['message'];

                                    CommonFunctions.showSuccessToast(message);
                                    Navigator.pop(context);
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
