import 'dart:convert';

KnowStatusModel knowStatusModelFromJson(String str) => KnowStatusModel.fromJson(json.decode(str));

String knowStatusModelToJson(KnowStatusModel data) => json.encode(data.toJson());

class KnowStatusModel {
  KnowStatusModel({
    this.status,
    this.msg,
    this.data,
  });

  String status;
  String msg;
  List<KnowStatusData> data;

  factory KnowStatusModel.fromJson(Map<String, dynamic> json) => KnowStatusModel(
    status: json["status"],
    msg: json["msg"],
    data: List<KnowStatusData>.from(json["data"].map((x) => KnowStatusData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class KnowStatusData {
  KnowStatusData({
    this.visitId,
    this.visitorId,
    this.status,
    this.office,
    this.name,
    this.mobile,
    this.gender,
    this.purpose,
    this.email,
    this.idNo,
    this.visitType,
    this.officerDepartment,
    this.visitorGroup,
  });

  int visitId;
  String visitorId;
  String status;
  String office;
  String name;
  String mobile;
  String gender;
  String purpose;
  String email;
  String idNo;
  String visitType;
  String officerDepartment;
  List<dynamic> visitorGroup;

  factory KnowStatusData.fromJson(Map<String, dynamic> json) => KnowStatusData(
    visitId: json["visit_id"],
    visitorId: json["Visitor_id"],
    status: json["status"],
    office: json["office"],
    name: json["name"],
    mobile: json["mobile"],
    gender: json["gender"],
    purpose: json["purpose"],
    email: json["email"],
    idNo: json["id_no"] == null ? null : json["id_no"],
    visitType: json["visit_type"],
    officerDepartment: json["officer_department"],
    visitorGroup: List<dynamic>.from(json["visitor_group"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "visit_id": visitId,
    "Visitor_id": visitorId,
    "status": status,
    "office": office,
    "name": name,
    "mobile": mobile,
    "gender": gender,
    "purpose": purpose,
    "email": email,
    "id_no": idNo == null ? null : idNo,
    "visit_type": visitType,
    "officer_department": officerDepartment,
    "visitor_group": List<dynamic>.from(visitorGroup.map((x) => x)),
  };
}
