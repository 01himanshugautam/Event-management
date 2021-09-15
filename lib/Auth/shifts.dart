import 'dart:async';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:pn_204_sam/models/app_urls.dart';
import 'package:http/http.dart' as http;
import 'package:pn_204_sam/models/team_detail.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Shifts with ChangeNotifier {
  Shifts();
  var dio = Dio();
  var cookieJar = CookieJar();
  bool _isStartShift = false;
  LocationData? currentPosition;
  LocationData? mycurrentPosition;
  double? distanceInMeters;
  Stopwatch stopwatch = Stopwatch();

  get isStartShift => _isStartShift;
  set IsStartShift(val) {
    _isStartShift = val;
    notifyListeners();
  }

  bool isStartBreak = false;
  TeamDetail? _teamData;

  TeamDetail? get teamData => _teamData;

  set teamData(TeamDetail? val) {
    _teamData = val;
    notifyListeners();
  }

  Future<List> startShiftvalidator(int event_id, int user_id) async {
    try {
      print("// Get Team Location");
      await getTeamLocation(event_id, user_id);
      if (teamData != null) {
        return [false, "Data is Null"];
      }

      print("get my Location");
      await getMyLocation();
      print("within range of location (true , false)");
      await checkRange(
          double.parse(teamData!.latitude!),
          double.parse(teamData!.latitude!),
          mycurrentPosition!.latitude!,
          mycurrentPosition!.longitude!);
      print("// with time range");
      await checkTimeRange(DateTime.parse(teamData!.startTime!),
          DateTime.parse(teamData!.endTime!));
      print("// API start shift");
      // await start();
      stopwatch.start();

      // startTarking()
      await startTracking();

      if (distanceInMeters! > teamData!.radius!) {
        await endShift("$event_id", "$user_id");
      }
      IsStartShift = true;
      return [true, "Shift Started Sucessfull"];
    } catch (e) {
      // return [false, "$e"];
      print(e);
      throw (e);
    }
  }

  endShiftvalidator() {}

  getTeamLocation(int event_id, int user_id) async {
    await teamDetail(event_id, user_id);
  }

  Future<LocationData?> getMyLocation() async {
    try {
      mycurrentPosition = await Location.instance.getLocation();
      print("SucessFully Get Location");
    } catch (e) {
      print(e);
    }
    return mycurrentPosition;
  }

  Future<bool> checkRange(
      double startLat, double startLong, double endLat, double endLong) async {
    distanceInMeters =
        await Geolocator.distanceBetween(startLat, startLong, endLat, endLong);
    return teamData?.radius != null
        ? (distanceInMeters! < teamData!.radius!)
        : false;
  }

  Future<bool> checkTimeRange(
      DateTime startDateTime, DateTime endDateTime) async {
    DateTime currentDate = new DateTime.now();
    return startDateTime.isBefore(currentDate) &&
        endDateTime.isAfter(currentDate);
  }

  startTracking() async {
    LocationData _currentPosition;
    Location.instance.onLocationChanged.listen((LocationData currentLocation) {
      print("${currentLocation.longitude} : ${currentLocation.latitude}");
      _currentPosition = currentLocation;
    });
  }

  Future start(String eventId, String userId, String lat, String long,
      String teamId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? _token = prefs.getString("token");
    String _url =
        "${AppUrl.baseURL}event/start-shift?event_id=$eventId&user_id=$userId&latitude=$lat&longitude=$long&team_id=$teamId";
    Response response;
    try {
      dio.interceptors.add(CookieManager(cookieJar));
      await dio.get(_url);
      print(await cookieJar.loadForRequest(Uri.parse(_url)));

      response = await dio.get(
        _url,
        options: Options(headers: {'token': "$_token"}),
      );

      // print(response);
    } catch (e) {
      throw (e);
    }
    return response;
  }

  Future endShift(String eventId, String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? _token = prefs.getString("token");
    var _url = "${baseUrl}event/end-shift?event_id=$eventId&user_id=$userId";
    final data;
    try {
      dio.interceptors.add(CookieManager(cookieJar));
      await dio.get(_url);
      print(await cookieJar.loadForRequest(Uri.parse(_url)));

      // second request with the cookie
      Response response = await dio.get(
        _url,
        options: Options(headers: {'token': "$_token"}),
      );
      print(response);
      data = response.data["data"];
      print(data);
      print("Shift End");
      notifyListeners();
    } catch (e) {
      throw (e);
      // print(e);
    }
    return data;
  }

  // Future<void> startShift(
  //   int event_id,
  //   int user_id,
  //   double lat,
  //   double long,
  // ) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? _token = prefs.getString("token");
  //   var _url =
  //       "http://91.74.105.110:8078/event/start-shift?event_id=42&user_id=161&latitude=21.7574093258&longitude=70.614430881&team_id=5";
  //   try {
  //     dio.interceptors.add(CookieManager(cookieJar));
  //     await dio.get(_url);
  //     print(await cookieJar.loadForRequest(Uri.parse(_url)));

  //     // second request with the cookie
  //     Response response = await dio.get(
  //       _url,
  //       options: Options(
  //           headers: {'token': "4da8388f4e61e4158150a451998e7dd8fcd686ba"}),
  //     );
  //     Map<String, dynamic> data = response.data["data"];
  //     data = response.data["data"];
  //     print(response.data);
  //     if (data == null) {
  //       print("null");
  //       IsStartShift = false;
  //     } else if (data["message"] == "Shift started successfully!") {
  //       IsStartShift = true;
  //       print("Shift Started");
  //     }
  //     notifyListeners();
  //   } catch (e) {
  //     throw (e);
  //     // print(e);
  //   }
  // }

  Future updateLocation(
      String eventId, String userId, String lat, String lang) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? _token = prefs.getString("token");
    var url = Uri.parse(
        "${baseUrl}event/user-geolocation?event_id=$eventId&user_id=$userId&latitude=$lat&longitude=$lang");
    try {
      final response = await http.post(url, headers: {'token': "$_token"});
      print("Update Location");
      print(response.body);
      notifyListeners();
    } catch (e) {}
  }

  Future startBreak(String event_id, String user_id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? _token = prefs.getString("token");
    var _url =
        "${AppUrl.baseURL}event/start-break?event_id=$event_id&user_id=$user_id";
    try {
      dio.interceptors.add(CookieManager(cookieJar));
      await dio.get(_url);
      print(await cookieJar.loadForRequest(Uri.parse(_url)));

      // second request with the cookie
      Response response = await dio.get(
        _url,
        options: Options(headers: {'token': "$_token"}),
      );
      print(response);
    } catch (e) {
      throw (e);
    }
  }

  Future endBreak(String event_id, String user_id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? _token = prefs.getString("token");
    var _url = "${baseUrl}event/end-break?event_id=$event_id&user_id=$user_id";
    try {
      dio.interceptors.add(CookieManager(cookieJar));
      await dio.get(_url);
      print(await cookieJar.loadForRequest(Uri.parse(_url)));

      // second request with the cookie
      Response response = await dio.get(
        _url,
        options: Options(headers: {'token': "$_token"}),
      );
      print(response);
    } catch (e) {
      throw (e);
    }
  }

  Future timeSheetDetail(String event_id, String user_id, String limit,
      String offset, String team_id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? _token = prefs.getString("token");
    final data;
    var _url =
        "${baseUrl}event/timesheet-details-byuser/?user_id=$user_id&event_id=$event_id&limit=$limit&team_id=$team_id";
    try {
      dio.interceptors.add(CookieManager(cookieJar));
      await dio.get(_url);
      print(await cookieJar.loadForRequest(Uri.parse(_url)));

      // second request with the cookie
      Response response = await dio.get(
        _url,
        options: Options(headers: {'token': "$_token"}),
      );
      data = response.data["data"];
      print(data);
    } catch (e) {
      throw (e);
    }
    return data;
  }

  Future eventTimeSheetDetail(String event_id, String user_id, String limit,
      String offset, String team_id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? _token = prefs.getString("token");
    final data;
    var _url =
        "${AppUrl.baseURL}event/timesheet-details/?event_id=$event_id&limit=$limit&team_id=$team_id";
    try {
      dio.interceptors.add(CookieManager(cookieJar));
      await dio.get(_url);
      print(await cookieJar.loadForRequest(Uri.parse(_url)));

      // second request with the cookie
      Response response = await dio.get(
        _url,
        options: Options(headers: {'token': "$_token"}),
      );
      data = response.data["data"];
      print(data);
    } catch (e) {
      throw (e);
    }
    return data;
  }

  Future teamDetail(int event_id, int user_id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? _token = prefs.getString("token");
    final data;
    String _url =
        "${baseUrl}event/team-details?event_id=$event_id&user_id=$user_id";
    try {
      dio.interceptors.add(CookieManager(cookieJar));
      await dio.get(_url);
      print(await cookieJar.loadForRequest(Uri.parse(_url)));

      Response response = await dio.get(
        _url,
        options: Options(headers: {'token': "$_token"}),
      );
      TeamDetail teamData = TeamDetail.fromJson(response.data["data"]);
      teamData = teamData;
      print(teamData);
    } catch (e) {
      throw (e);
    }
  }
}
