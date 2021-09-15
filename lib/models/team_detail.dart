


class TeamDetail {
  String? _teamName;
  String? _latitude;
  String? _longitude;
  int? _radius;
  int? _teamId;
  int? _userId;
  String? _status;
  String? _startTime;
  String? _endTime;
  String? _totalHours;
  String? _manager;
  List<Manager_ids>? _managerIds;
  String? _supervisors;
  List<Supervisor_ids>? _supervisorIds;
  List<Security_personnals>? _securityPersonnals;

  String? get teamName => _teamName;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  int? get radius => _radius;
  int? get teamId => _teamId;
  int? get userId => _userId;
  String? get status => _status;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get totalHours => _totalHours;
  String? get manager => _manager;
  List<Manager_ids>? get managerIds => _managerIds;
  String? get supervisors => _supervisors;
  List<Supervisor_ids>? get supervisorIds => _supervisorIds;
  List<Security_personnals>? get securityPersonnals => _securityPersonnals;

  TeamDetail({
      String? teamName, 
      String? latitude, 
      String? longitude, 
      int? radius, 
      int? teamId, 
      int? userId, 
      String? status, 
      String? startTime, 
      String? endTime, 
      String? totalHours, 
      String? manager, 
      List<Manager_ids>? managerIds, 
      String? supervisors, 
      List<Supervisor_ids>? supervisorIds, 
      List<Security_personnals>? securityPersonnals}){
    _teamName = teamName;
    _latitude = latitude;
    _longitude = longitude;
    _radius = radius;
    _teamId = teamId;
    _userId = userId;
    _status = status;
    _startTime = startTime;
    _endTime = endTime;
    _totalHours = totalHours;
    _manager = manager;
    _managerIds = managerIds;
    _supervisors = supervisors;
    _supervisorIds = supervisorIds;
    _securityPersonnals = securityPersonnals;
}

