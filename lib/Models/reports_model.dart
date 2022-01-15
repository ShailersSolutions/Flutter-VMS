// To parse this JSON data, do
//
//     final reportListModel = reportListModelFromJson(jsonString);

import 'dart:convert';

ReportListModel reportListModelFromJson(String str) => ReportListModel.fromJson(json.decode(str));

String reportListModelToJson(ReportListModel data) => json.encode(data.toJson());

class ReportListModel {
  ReportListModel({
    this.status,
    this.msg,
    this.data,
  });

  String status;
  String msg;
  List<ReportData> data;

  factory ReportListModel.fromJson(Map<String, dynamic> json) => ReportListModel(
    status: json["status"],
    msg: json["msg"],
    data: List<ReportData>.from(json["data"].map((x) => ReportData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ReportData {
  ReportData({
    this.id,
    this.userId,
    this.inTime,
    this.inDevice,
    this.inStatus,
    this.outDevice,
    this.outTime,
    this.outStatus,
    this.getVisitor,
  });

  int id;
  int userId;
  DateTime inTime;
  String inDevice;
  String inStatus;
  dynamic outDevice;
  DateTime outTime;
  String outStatus;
  GetVisitor getVisitor;

  factory ReportData.fromJson(Map<String, dynamic> json) => ReportData(
    id: json["id"],
    userId: json["user_id"],
    inTime: DateTime.parse(json["in_time"]),
    inDevice: json["in_device"],
    inStatus: json["in_status"],
    outDevice: json["out_device"],
    outTime: DateTime.parse(json["out_time"]),
    outStatus: json["out_status"],
    getVisitor: json["get_visitor"] == null ? null : GetVisitor.fromJson(json["get_visitor"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "in_time": inTime.toIso8601String(),
    "in_device": inDevice,
    "in_status": inStatus,
    "out_device": outDevice,
    "out_time": outTime.toIso8601String(),
    "out_status": outStatus,
    "get_visitor": getVisitor == null ? null : getVisitor.toJson(),
  };
}

class GetVisitor {
  GetVisitor({
    this.id,
    this.name,
    this.locationId,
    this.buildingId,
    this.departmentId,
    this.building,
    this.location,
    this.officerDepartment,this.referCode
  });

  int id;
  String name;
  int locationId;
  int buildingId;
  String referCode;
  String departmentId;
  Building building;
  Building location;
  Building officerDepartment;

  factory GetVisitor.fromJson(Map<String, dynamic> json) => GetVisitor(
    id: json["id"],
    name: json["name"],
    referCode: json['refer_code'],
    locationId: json["location_id"],
    buildingId: json["building_id"],
    departmentId: json["department_id"],
    building: Building.fromJson(json["building"]),
    location: Building.fromJson(json["location"]),
    officerDepartment: Building.fromJson(json["officer_department"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "refer_code" : referCode,
    "location_id": locationId,
    "building_id": buildingId,
    "department_id": departmentId,
    "building": building.toJson(),
    "location": location.toJson(),
    "officer_department": officerDepartment.toJson(),
  };
}

class Building {
  Building({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Building.fromJson(Map<String, dynamic> json) => Building(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
