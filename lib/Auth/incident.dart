import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pn_204_sam/models/app_urls.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Incident with ChangeNotifier {
  var dio = Dio();
  var cookieJar = CookieJar();
  Incident();

  getEventIncident(
    String eventId,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? token = prefs.getString("token");
    var _url = "${baseUrl}event/event-incident-stats?event_id=42";
    final data;
    Map mydata;
    try {
      dio.interceptors.add(CookieManager(cookieJar));
      await dio.get(_url);
      // Print cookies
      print(await cookieJar.loadForRequest(Uri.parse(_url)));

      Response response = await dio.get(
        _url,
        options: Options(headers: {'token': "$token"}),
      );
      // print("Incident Data :- $response");
      notifyListeners();
      // print("ResponseData ${response.data['data']}");
      data = response.data['data'];
      mydata = data;
      // print("Mtdata $mydata");
      // print(data);
    } catch (error) {
      notifyListeners();
      throw (error);
    }
    return mydata;
  }

  createIncidentReport(
      String eventId,
      String comment,
      String incType,
      String reportedBy,
      String resolvedState,
      String daysPassed,
      String incTeamArea,
      String incGeoLocation,
      String incGuardSup,
      String incGuardMan,
      String image) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? token = prefs.getString("token");
    var _url =
        "${baseUrl}event/create-incident-report?event_id=$eventId&comment=$comment&inc_type=$incType&reported_by=$reportedBy&resolved_state=$resolvedState&days_passed=$daysPassed&inc_team_area=$incTeamArea&inc_geo_location=$incGeoLocation&inc_guard_sup=$incGuardSup&inc_guard_man=$incGuardMan";
    final response;

    try {
      response = await http.post(
        Uri.parse(_url),
        body: {
          'inc_upload': '$image',
        },
        headers: {
          'token': "$token",
        },
        // data: {'inc_upload': '$image'},
        // options: Options(headers: {'token': "$token"}),
      );
      // print("Incident Data :- $response");
      notifyListeners();
      // print("ResponseData ${response.data['data']}");

      // print("Mtdata $mydata");
      // print(data);
    } catch (error) {
      print(error);
      notifyListeners();
      throw (error);
    }
    return response;
  }

  updateIncidentReport(
      String eventId,
      String comment,
      String incType,
      String reportedBy,
      String resolvedState,
      String daysPassed,
      String incTeamArea,
      String incGeoLocation,
      String incGuardSup,
      String incGuardMan,
      String incendetId,
      String image) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? token = prefs.getString("token");
    var _url =
        "${baseUrl}event/update-incident-report?event_id=$eventId&comment=$comment&inc_type=$incType&reported_by=$reportedBy&resolved_state=$resolvedState&days_passed=$daysPassed&inc_team_area=$incTeamArea&inc_geo_location=$incGeoLocation&inc_guard_sup=$incGuardSup&inc_guard_man=$incGuardMan&inc_id=$incendetId";
    print(_url);
    final response;

    try {
      response = await http.post(
        Uri.parse(_url),
        body: {
          'inc_upload': '$image',
        },
        headers: {
          'token': "$token",
        },
      );
      // print("Incident Data :- $response");
      notifyListeners();
      // print("ResponseData ${response.data['data']}");

      // print("Mtdata $mydata");
      // print(data);
    } catch (error) {
      print(error);
      notifyListeners();
      throw (error);
    }
    return response;
  }

  getIncidentReport(
    String eventId,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? token = prefs.getString("token");
    var _url = "${baseUrl}event/incident-report?event_id=$eventId";
    final data;

    try {
      dio.interceptors.add(CookieManager(cookieJar));
      await dio.get(_url);
      // Print cookies
      print(await cookieJar.loadForRequest(Uri.parse(_url)));

      Response response = await dio.get(
        _url,
        options: Options(headers: {'token': "$token"}),
      );
      data = response.data['data'];
      // print("Incident Data :- $response");
      notifyListeners();
      // print("ResponseData ${response.data['data']}");

      // print("Mtdata $mydata");
      // print(data);
    } catch (error) {
      notifyListeners();
      throw (error);
    }
    return data;
  }
}
