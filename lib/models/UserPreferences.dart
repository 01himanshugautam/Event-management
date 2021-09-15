import 'package:pn_204_sam/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class UserPreferences {
  Future saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userId", "${user.userId}");
    prefs.setString("name", "${user.name}");
    prefs.setString("email", "${user.email}");
    prefs.setString("image", "${user.image}");
    // prefs.setString("phone", "${user.phone}");
    // prefs.setString("position", "${user.position}");
    // prefs.setString("role", "${user.role}");
    // prefs.setString("roleId", "${user.roleId}");

    String? userId = prefs.getString("userId");
    String? name = prefs.getString("name");
    String? image = prefs.getString("image");
    String? email = prefs.getString("email");
    // String? phone = prefs.getString("phone");
    // String? position = prefs.getString("position");
    // String? role = prefs.getString("role");
    // String? roleId = prefs.getString("roleId");
    // String? callSupervisor = prefs.getString("callSupervisor");

    print("Save User: $userId $name $email $image");
    // ignore: deprecated_member_use
    return prefs.commit();
  }

  // getUser() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? userId = prefs.getString("userId");
  //   String? name = prefs.getString("name");
  //   String? image = prefs.getString("image");
  //   String? email = prefs.getString("email");
  //   String? phone = prefs.getString("phone");
  //   String? position = prefs.getString("position");
  //   String? role = prefs.getString("role");
  //   String? roleId = prefs.getString("roleId");
  //   String? callSupervisor = prefs.getString("callSupervisor");

  //   return User(
  //     userId: "$userId",
  //     name: "$name",
  //     email: "$email",
  //     image: "$image",
  //   );
  // }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("phone");
    prefs.remove("type");
  }

  Future<bool> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    String? _token = prefs.getString("token");
    print("Token saved: $_token");
    // ignore: deprecated_member_use
    return prefs.commit();
  }

  getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print("Get Token $token");
    return token;
  }

  Future removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
  }

  Future<bool> saveRoleId(String rollId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("roleId", rollId);
    String? _rollId = prefs.getString("roleId");
    print("RoleId saved: $_rollId");
    // ignore: deprecated_member_use
    return prefs.commit();
  }

  getRoleId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var _roleId = prefs.getString("roleId");
    print("Get RoleId $_roleId");
    return _roleId;
  }

  Future removeRoleId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("roleId");
  }
}
