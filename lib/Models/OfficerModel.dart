// To parse this JSON data, do
//
//     final officerModel = officerModelFromJson(jsonString);

import 'dart:convert';

OfficerModel officerModelFromJson(String str) => OfficerModel.fromJson(json.decode(str));

String officerModelToJson(OfficerModel data) => json.encode(data.toJson());

class OfficerModel {
  OfficerModel({
    this.status,
    this.date,
  });

  String status;
  List<Date> date;

  factory OfficerModel.fromJson(Map<String, dynamic> json) => OfficerModel(
    status: json["status"],
    date: List<Date>.from(json["date"].map((x) => Date.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "date": List<dynamic>.from(date.map((x) => x.toJson())),
  };
}

class Date {
  Date({
    this.id,
    this.roleId,
    this.companyId,
    this.departmentId,
    this.locationId,
    this.buildingId,
    this.twoFactor,
    this.deviceId,
    this.name,
    this.email,
    this.mobile,
    this.gender,
    this.address,
    this.avatar,
    this.allowedIp,
    this.ip,
    this.employeeType,
    this.fromDate,
    this.tillDate,
    this.statusId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  int roleId;
  String companyId;
  int departmentId;
  int locationId;
  int buildingId;
  int twoFactor;
  int deviceId;
  String name;
  String email;
  String mobile;
  dynamic gender;
  dynamic address;
  String avatar;
  int allowedIp;
  dynamic ip;
  dynamic employeeType;
  dynamic fromDate;
  dynamic tillDate;
  int statusId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
    id: json["id"],
    roleId: json["role_id"],
    companyId: json["company_id"],
    departmentId: json["department_id"],
    locationId: json["location_id"] == null ? null : json["location_id"],
    buildingId: json["building_id"] == null ? null : json["building_id"],
    twoFactor: json["two_factor"] == null ? null : json["two_factor"],
    deviceId: json["device_id"] == null ? null : json["device_id"],
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    gender: json["gender"],
    address: json["address"],
    avatar: json["avatar"] == null ? null : json["avatar"],
    allowedIp: json["allowed_ip"],
    ip: json["ip"],
    employeeType: json["employee_type"],
    fromDate: json["from_date"],
    tillDate: json["till_date"],
    statusId: json["status_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "role_id": roleId,
    "company_id": companyId,
    "department_id": departmentId,
    "location_id": locationId == null ? null : locationId,
    "building_id": buildingId == null ? null : buildingId,
    "two_factor": twoFactor == null ? null : twoFactor,
    "device_id": deviceId == null ? null : deviceId,
    "name": name,
    "email": email,
    "mobile": mobile,
    "gender": gender,
    "address": address,
    "avatar": avatar == null ? null : avatar,
    "allowed_ip": allowedIp,
    "ip": ip,
    "employee_type": employeeType,
    "from_date": fromDate,
    "till_date": tillDate,
    "status_id": statusId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
