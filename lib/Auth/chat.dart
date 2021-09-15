import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chat with ChangeNotifier {
  var dio = Dio();
  var cookieJar = CookieJar();
  Chat();

  Future chatThreads(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    var data;
    String? token = prefs.getString("token");
    var _url = "${baseUrl}event/chat-threads?user_id=$userId";

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
      data = response.data['data'];
      // print(data);
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

  Future messageThreads(String userId, String channelId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    var data;
    String? token = prefs.getString("token");
    print(token);
    var _url =
        "${baseUrl}event/chat-thread-messages?user_id=$userId&channel_id=$channelId&short_by=ascending&offset=15";

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
      data = response.data['data'];
      // print(data);
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

  Future eventChatThreads(
      String userId, String eventId, String limit, String offset) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    var data;
    print("UserID:- $userId $eventId $limit $offset");
    String? token = prefs.getString("token");
    var _url = "${baseUrl}event/chat-threads?event_id=$eventId&user_id=$userId";

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
      data = response.data['data'];
      // print(data);
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

  Future eventMessageThreads(
    String userId,
    String channelId,
    String eventId,
    // String offset,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");
    var data;
    String? token = prefs.getString("token");
    print(token);
    var _url =
        "${baseUrl}event/chat-thread-messages?event_id=$eventId&user_id=$userId&channel_id=$channelId";

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
      data = response.data['data'];
      // print(data);
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

  Future sendMessage(
    String userId,
    String channelId,
    String message,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");

    String? token = prefs.getString("token");
    print(token);
    var _url =
        "${baseUrl}event/post-chat-message?user_id=$userId&channel_id=$channelId&message=$message";
    print(_url);
    try {
      final response =
          await http.post(Uri.parse(_url), headers: {'token': "$token"});
      print("Response $response");
      notifyListeners();
    } catch (error) {
      notifyListeners();
      throw (error);
    }
  }

  // http://91.74.105.110:8078/event/chat-thread-messages?user_id=158&channel_id=96
}