  TeamDetail.fromJson(dynamic json) {
    _teamName = json['team_name'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _radius = json['radius'];
    _teamId = json['team_id'];
    _userId = json['user_id'];
    _status = json['status'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _totalHours = json['total_hours'];
    _manager = json['manager'];
    if (json['manager_ids'] != null) {
      _managerIds = [];
      json['manager_ids'].forEach((v) {
        _managerIds?.add(Manager_ids.fromJson(v));
      });
    }
    _supervisors = json['supervisors'];
    if (json['supervisor_ids'] != null) {
      _supervisorIds = [];
      json['supervisor_ids'].forEach((v) {
        _supervisorIds?.add(Supervisor_ids.fromJson(v));
      });
    }
    if (json['security_personnals'] != null) {
      _securityPersonnals = [];
      json['security_personnals'].forEach((v) {
        _securityPersonnals?.add(Security_personnals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['team_name'] = _teamName;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['radius'] = _radius;
    map['team_id'] = _teamId;
    map['user_id'] = _userId;
    map['status'] = _status;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['total_hours'] = _totalHours;
    map['manager'] = _manager;
    if (_managerIds != null) {
      map['manager_ids'] = _managerIds?.map((v) => v.toJson()).toList();
    }
    map['supervisors'] = _supervisors;
    if (_supervisorIds != null) {
      map['supervisor_ids'] = _supervisorIds?.map((v) => v.toJson()).toList();
    }
    if (_securityPersonnals != null) {
      map['security_personnals'] = _securityPersonnals?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


class Security_personnals {
  String? _userName;
  String? _email;
  String? _uid;
  String? _mobile;
  String? _loginCode;
  String? _firebaseId;
  String? _deviceType;
  String? _latitude;
  String? _longitude;
  int? _userId;
  String? _status;
  List<dynamic>? _feedback;
  String? _photo;

  String? get userName => _userName;
  String? get email => _email;
  String? get uid => _uid;
  String? get mobile => _mobile;
  String? get loginCode => _loginCode;
  String? get firebaseId => _firebaseId;
  String? get deviceType => _deviceType;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  int? get userId => _userId;
  String? get status => _status;
  List<dynamic>? get feedback => _feedback;
  String? get photo => _photo;

  Security_personnals({
      String? userName, 
      String? email, 
      String? uid, 
      String? mobile, 
      String? loginCode, 
      String? firebaseId, 
      String? deviceType, 
      String? latitude, 
      String? longitude, 
      int? userId, 
      String? status, 
      List<dynamic>? feedback, 
      String? photo}){
    _userName = userName;
    _email = email;
    _uid = uid;
    _mobile = mobile;
    _loginCode = loginCode;
    _firebaseId = firebaseId;
    _deviceType = deviceType;
    _latitude = latitude;
    _longitude = longitude;
    _userId = userId;
    _status = status;
    _feedback = feedback;
    _photo = photo;
}

  Security_personnals.fromJson(dynamic json) {
    _userName = json['user_name'];
    _email = json['email'];
    _uid = json['uid'];
    _mobile = json['mobile'];
    _loginCode = json['login_code'];
    _firebaseId = json['firebase_id'];
    _deviceType = json['device_type'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _userId = json['user_id'];
    _status = json['status'];
    if (json['feedback'] != null) {
      _feedback = [];
      json['feedback'].forEach((v) {
        // _feedback?.add(dynamic.fromJson(v));
      });
    }
    _photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['user_name'] = _userName;
    map['email'] = _email;
    map['uid'] = _uid;
    map['mobile'] = _mobile;
    map['login_code'] = _loginCode;
    map['firebase_id'] = _firebaseId;
    map['device_type'] = _deviceType;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['user_id'] = _userId;
    map['status'] = _status;
    if (_feedback != null) {
      map['feedback'] = _feedback?.map((v) => v.toJson()).toList();
    }
    map['photo'] = _photo;
    return map;
  }

}

/// id : 112
/// name : "Supervisor-FHA"
/// status : "offline"
/// mobile : "009715434535"
/// firebase_id : "dy6_ASmfT_yagFTzOdwCBA:APA91bHOkenI1uryvFKo6zqNTJLB8KLo05JNciovFXzsZm7ryIcm99lOe1aaXU02YqfylKGhjgComhV9Px7alEvLor6liYdRuZq2x7mi61CgW9Uc8EKOiOkheatZ2GjQaJGJULdpwTpv"
/// longitude : "-122.084"
/// latitude : "37.4219983"
/// photo : ""

class Supervisor_ids {
  int? _id;
  String? _name;
  String? _status;
  String? _mobile;
  String? _firebaseId;
  String? _longitude;
  String? _latitude;
  String? _photo;

  int? get id => _id;
  String? get name => _name;
  String? get status => _status;
  String? get mobile => _mobile;
  String? get firebaseId => _firebaseId;
  String? get longitude => _longitude;
  String? get latitude => _latitude;
  String? get photo => _photo;

  Supervisor_ids({
      int? id, 
      String? name, 
      String? status, 
      String? mobile, 
      String? firebaseId, 
      String? longitude, 
      String? latitude, 
      String? photo}){
    _id = id;
    _name = name;
    _status = status;
    _mobile = mobile;
    _firebaseId = firebaseId;
    _longitude = longitude;
    _latitude = latitude;
    _photo = photo;
}

  Supervisor_ids.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _status = json['status'];
    _mobile = json['mobile'];
    _firebaseId = json['firebase_id'];
    _longitude = json['longitude'];
    _latitude = json['latitude'];
    _photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['status'] = _status;
    map['mobile'] = _mobile;
    map['firebase_id'] = _firebaseId;
    map['longitude'] = _longitude;
    map['latitude'] = _latitude;
    map['photo'] = _photo;
    return map;
  }

}

/// id : 111
/// name : "Manager-FHA"
/// status : "offline"
/// mobile : "009715434535"
/// firebase_id : "dy6_ASmfT_yagFTzOdwCBA:APA91bHOkenI1uryvFKo6zqNTJLB8KLo05JNciovFXzsZm7ryIcm99lOe1aaXU02YqfylKGhjgComhV9Px7alEvLor6liYdRuZq2x7mi61CgW9Uc8EKOiOkheatZ2GjQaJGJULdpwTpv"
/// photo : "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"

class Manager_ids {
  int? _id;
  String? _name;
  String? _status;
  String? _mobile;
  String? _firebaseId;
  String? _photo;

  int? get id => _id;
  String? get name => _name;
  String? get status => _status;
  String? get mobile => _mobile;
  String? get firebaseId => _firebaseId;
  String? get photo => _photo;

  Manager_ids({
      int? id, 
      String? name, 
      String? status, 
      String? mobile, 
      String? firebaseId, 
      String? photo}){
    _id = id;
    _name = name;
    _status = status;
    _mobile = mobile;
    _firebaseId = firebaseId;
    _photo = photo;
}

  Manager_ids.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _status = json['status'];
    _mobile = json['mobile'];
    _firebaseId = json['firebase_id'];
    _photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['status'] = _status;
    map['mobile'] = _mobile;
    map['firebase_id'] = _firebaseId;
    map['photo'] = _photo;
    return map;
  }

}