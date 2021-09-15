import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pn_204_sam/Auth/auth.dart';
import 'package:pn_204_sam/main.dart';
import 'package:pn_204_sam/models/UserPreferences.dart';
import 'package:pn_204_sam/models/common_functions.dart';
import 'package:pn_204_sam/utilites/images.dart';
import 'package:pn_204_sam/utilites/size_configration.dart';
import 'package:pn_204_sam/utilites/styles.dart';
import 'package:pn_204_sam/widgets/custom_buttom.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class Signup extends StatefulWidget {
  final String token;
  final String roleId;
  final String userId;
  final String name;
  // final String location;
  // final String position;
  Signup({
    Key? key,
    required this.token,
    required this.roleId,
    required this.userId,
    required this.name,
    // required this.age,
    // required this.location,
    // required this.nationality,
    // required this.position,
  }) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _nameController = TextEditingController();

  var _image;
  bool loading = true;

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
    _nameController.text = widget.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var device = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 15 * SizeConfig.heightMultiplier,
                width: device.width,
                decoration: BoxDecoration(
                  color: AppColors.appColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
              ),
              SizedBox(
                height: 2 * SizeConfig.heightMultiplier,
              ),
              Container(
                width: 43 * SizeConfig.heightMultiplier,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "FULL NAME",
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
                                  height: 6 * SizeConfig.heightMultiplier,
                                  child: TextFormField(
                                    controller: _nameController,
                                    style: TextStyle(
                                      color: Color(0xFF656666),
                                    ),
                                    enabled: false,
                                    decoration: InputDecoration(
                                      hintText: "Your name here",
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
                                        color: Color(0xFF656666),
                                      ),
                                    ),
                                    onSaved: (value) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "NATIONALITY",
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
                                  height: 6 * SizeConfig.heightMultiplier,
                                  child: TextFormField(
                                    style: TextStyle(
                                      color: Color(0xFF656666),
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Nationality here",
                                      border: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                          color: AppColors.appColor,
                                        ),
                                      ),
                                      enabled: false,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                          color: AppColors.appColor,
                                        ),
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xFF656666),
                                      ),
                                    ),
                                    onSaved: (value) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "AGE",
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
                                  height: 6 * SizeConfig.heightMultiplier,
                                  child: TextFormField(
                                    style: TextStyle(
                                      color: Color(0xFF656666),
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Your age here",
                                      border: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                          color: AppColors.appColor,
                                        ),
                                      ),
                                      enabled: false,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                          color: AppColors.appColor,
                                        ),
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xFF656666),
                                      ),
                                    ),
                                    onSaved: (value) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "LOCATION",
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
                                  height: 6 * SizeConfig.heightMultiplier,
                                  child: TextFormField(
                                    style: TextStyle(
                                      color: Color(0xFF656666),
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Your location here",
                                      border: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                          color: AppColors.appColor,
                                        ),
                                      ),
                                      enabled: false,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                          color: AppColors.appColor,
                                        ),
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xFF656666),
                                      ),
                                    ),
                                    onSaved: (value) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "POSITION",
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
                                  height: 6 * SizeConfig.heightMultiplier,
                                  child: TextFormField(
                                    style: TextStyle(
                                      color: Color(0xFF656666),
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Your position here",
                                      border: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                          color: AppColors.appColor,
                                        ),
                                      ),
                                      enabled: false,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                          color: AppColors.appColor,
                                        ),
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xFF656666),
                                      ),
                                    ),
                                    onSaved: (value) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2 * SizeConfig.heightMultiplier,
                          ),
                          CuatomButton(
                            text: 'UPLOAD PHOTO',
                            image: Images.upload,
                            loading: true,
                            img: true,
                            width: 43 * SizeConfig.heightMultiplier,
                            height: 6.5 * SizeConfig.heightMultiplier,
                            onPressed: () {
                              _showPicker(context);
                              print("Click on UPLOAD PHOTO");
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CuatomButton(
                            text: 'Save',
                            loading: loading,
                            width: 43 * SizeConfig.heightMultiplier,
                            height: 6.5 * SizeConfig.heightMultiplier,
                            backgourndColor: Colors.white,
                            textColor: AppColors.appColor,
                            onPressed: () async {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              print("Click on Save");
                              if (_image != null) {
                                setState(() {
                                  loading = false;
                                });
                                Auth()
                                    .uploadPhoto(widget.userId, "$_image",
                                        "${widget.token}")
                                    .then((value) {
                                  if (widget.token == null &&
                                      widget.roleId == null) {
                                    print("${widget.token} \n${widget.roleId}");
                                  } else {
                                    prefs.setBool("start", true);
                                    prefs.setBool("startBreak", true);
                                    UserPreferences()
                                        .saveToken("${widget.token}");
                                    UserPreferences()
                                        .saveRoleId("${widget.roleId}");
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyApp()));
                                    CommonFunctions.showSuccessToast(
                                        'User logged in successfully');
                                    print("token ${widget.token}");
                                  }
                                });
                                setState(() {
                                  loading = true;
                                });
                              } else {
                                setState(() {
                                  loading = true;
                                });
                                var errorMsg = 'Please Upload a photo';
                                CommonFunctions.showErrorDialog(
                                    "Error", errorMsg, context);
                              }
                              // print("Null $_image");
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
