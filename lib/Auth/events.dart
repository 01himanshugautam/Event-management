import 'dart:math';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pn_204_sam/models/app_urls.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Event with ChangeNotifier {
  var dio = Dio();
  var cookieJar = CookieJar();
  Event();

  Future getEventId(
    String userId,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? token = prefs.getString("token");
    var _url = "${baseUrl}event/event-list-by-user?user_id=$userId";
    var data;
    try {
      dio.interceptors.add(CookieManager(cookieJar));
      await dio.get(_url);
      // Print cookies
      print(await cookieJar.loadForRequest(Uri.parse(_url)));
      // second request with the cookie
      Response response = await dio.get(
        _url,
        options: Options(headers: {'token': "$token"}),
      );
      // print("GetEventId $response");
      data = response.data['data'][0];
      int eventId = data['event_id'];
      prefs.setString('eventId', "$eventId");
      // var eid = prefs.getString("eventId");
      // print("Event id $eid");
      notifyListeners();
      // print("ResponseData ${response.data['data']}");
      // final data = responseData["data"];
      // print(data);
    } catch (error) {
      notifyListeners();
      throw (error);
    }
    return data;
  }

  Future getTeamDetail(String event_id, String user_id) async {
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
      data = response.data['data'];
      // print(data);
      // print(response);
    } catch (e) {
      throw (e);
    }
    return data;
  }

  Future sGetTeamDetail(
    String event_id,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? _token = prefs.getString("token");
    final data;
    String _url = "${baseUrl}event/team-details?event_id=$event_id";
    try {
      dio.interceptors.add(CookieManager(cookieJar));
      await dio.get(_url);
      print(await cookieJar.loadForRequest(Uri.parse(_url)));

      Response response = await dio.get(
        _url,
        options: Options(headers: {'token': "$_token"}),
      );
      data = response.data['data'];
      // print(data);
      // print(response);
    } catch (e) {
      throw (e);
    }
    return data;
  }

  Future getEventLIstbyUser(String user_id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? _token = prefs.getString("token");
    final data;
    String _url = "${baseUrl}event/event-list-by-user?user_id=$user_id";
    print("$_url");
    try {
      dio.interceptors.add(CookieManager(cookieJar));
      await dio.get(_url);
      print(await cookieJar.loadForRequest(Uri.parse(_url)));

      Response response = await dio.get(
        _url,
        options: Options(headers: {'token': "$_token"}),
      );
      data = response.data['data'];
    } catch (e) {
      throw (e);
    }
    return data;
  }

// /event/post-activity?event_id=106&user_id=169&activity_type=SOS&message=EMERGENCY&team_id=97
  Future sos(String userId, String eventId, String teamId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? _token = prefs.getString("token");
    final data;
    var _url = Uri.parse(
        "${baseUrl}event/post-activity?event_id=$eventId&user_id=$userId&activity_type=SOS&message=EMERGENCY&team_id=$teamId");
    try {
      final response = await http.post(_url, headers: {'token': "$_token"});
      print("Update Location");
      // print(response.body);
      data = response;
      notifyListeners();
    } catch (e) {
      throw (e);
    }
    return data;
  }
}
