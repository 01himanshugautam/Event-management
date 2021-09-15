
class TimesheetDetail {
  String? _name;
  String? _checkIn;
  String? _checkOut;
  double? _workedHours;
  String? _status;
  bool? _remark;

  String? get name => _name;
  String? get checkIn => _checkIn;
  String? get checkOut => _checkOut;
  double? get workedHours => _workedHours;
  String? get status => _status;
  bool? get remark => _remark;

  TimesheetDetail({
      String? name, 
      String? checkIn, 
      String? checkOut, 
      double? workedHours, 
      String? status, 
      bool? remark}){
    _name = name;
    _checkIn = checkIn;
    _checkOut = checkOut;
    _workedHours = workedHours;
    _status = status;
    _remark = remark;
}

  TimesheetDetail.fromJson(dynamic json) {
    _name = json['name'];
    _checkIn = json['check_in'];
    _checkOut = json['check_out'];
    _workedHours = json['worked_hours'];
    _status = json['status'];
    _remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = _name;
    map['check_in'] = _checkIn;
    map['check_out'] = _checkOut;
    map['worked_hours'] = _workedHours;
    map['status'] = _status;
    map['remark'] = _remark;
    return map;
  }

}