// To parse this JSON data, do
//
//     final preInvitationListModel = preInvitationListModelFromJson(jsonString);

import 'dart:convert';

PreInvitationListModel preInvitationListModelFromJson(String str) => PreInvitationListModel.fromJson(json.decode(str));

String preInvitationListModelToJson(PreInvitationListModel data) => json.encode(data.toJson());

class PreInvitationListModel {
  PreInvitationListModel({
    this.status,
    this.msg,
    this.data,
  });

  String status;
  String msg;
  List<PreInvitationData> data;

  factory PreInvitationListModel.fromJson(Map<String, dynamic> json) => PreInvitationListModel(
    status: json["status"],
    msg: json["msg"],
    data: List<PreInvitationData>.from(json["data"].map((x) => PreInvitationData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class PreInvitationData {
  PreInvitationData({
    this.id,
    this.name,
    this.mobile,
    this.preVisitDateTime,
    this.email,
    this.status,
    this.image,
    this.services,
    this.referCode,
    this.addedBy,
    this.createdAt,
    this.officerId,
    this.appStatus,
  });

  int id;
  String name;
  String mobile;
  String preVisitDateTime;
  String email;
  int status;
  dynamic image;
  dynamic services;
  String referCode;
  dynamic addedBy;
  DateTime createdAt;
  int officerId;
  String appStatus;

  factory PreInvitationData.fromJson(Map<String, dynamic> json) => PreInvitationData(
    id: json["id"],
    name: json["name"],
    mobile: json["mobile"],
    preVisitDateTime: json["pre_visit_date_time"],
    email: json["email"],
    status: json["status"],
    image: json["image"],
    services: json["services"],
    referCode: json["refer_code"] == null ? null : json["refer_code"],
    addedBy: json["added_by"],
    createdAt: DateTime.parse(json["created_at"]),
    officerId: json["officer_id"],
    appStatus: json["app_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile": mobile,
    "pre_visit_date_time": preVisitDateTime,
    "email": email,
    "status": status,
    "image": image,
    "services": services,
    "refer_code": referCode == null ? null : referCode,
    "added_by": addedBy,
    "created_at": createdAt.toIso8601String(),
    "officer_id": officerId,
    "app_status": appStatus,
  };
}
