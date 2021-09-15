import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pn_204_sam/Auth/auth.dart';
import 'package:pn_204_sam/models/UserPreferences.dart';
import 'package:pn_204_sam/models/app_urls.dart';
import 'package:pn_204_sam/models/common_functions.dart';
import 'package:pn_204_sam/models/user.dart';
import 'package:pn_204_sam/screens/signup.dart';
import 'package:pn_204_sam/screens/staff/staff_dashboard.dart';
import 'package:pn_204_sam/utilites/images.dart';
import 'package:pn_204_sam/utilites/size_configration.dart';
import 'package:pn_204_sam/utilites/styles.dart';
import 'package:pn_204_sam/widgets/container_images_text.dart';
import 'package:pn_204_sam/widgets/custom_buttom.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  int login = 1;
  String? deviceId;
  String? deviceType;
  String? firebseToken;
  TabController? _tabController;
  TextEditingController _emailController = TextEditingController();
  TextEditingController url = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? defaultUrl;
  bool loading = true;

  _getId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        defaultUrl = prefs.getString("def") ?? "Select";
        firebseToken = value;
      });
      print("FirebaseToken $firebseToken");
    });

    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      setState(() {
        deviceId = iosDeviceInfo.identifierForVendor; // unique ID on iOS
        deviceType = "IOS";
      });
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      setState(() {
        deviceId = androidDeviceInfo.androidId; // unique ID on Android
        deviceType = "Android";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getId();
    _tabController = new TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    var device = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: device.height,
          width: device.width,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 54 * SizeConfig.heightMultiplier,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(30)),
                      child: Image.asset(
                        Images.background,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 54 * SizeConfig.heightMultiplier,
                    width: device.width,
                    decoration: BoxDecoration(
                      // color: AppColors.appColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    padding: EdgeInsets.only(top: 100),
                    child: Column(
                      children: [
                        Container(
                          height: 18 * SizeConfig.heightMultiplier,
                          child: Image.asset(Images.logo),
                        ),
                        SizedBox(
                          height: 5 * SizeConfig.heightMultiplier,
                        ),
                        SizedBox(
                          width: 360,
                          height: 9 * SizeConfig.heightMultiplier,
                          child: TabBar(
                            controller: _tabController,
                            indicatorColor: Colors.white,
                            unselectedLabelColor: Colors.white,
                            labelColor: Colors.white,
                            tabs: [
                              Tab(
                                icon: ImageIcon(
                                  AssetImage(Images.manager),
                                  size: 3 * SizeConfig.heightMultiplier,
                                ),
                                text: "MANAGER",
                              ),
                              Tab(
                                icon: ImageIcon(
                                  AssetImage(Images.manager),
                                  size: 3 * SizeConfig.heightMultiplier,
                                ),
                                text: "SUPERVISOR",
                              ),
                              Tab(
                                icon: ImageIcon(
                                  AssetImage(Images.manager),
                                  size: 3 * SizeConfig.heightMultiplier,
                                ),
                                text: "STAFF",
                              ),
                              Tab(
                                icon: ImageIcon(
                                  AssetImage(Images.manager),
                                  size: 3 * SizeConfig.heightMultiplier,
                                ),
                                text: "CLIENT",
                              ),
                            ],
                            onTap: (value) {
                              print("Value ${value + 1}");
                              setState(() {
                                login = value + 1;
                              });
                              // print(login);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2 * SizeConfig.heightMultiplier,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 360,
                        height: 20 * SizeConfig.heightMultiplier,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 8 * SizeConfig.heightMultiplier,
                                  child: TextFormField(
                                    controller: _emailController,
                                    style: TextStyle(
                                      color: AppColors.appColor,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: 2 * SizeConfig.heightMultiplier),
                                      hintText: "Enter Your Email",
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
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                          color: AppColors.appColor,
                                        ),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: AppColors.appColor,
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.appColor,
                                      ),
                                    ),
                                    onSaved: (value) {},
                                  ),
                                ),
                                SizedBox(
                                  height: 2 * SizeConfig.heightMultiplier,
                                ),
                                Container(
                                  height: 8 * SizeConfig.heightMultiplier,
                                  child: TextFormField(
                                    controller: _passwordController,
                                    style: TextStyle(
                                      color: AppColors.appColor,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Enter Your Password",
                                      contentPadding: EdgeInsets.only(
                                          top: 2 * SizeConfig.heightMultiplier),
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
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                          color: AppColors.appColor,
                                        ),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: AppColors.appColor,
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.appColor,
                                      ),
                                    ),
                                    onSaved: (value) {},
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 8 * SizeConfig.heightMultiplier,
                                  child: TextFormField(
                                    controller: _emailController,
                                    style: TextStyle(
                                      color: AppColors.appColor,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: 2 * SizeConfig.heightMultiplier),
                                      hintText: "Enter Your Email",
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
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                          color: AppColors.appColor,
                                        ),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: AppColors.appColor,
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.appColor,
                                      ),
                                    ),
                                    onSaved: (value) {},
                                  ),
                                ),
                                SizedBox(
                                  height: 2 * SizeConfig.heightMultiplier,
                                ),
                                Container(
                                  height: 8 * SizeConfig.heightMultiplier,
                                  child: TextFormField(
                                    controller: _passwordController,
                                    style: TextStyle(
                                      color: AppColors.appColor,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Enter Your Password",
                                      contentPadding: EdgeInsets.only(
                                          top: 2 * SizeConfig.heightMultiplier),
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
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                          color: AppColors.appColor,
                                        ),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: AppColors.appColor,
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.appColor,
                                      ),
                                    ),
                                    onSaved: (value) {},
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 8 * SizeConfig.heightMultiplier,
                                  child: TextFormField(
                                    controller: _emailController,
                                    style: TextStyle(
                                      color: AppColors.appColor,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: 2 * SizeConfig.heightMultiplier),
                                      hintText: "Enter Your Login Id",
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
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                          color: AppColors.appColor,
                                        ),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: AppColors.appColor,
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.appColor,
                                      ),
                                    ),
                                    onSaved: (value) {},
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 8 * SizeConfig.heightMultiplier,
                                  child: TextFormField(
                                    controller: _emailController,
                                    style: TextStyle(
                                      color: AppColors.appColor,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: 2 * SizeConfig.heightMultiplier),
                                      hintText: "Enter Your Email",
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
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                          color: AppColors.appColor,
                                        ),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: AppColors.appColor,
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.appColor,
                                      ),
                                    ),
                                    onSaved: (value) {},
                                  ),
                                ),
                                SizedBox(
                                  height: 2 * SizeConfig.heightMultiplier,
                                ),
                                Container(
                                  height: 8 * SizeConfig.heightMultiplier,
                                  child: TextFormField(
                                    controller: _passwordController,
                                    style: TextStyle(
                                      color: AppColors.appColor,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Enter Your Password",
                                      contentPadding: EdgeInsets.only(
                                          top: 2 * SizeConfig.heightMultiplier),
                                      border: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                          color: AppColors.appColor,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                          color: AppColors.appColor,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                          color: AppColors.appColor,
                                        ),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: AppColors.appColor,
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.appColor,
                                      ),
                                    ),
                                    onSaved: (value) {},
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2 * SizeConfig.heightMultiplier,
                      ),
                      CuatomButton(
                        // backgourndColor: Colors.red,
                        height: 6.5 * SizeConfig.heightMultiplier, fontSize: 22,
                        text: 'Login', loading: loading,
                        onPressed: () async {
                          // print("Click on Login page");
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          setState(() {
                            loading = false;
                          });
                          switch (login) {
                            case 1:
                              {
                                print("User is client");

                                if (_emailController.text.isNotEmpty &&
                                    _passwordController.text.isNotEmpty) {
                                  await Provider.of<Auth>(context,
                                          listen: false)
                                      .loginToken()
                                      .then((value) async {
                                    var response = await Auth().login(
                                      "${_emailController.text}",
                                      "${_passwordController.text}",
                                      // "mflutter@comp.com",
                                      // "nsEhuMKusEhu2jj3j3221",
                                      "$deviceId",
                                      "$deviceType",
                                      "$firebseToken",
                                    );
                                    if (response.data['message'] ==
                                        "You are Already logged from another mobile, Please inform your Supervisor") {
                                      print(
                                          "Response: ${response.data['message']}");
                                      CommonFunctions.showErrorDialog(
                                          "Login Failed",
                                          response.data['message'],
                                          context);
                                    } else if (response.data['data'] == null) {
                                      CommonFunctions.showErrorDialog(
                                          "Login Failed",
                                          response.data['message'],
                                          context);
                                    } else {
                                      print(response.data['data']);
                                      Map<String, dynamic> data =
                                          response.data['data'];
                                      print(data);
                                      User authUser = User.fromJson(data);
                                      UserPreferences().saveUser(authUser);

                                      UserPreferences()
                                          .saveRoleId("${data['role_id']}");
                                      String? token = prefs.getString("token");

                                      if (data['role_id'] != null) {
                                        setState(() {
                                          loading = true;
                                        });
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Signup(
                                              userId: "${data['user_id']}",
                                              token: "$token",
                                              roleId: "${data['role_id']}",
                                              name: "${data['user_name']}",
                                            ),
                                          ),
                                        );
                                        UserPreferences().removeToken();
                                        UserPreferences().removeRoleId();
                                      } else {
                                        print("Token Null : $token");
                                        print(
                                            "Role Id Null : $data['role_id']");
                                        UserPreferences().removeToken();
                                      }
                                    }
                                  });
                                } else {
                                  setState(() {
                                    loading = true;
                                  });
                                  var errorMsg = 'Please fill your details';
                                  CommonFunctions.showErrorDialog(
                                      "Login Failed", errorMsg, context);
                                }
                              }
                              break;

                            case 3:
                              {
                                print("User is staff");
                                if (_emailController.text.isNotEmpty) {
                                  await Provider.of<Auth>(context,
                                          listen: false)
                                      .loginToken()
                                      .then((value) async {
                                    var response = await Auth().staffLogin(
                                      "${_emailController.text}",
                                      "$deviceId",
                                      "$deviceType",
                                      "$firebseToken",
                                    );

                                    setState(() {
                                      loading = true;
                                    });
                                    print(response);
                                    if (response.data['message'] ==
                                        "You are Already logged from another mobile, Please inform your Supervisor") {
                                      print(
                                          "Response: ${response.data['message']}");
                                      CommonFunctions.showErrorDialog(
                                          "Login Failed",
                                          response.data['message'],
                                          context);
                                    }
                                    // if (response.data['message']
                                    //         .toString()
                                    //         .substring(0, 14) ==
                                    //     "The login code") {
                                    //   var errorMsg =
                                    //       'Please Enter currect login Code';
                                    //   CommonFunctions.showErrorDialog(
                                    //       "Login Failed", errorMsg, context);
                                    //   print(response);
                                    // }
                                    else {
                                      Map<String, dynamic> data =
                                          response.data['data'];
                                      print(data);
                                      User authUser = User.fromJson(data);
                                      UserPreferences().saveUser(authUser);

                                      UserPreferences()
                                          .saveRoleId("${data['role_id']}");
                                      String? token = prefs.getString("token");

                                      if (data['role_id'] != null) {
                                        setState(() {
                                          loading = true;
                                        });
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Signup(
                                              userId: "${data['user_id']}",
                                              token: "$token",
                                              roleId: "${data['role_id']}",
                                              name: "${data['user_name']}",
                                            ),
                                          ),
                                        );
                                        UserPreferences().removeToken();
                                        UserPreferences().removeRoleId();
                                      } else {
                                        setState(() {
                                          loading = true;
                                        });
                                        print("Token Null : $token");
                                        print(
                                            "Role Id Null : $data['role_id']");
                                        UserPreferences().removeToken();
                                      }
                                    }
                                  });
                                } else {
                                  setState(() {
                                    loading = true;
                                  });
                                  var errorMsg = 'Please fill your details';
                                  CommonFunctions.showErrorDialog(
                                      "Login Failed", errorMsg, context);
                                }
                                // UserPreferences().removeToken();
                              }
                              break;
                            case 2:
                              {
                                print("User is supervisor");

                                if (_emailController.text.isNotEmpty &&
                                    _passwordController.text.isNotEmpty) {
                                  await Provider.of<Auth>(context,
                                          listen: false)
                                      .loginToken()
                                      .then((value) async {
                                    var response = await Auth().login(
                                      "${_emailController.text}",
                                      "${_passwordController.text}",
                                      // "mflutter@comp.com",
                                      // "nsEhuMKusEhu2jj3j3221",
                                      "$deviceId",
                                      "$deviceType",
                                      "$firebseToken",
                                    );
                                    if (response.data['message'] ==
                                        "You are Already logged from another mobile, Please inform your Supervisor") {
                                      print(
                                          "Response: ${response.data['message']}");
                                      CommonFunctions.showErrorDialog(
                                          "Login Failed",
                                          response.data['message'],
                                          context);
                                    } else {
                                      Map<String, dynamic> data =
                                          response.data['data'];
                                      print(data);
                                      User authUser = User.fromJson(data);
                                      UserPreferences().saveUser(authUser);

                                      UserPreferences()
                                          .saveRoleId("${data['role_id']}");
                                      String? token = prefs.getString("token");

                                      if (data['role_id'] != null) {
                                        setState(() {
                                          loading = true;
                                        });
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Signup(
                                              userId: "${data['user_id']}",
                                              token: "$token",
                                              roleId: "${data['role_id']}",
                                              name: "${data['user_name']}",
                                            ),
                                          ),
                                        );
                                        UserPreferences().removeToken();
                                        UserPreferences().removeRoleId();
                                      } else {
                                        setState(() {
                                          loading = true;
                                        });
                                        print("Token Null : $token");
                                        print(
                                            "Role Id Null : $data['role_id']");
                                        UserPreferences().removeToken();
                                      }
                                    }
                                  });
                                } else {
                                  setState(() {
                                    loading = true;
                                  });
                                  var errorMsg = 'Please fill your details';
                                  CommonFunctions.showErrorDialog(
                                      "Login Failed", errorMsg, context);
                                }
                              }
                              break;
                            case 4:
                              {
                                print("User is manager");

                                if (_emailController.text.isNotEmpty &&
                                    _passwordController.text.isNotEmpty) {
                                  await Provider.of<Auth>(context,
                                          listen: false)
                                      .loginToken()
                                      .then((value) async {
                                    var response = await Auth().login(
                                      "${_emailController.text}",
                                      "${_passwordController.text}",
                                      // "mflutter@comp.com",
                                      // "nsEhuMKusEhu2jj3j3221",
                                      "$deviceId",
                                      "$deviceType",
                                      "$firebseToken",
                                    );
                                    if (response.data['message'] ==
                                        "You are Already logged from another mobile, Please inform your Supervisor") {
                                      print(
                                          "Response: ${response.data['message']}");
                                      CommonFunctions.showErrorDialog(
                                          "Login Failed",
                                          response.data['message'],
                                          context);
                                    } else {
                                      Map<String, dynamic> data =
                                          response.data['data'];
                                      print(data);
                                      User authUser = User.fromJson(data);
                                      UserPreferences().saveUser(authUser);

                                      UserPreferences()
                                          .saveRoleId("${data['role_id']}");
                                      String? token = prefs.getString("token");

                                      if (data['role_id'] != null) {
                                        setState(() {
                                          loading = true;
                                        });
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Signup(
                                              userId: "${data['user_id']}",
                                              token: "$token",
                                              roleId: "${data['role_id']}",
                                              name: "${data['user_name']}",
                                            ),
                                          ),
                                        );
                                        UserPreferences().removeToken();
                                        UserPreferences().removeRoleId();
                                      } else {
                                        setState(() {
                                          loading = true;
                                        });
                                        print("Token Null : $token");
                                        print(
                                            "Role Id Null : $data['role_id']");
                                        UserPreferences().removeToken();
                                      }
                                    }
                                  });
                                } else {
                                  setState(() {
                                    loading = true;
                                  });
                                  var errorMsg = 'Please fill your details';
                                  CommonFunctions.showErrorDialog(
                                      "Login Failed", errorMsg, context);
                                }
                              }
                              break;
                          }
                        },
                      ),
                      SizedBox(
                        height: 3 * SizeConfig.heightMultiplier,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext ctx) {
                                    return AlertDialog(
                                        content: Stack(children: [
                                      Container(
                                        height: 100,
                                        // decoration: BoxDecoration(boxShadow: [
                                        //   BoxShadow(color: AppColors.appColor)
                                        // ]),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    "Select your server url ",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color:
                                                            AppColors.appColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(height: 15),
                                                  SizedBox(
                                                    width: 180,
                                                    height: 50,
                                                    child: DropdownButton(
                                                      hint: Text(
                                                        "$defaultUrl",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: AppColors
                                                                .appColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      isExpanded: true,
                                                      iconSize: 30.0,
                                                      style: TextStyle(
                                                        color:
                                                            AppColors.appColor,
                                                      ),
                                                      items: [
                                                        'Default Url',
                                                        'Custom Url',
                                                      ].map(
                                                        (val) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: val,
                                                            child: Text(
                                                              val,
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: AppColors
                                                                      .appColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          );
                                                        },
                                                      ).toList(),
                                                      onChanged: (val) async {
                                                        setState(() {
                                                          defaultUrl = "$val";
                                                        });
                                                        if (val !=
                                                            "Default Url") {
                                                          Navigator.pop(ctx);
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    ctx) {
                                                              return AlertDialog(
                                                                content: Stack(
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          100,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          Column(
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: 250,
                                                                                  child: TextField(
                                                                                    controller: url,
                                                                                    style: TextStyle(
                                                                                      color: AppColors.appColor,
                                                                                    ),
                                                                                    decoration: InputDecoration(
                                                                                      contentPadding: EdgeInsets.only(top: 2 * SizeConfig.heightMultiplier, left: 2 * SizeConfig.heightMultiplier),
                                                                                      hintText: "Enter your server url",
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
                                                                                      focusedBorder: OutlineInputBorder(
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
                                                                                ElevatedButton(
                                                                                  onPressed: () async {
                                                                                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                                    prefs.setString("baseUrl", "${url.text}");
                                                                                    prefs.setString("def", "Custom Url");
                                                                                    Navigator.pop(ctx);
                                                                                  },
                                                                                  child: Text("Ok"),
                                                                                )
                                                                              ])
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        } else {
                                                          final SharedPreferences
                                                              prefs =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          prefs.setString("def",
                                                              "Default Url");

                                                          prefs.setString(
                                                              "baseUrl",
                                                              "http://g6ca9akm8spg3fs7m2n4j3l.dyn-o-saur.com:8078/");
                                                          Navigator.pop(ctx);
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ]),
                                      )
                                    ]));
                                  });
                            },
                            child: Container(
                              height: 5 * SizeConfig.heightMultiplier,
                              child: Text("Select Server url"),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2 * SizeConfig.heightMultiplier,
                      ),
                      Text(
                        "2021 Copyright Control E",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
// p1f231VW
