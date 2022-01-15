import 'dart:convert';

DataVerify dataVerifyFromJson(String str) => DataVerify.fromJson(json.decode(str));

String dataVerifyToJson(DataVerify data) => json.encode(data.toJson());

class DataVerify {
  DataVerify({
    this.message,
    this.dataVerifyClass,
    this.data,
  });

  String message;
  String dataVerifyClass;
  Data data;

  factory DataVerify.fromJson(Map<String, dynamic> json) => DataVerify(
    message: json["message"],
    dataVerifyClass: json["class"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "class": dataVerifyClass,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.companyId,
    this.referCode,
    this.preInvitePin,
    this.preVisitDateTime,
    this.image,
  });

  int id;
  String name;
  String email;
  String mobile;
  String companyId;
  String referCode;
  int preInvitePin;
  String preVisitDateTime;
  String image;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    companyId: json["company_id"],
    referCode: json["refer_code"],
    preInvitePin: json["pre_invite_pin"],
    preVisitDateTime: json["pre_visit_date_time"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile": mobile,
    "company_id": companyId,
    "refer_code": referCode,
    "pre_invite_pin": preInvitePin,
    "pre_visit_date_time": preVisitDateTime,
    "image": image,
  };
}
