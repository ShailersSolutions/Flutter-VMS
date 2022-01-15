// To parse this JSON data, do
//
//     final otpVerifyModel = otpVerifyModelFromJson(jsonString);

import 'dart:convert';

OtpVerifyModel otpVerifyModelFromJson(String str) => OtpVerifyModel.fromJson(json.decode(str));

String otpVerifyModelToJson(OtpVerifyModel data) => json.encode(data.toJson());

class OtpVerifyModel {
  OtpVerifyModel({
    this.status,
    this.msg,
    this.purpose,
  });

  String status;
  String msg;
  String purpose;

  factory OtpVerifyModel.fromJson(Map<String, dynamic> json) => OtpVerifyModel(
    status: json["status"],
    msg: json["msg"],
    purpose: json["purpose"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "purpose": purpose,
  };
}
