// To parse this JSON data, do
//
//     final overStayingVisitor = overStayingVisitorFromJson(jsonString);

import 'dart:convert';

OverStayingVisitor overStayingVisitorFromJson(String str) => OverStayingVisitor.fromJson(json.decode(str));

String overStayingVisitorToJson(OverStayingVisitor data) => json.encode(data.toJson());

class OverStayingVisitor {
  OverStayingVisitor({
    this.status,
    this.msg,
    this.data,
  });

  String status;
  String msg;
  List<OverStayingData> data;

  factory OverStayingVisitor.fromJson(Map<String, dynamic> json) => OverStayingVisitor(
    status: json["status"],
    msg: json["msg"],
    data: List<OverStayingData>.from(json["data"].map((x) => OverStayingData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class OverStayingData {
  OverStayingData({
    this.id,
    this.userId,
    this.dateTime,
    this.officerId,
    this.companyId,
    this.addedBy,
    this.createdAt,
    this.inTime,
    this.inDevice,
    this.inStatus,
    this.outDevice,
    this.outTime,
    this.outStatus,
    this.updatedAt,
    this.deletedAt,
    this.getVisitor,
  });

  int id;
  int userId;
  String dateTime;
  int officerId;
  dynamic companyId;
  int addedBy;
  DateTime createdAt;
  String inTime;
  String inDevice;
  String inStatus;
  String outDevice;
  String outTime;
  String outStatus;
  DateTime updatedAt;
  dynamic deletedAt;
  GetVisitor getVisitor;

  OverStayingData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    dateTime = json["date_time"];
    officerId = json["officer_id"];
    companyId = json["company_id"];
    addedBy = json["added_by"];
    createdAt = DateTime.parse(json["created_at"]);
    inTime = json["in_time"];
    inDevice = json["in_device"];
    inStatus = json["in_status"];
    outDevice = json["out_device"] == null ? null : json["out_device"];
    outTime = json["out_time"];
    outStatus = json["out_status"];
    updatedAt = DateTime.parse(json["updated_at"]);
    deletedAt = json["deleted_at"];
    getVisitor = GetVisitor.fromJson(json["get_visitor"]);
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "date_time": dateTime,
    "officer_id": officerId,
    "company_id": companyId,
    "added_by": addedBy,
    "created_at": createdAt.toIso8601String(),
    "in_time": inTime,
    "in_device": inDevice,
    "in_status": inStatus,
    "out_device": outDevice == null ? null : outDevice,
    "out_time": outTime,
    "out_status": outStatus,
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "get_visitor": getVisitor.toJson(),
  };
}

class GetVisitor {
  GetVisitor({
    this.id,
    this.visiteDuration,
    this.companyId,this.name,this.email,this.image,this.mobile,this.status
  });

  int id;
  String visiteDuration;
  String companyId;
  String name;
  String mobile;
  int status;
  String email;
  String image;


  GetVisitor.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    visiteDuration = json["visite_duration"];
    companyId = json["company_id"];
    name = json["name"];
    mobile = json["mobile"];
    status = json["status"];
    email = json["email"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "visite_duration": visiteDuration,
    "company_id": companyId,
    "image": image,
    "email": email,
    "status": status,
    "mobile": mobile,
    "name": name,
  };
}
