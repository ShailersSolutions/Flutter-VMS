// To parse this JSON data, do
//
//     final newRegistrationModel = newRegistrationModelFromJson(jsonString);

import 'dart:convert';

NewRegistrationModel newRegistrationModelFromJson(String str) =>
    NewRegistrationModel.fromJson(json.decode(str));

String newRegistrationModelToJson(NewRegistrationModel data) =>
    json.encode(data.toJson());

class NewRegistrationModel {
  NewRegistrationModel({
    this.message,
    this.status,
    this.visitorId,
  });

  String message;
  String status;
  String visitorId;

  factory NewRegistrationModel.fromJson(Map<String, dynamic> json) =>
      NewRegistrationModel(
        message: json["message"],
        status: json["status"],
        visitorId: json["visitor_id"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "visitor_id": visitorId,
      };
}
