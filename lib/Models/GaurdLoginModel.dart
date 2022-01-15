// To parse this JSON data, do
//
//     final guardLoginModel = guardLoginModelFromJson(jsonString);

import 'dart:convert';

GuardLoginModel guardLoginModelFromJson(String str) => GuardLoginModel.fromJson(json.decode(str));

String guardLoginModelToJson(GuardLoginModel data) => json.encode(data.toJson());

class GuardLoginModel {
  GuardLoginModel({
    this.message,
    this.guardLoginModelClass,
    this.data,
    this.preInviteVisitor,
    this.guardDetails,
  });

  String message;
  String guardLoginModelClass;
  List<Upcoming> data;
  List<PreInviteVisitor> preInviteVisitor;
  GuardDetails guardDetails;

  GuardLoginModel.fromJson(Map<String, dynamic> json){
    message = json["message"];
    guardLoginModelClass = json["class"];
    if(json["class"] == "success"){
      data = List<Upcoming>.from(json["data"].map((x) => Upcoming.fromJson(x)));
      preInviteVisitor = List<PreInviteVisitor>.from(json["pre_invite_visitor"].map((x) => PreInviteVisitor.fromJson(x)));
      guardDetails = GuardDetails.fromJson(json["guard_details"]);
    }

  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "class": guardLoginModelClass,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "pre_invite_visitor": List<dynamic>.from(preInviteVisitor.map((x) => x.toJson())),
    "guard_details": guardDetails.toJson(),
  };
}

class Upcoming {
  Upcoming({
    this.id,
    this.name,
    this.referCode,
    this.email,
    this.mobile,
    this.appStatus,
    this.officerId,
    this.documentType,
    this.adharNo,
    this.gender,
    this.visiteTime,
    this.visiteDuration,
    this.services,
    this.officerDetail,this.image,this.status
  });

  int id;
  String name;
  String referCode;
  String email;
  String mobile;
  String appStatus;
  int officerId;
  String documentType;
  String adharNo;
  String gender;
  String visiteTime;
  String visiteDuration;
  String services;
  String image;int status;
  OfficerDetail officerDetail;

  factory Upcoming.fromJson(Map<String, dynamic> json) => Upcoming(
    id: json["id"],
    name: json["name"],
    referCode: json["refer_code"],
    email: json["email"],
    mobile: json["mobile"],
    appStatus: json["app_status"],
    officerId: json["officer_id"],
    status: json["status"],
    image: json["image"],
    documentType: json["document_type"] == null ? null : json["document_type"],
    adharNo: json["adhar_no"] == null ? null : json["adhar_no"],
    gender: json["gender"] == null ? null : json["gender"],
    visiteTime: json["visite_time"],
    visiteDuration: json["visite_duration"],
    services: json["services"] == null ? null : json["services"],
    officerDetail: OfficerDetail.fromJson(json["officer_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "refer_code": referCode,
    "email": email,
    "mobile": mobile,
    "image": image,
    "app_status": appStatus,
    "officer_id": officerId,
    "document_type": documentType == null ? null : documentType,
    "adhar_no": adharNo == null ? null : adharNo,
    "gender": gender == null ? null : gender,
    "visite_time": visiteTime,
    "status": status,
    "visite_duration": visiteDuration,
    "services": services == null ? null : services,
    "officer_detail": officerDetail.toJson(),
  };
}

class OfficerDetail {
  OfficerDetail({
    this.id,
    this.name,
  });

  int id;
  Name name;

  factory OfficerDetail.fromJson(Map<String, dynamic> json) => OfficerDetail(
    id: json["id"],
    name: nameValues.map[json["name"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nameValues.reverse[name],
  };
}

enum Name { HIMANSHU_VERMA }

final nameValues = EnumValues({
  "Himanshu verma": Name.HIMANSHU_VERMA
});

class GuardDetails {
  GuardDetails({
    this.id,
    this.name,
    this.companyId,
    this.mobile,
  });

  int id;
  String name;
  String companyId;
  String mobile;

  factory GuardDetails.fromJson(Map<String, dynamic> json) => GuardDetails(
    id: json["id"],
    name: json["name"],
    companyId: json["company_id"],
    mobile: json["mobile"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "company_id": companyId,
    "mobile": mobile,
  };
}

class PreInviteVisitor {
  PreInviteVisitor({
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
    this.officerDetail,
  });

  int id;
  String name;
  String mobile;
  String preVisitDateTime;
  String email;
  int status;
  String image;
  String services;
  String referCode;
  int addedBy;
  DateTime createdAt;
  int officerId;
  String appStatus;
  OfficerDetail officerDetail;

  factory PreInviteVisitor.fromJson(Map<String, dynamic> json) => PreInviteVisitor(
    id: json["id"],
    name: json["name"],
    mobile: json["mobile"],
    preVisitDateTime: json["pre_visit_date_time"],
    email: json["email"],
    status: json["status"],
    image: json["image"],
    services: json["services"] == null ? null : json["services"],
    referCode: json["refer_code"],
    addedBy: json["added_by"],
    createdAt: DateTime.parse(json["created_at"]),
    officerId: json["officer_id"],
    appStatus: json["app_status"],
    officerDetail: OfficerDetail.fromJson(json["officer_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile": mobile,
    "pre_visit_date_time": preVisitDateTime,
    "email": email,
    "status": status,
    "image": image,
    "services": services == null ? null : services,
    "refer_code": referCode,
    "added_by": addedBy,
    "created_at": createdAt.toIso8601String(),
    "officer_id": officerId,
    "app_status": appStatus,
    "officer_detail": officerDetail.toJson(),
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
