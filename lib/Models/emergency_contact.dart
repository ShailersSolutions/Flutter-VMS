// To parse this JSON data, do
//
//     final emergencyContact = emergencyContactFromJson(jsonString);

import 'dart:convert';

EmergencyContact emergencyContactFromJson(String str) => EmergencyContact.fromJson(json.decode(str));

String emergencyContactToJson(EmergencyContact data) => json.encode(data.toJson());

class EmergencyContact {
  EmergencyContact({
    this.status,
    this.msg,
    this.data,
  });

  String status;
  String msg;
  List<EmergencyData> data;

  factory EmergencyContact.fromJson(Map<String, dynamic> json) => EmergencyContact(
    status: json["status"],
    msg: json["msg"],
    data: List<EmergencyData>.from(json["data"].map((x) => EmergencyData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class EmergencyData {
  EmergencyData({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.officerId,
    this.companyId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  String name;
  String mobile;
  String email;
  String officerId;
  String companyId;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory EmergencyData.fromJson(Map<String, dynamic> json) => EmergencyData(
    id: json["id"],
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
    officerId: json["officer_id"],
    companyId: json["company_id"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile": mobile,
    "email": email,
    "officer_id": officerId,
    "company_id": companyId,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
