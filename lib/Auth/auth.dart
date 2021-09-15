import 'dart:convert';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pn_204_sam/models/UserPreferences.dart';
import 'package:pn_204_sam/models/app_urls.dart';
import 'package:pn_204_sam/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelf_secure_cookie/shelf_secure_cookie.dart';

class Auth with ChangeNotifier {
  var dio = Dio();
  var cookieJar = CookieJar();
  Auth();

  Future<void> loginToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    var url = Uri.parse(
        "${baseUrl}event/request/token?db=elite_event_management_v1&login=evapitoki4fhastaff@control-e.online&password=nsEnsEhuMKusEhu21nsEhu@1");

    print(url);
    try {
      final response = await http.get(
        url,
      );
      final responseData = json.decode(response.body);
      print("ResponseData $responseData");
      var data = responseData['data'];
      notifyListeners();
      // print("Data: $data");
      if (data['token'] != null) {
        UserPreferences().saveToken("${data['token']}");
      }
      notifyListeners();

      // print("Token : $_token");
    } catch (error) {
      throw (error);
    }
  }

  Future staffLogin(
    String loginCode,
    String deviceId,
    String deviceType,
    String firebaseId,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? token = prefs.getString("token");
    var roleId;
    print(token);
    var _url =
        "${baseUrl}event/user-login?login_code=$loginCode&uid=$deviceId&firebase_id=$firebaseId&device_type=$deviceType";
    Response response;
    try {
      dio.interceptors.add(CookieManager(cookieJar));
      await dio.get(_url);
      // Print cookies
      print(await cookieJar.loadForRequest(Uri.parse(_url)));
      // second request with the cookie
      response = await dio.get(
        _url,
        options: Options(headers: {'token': "$token"}),
      );
      notifyListeners();
    } catch (error) {
      notifyListeners();
      throw (error);
    }
    return response;
  }

  Future login(
    String email,
    String password,
    String deviceId,
    String deviceType,
    String firebaseId,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? token = prefs.getString("token");
    var roleId;
    print(token);
    var _url =
        "${baseUrl}event/user-login?login=$email&password=$password&firebase_id=$firebaseId&device_type=$deviceType&UID=$deviceId";
    Response response;
    try {
      dio.interceptors.add(CookieManager(cookieJar));
      await dio.get(_url);
      // Print cookies
      print(await cookieJar.loadForRequest(Uri.parse(_url)));
      // second request with the cookie
      response = await dio.get(
        _url,
        options: Options(headers: {'token': "$token"}),
      );
      notifyListeners();
    } catch (error) {
      notifyListeners();
      throw (error);
    }
    return response;
  }

  Future updateOnlineStatus(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? token = prefs.getString("token");
    print(token);
    var _url = "${baseUrl}event/update-online-state?user_id=$userId";
    Response response;
    try {
      dio.interceptors.add(CookieManager(cookieJar));
      await dio.get(_url);
      // Print cookies
      print(await cookieJar.loadForRequest(Uri.parse(_url)));
      // second request with the cookie
      response = await dio.get(
        _url,
        options: Options(headers: {'token': "$token"}),
      );
      notifyListeners();
    } catch (error) {
      notifyListeners();
      throw (error);
    }
    return response;
  }

  Future<void> logout(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? token = prefs.getString("token");
    print(token);
    String _url = "${baseUrl}event/user-logout?user_id=$userId";
    try {
      dio.interceptors.add(CookieManager(cookieJar));
      await dio.get(_url);
      // Print cookies
      print(await cookieJar.loadForRequest(Uri.parse(_url)));
      // second request with the cookie
      final response = await dio.get(
        _url,
        options: Options(
          headers: {'token': "$token"},
        ),
      );
      print("ResponseData $response");
      notifyListeners();
      UserPreferences().removeToken();
      UserPreferences().removeRoleId();
    } catch (error) {
      notifyListeners();
      print("error ${error.toString()}");
      throw (error);
    }
  }

  Future<void> uploadPhoto(String userId, String img, String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String _url = "${baseUrl}event/update-profile-photo?user_id=$userId";
    File file = File(img);
    try {
      // dio.interceptors.add(CookieManager(cookieJar));
      // await dio.put(_url);
      // // Print cookies
      // print(await cookieJar.loadForRequest(Uri.parse(_url)));
      // second request with the cookie
      // final response = await dio.put(
      //   _url,
      //   options: Options(
      //     headers: {'token': "$token"},
      //   ),
      //   // data: jsonEncode(params),
      // );
      final response = await http.put(
        Uri.parse(_url),
        headers: {'token': '$token'},
        body: {'ufile': file.path},
      );
      print("ResponseData ${response.body}");
      notifyListeners();
    } catch (error) {
      print("error ${error.toString()}");
      throw (error);
    }
  }

  Future getAnalyticStaff(String userId, String eventId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? token = prefs.getString("token");
    print(token);
    var _url =
        "${baseUrl}event/main-dashboard-stat-staff?event_id=$eventId&user_id=$userId";
    print("$_url");
    final data;
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
      data = response.data;
      // print(data);
      notifyListeners();
    } catch (error) {
      notifyListeners();
      throw (error);
    }
    return data;
  }

  Future getEvetnScheduleAnalyticManager(String userId, String eventId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? token = prefs.getString("token");
    print(token);
    var _url =
        "${baseUrl}event/event-dashboard-stats-manager?event_id=$eventId&user_id=$userId";
    final data;
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
      data = response.data;
      // print(data);
      notifyListeners();
    } catch (error) {
      notifyListeners();
      throw (error);
    }
    return data;
  }

  Future getEvetnScheduleAnalyticStaff(String userId, String eventId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? token = prefs.getString("token");
    print(token);
    var _url =
        "${baseUrl}event/event-dashboard-stats?event_id=$eventId&user_id=$userId";
    final data;
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
      data = response.data;
      // print(data);
      notifyListeners();
    } catch (error) {
      notifyListeners();
      throw (error);
    }
    return data;
  }

  Future getEvetnScheduleAnalyticsupervisor(
      String userId, String eventId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? token = prefs.getString("token");
    print(token);
    var _url =
        "${baseUrl}eventevent-dashboard-stats-manager?event_id=$eventId&user_id=$userId";
    final data;
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
      data = response.data;
      // print(data);
      notifyListeners();
    } catch (error) {
      notifyListeners();
      throw (error);
    }
    return data;
  }

  Future getAnalyticSupervisor(String userId, String eventId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? token = prefs.getString("token");
    print(token);
    var _url =
        "${baseUrl}event/main-dashboard-stat-staff?event_id=$eventId&user_id=$userId";
    Response response;
    try {
      dio.interceptors.add(CookieManager(cookieJar));
      await dio.get(_url);
      // Print cookies
      print(await cookieJar.loadForRequest(Uri.parse(_url)));
      // second request with the cookie
      response = await dio.get(
        _url,
        options: Options(headers: {'token': "$token"}),
      );
      print(response);
      notifyListeners();
    } catch (error) {
      notifyListeners();
      throw (error);
    }
    return response;
  }

  Future getAnalyticmanager(String userId, String eventId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? token = prefs.getString("token");
    print(token);
    var _url =
        "${baseUrl}event/main-dashboard-stat-staff?event_id=$eventId&user_id=$userId";
    Response response;
    try {
      dio.interceptors.add(CookieManager(cookieJar));
      await dio.get(_url);
      // Print cookies
      print(await cookieJar.loadForRequest(Uri.parse(_url)));
      // second request with the cookie
      response = await dio.get(
        _url,
        options: Options(headers: {'token': "$token"}),
      );
      print(response);
      notifyListeners();
    } catch (error) {
      notifyListeners();
      throw (error);
    }
    return response;
  }

  Future getAnalyticClient(String userId, String eventId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    String? token = prefs.getString("token");
    print(token);
    var _url =
        "${baseUrl}event/main-dashboard-stat-staff?event_id=$eventId&user_id=$userId";
    Response response;
    try {
      dio.interceptors.add(CookieManager(cookieJar));
      await dio.get(_url);
      // Print cookies
      print(await cookieJar.loadForRequest(Uri.parse(_url)));
      // second request with the cookie
      response = await dio.get(
        _url,
        options: Options(headers: {'token': "$token"}),
      );
      print(response);
      notifyListeners();
    } catch (error) {
      notifyListeners();
      throw (error);
    }
    return response;
  }
}
