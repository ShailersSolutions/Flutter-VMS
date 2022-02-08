// To parse this JSON data, do
//
//     final otpVerifyModel = otpVerifyModelFromJson(jsonString);

import 'dart:convert';

import 'package:facechk_app/Models/re_visit_model.dart';

OtpVerifyModel otpVerifyModelFromJson(String str) => OtpVerifyModel.fromJson(json.decode(str));

String otpVerifyModelToJson(OtpVerifyModel data) => json.encode(data.toJson());

class OtpVerifyModel {
  OtpVerifyModel({
    this.status,
    this.msg,
    this.purpose,this.data
  });

  String status;
  String msg;
  String purpose;
  List<RevisitData> data;

  OtpVerifyModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    msg = json["msg"];
    purpose = json["purpose"];
    if(json['data'] != []){
      data = List<RevisitData>.from(json["data"].map((x) => RevisitData.fromJson(x)));
    }
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "purpose": purpose,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
