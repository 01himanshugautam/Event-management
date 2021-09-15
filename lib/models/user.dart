class User {
  int? userId;
  String? name;
  String? image;
  String? email;
  // String? phone;
  // String? position;
  // String? role;
  // int? roleId;
  // String? callSupervisor;

  User({
    this.userId,
    this.name,
    this.email,
    this.image,
    // this.phone,
    // this.role,
    // this.roleId,
    // this.position,
    // this.callSupervisor,
  });

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      userId: responseData['user_id'],
      name: responseData['user_name'],
      image: responseData['image'],
      email: responseData['email'],
      // phone: responseData['phone'],
      // role: responseData['role'],
      // roleId: responseData['role_id'],
      // position: responseData['position'],
      // callSupervisor: responseData['call_supervisor'],
    );
  }
}
