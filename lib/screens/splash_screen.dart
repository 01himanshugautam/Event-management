import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:pn_204_sam/main.dart';
import 'package:pn_204_sam/screens/login.dart';
import 'package:pn_204_sam/screens/staff/staff_dashboard.dart';
import 'package:pn_204_sam/utilites/images.dart';
import 'package:pn_204_sam/utilites/styles.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _getLocaitionPremission() async {
    PermissionStatus _permissionGranted;
    _permissionGranted = await Location.instance.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await Location.instance.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  @override
  void initState() {
    _getLocaitionPremission();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => MyApp(),
        ),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var device = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: device.height,
          width: device.width,
          child: Image.asset(
            Images.background,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: device.height,
          width: device.width,
          child: Image.asset(Images.logo),
        ),
      ],
    );
  }
}
