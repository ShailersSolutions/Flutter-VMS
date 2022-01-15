import 'dart:convert';

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

String cityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  CityModel({
    this.status,
    this.date,
  });

  String status;
  List<Date> date;

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
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
    this.name,
    this.stateId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  int stateId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
    id: json["id"],
    name: json["name"],
    stateId: json["state_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "state_id": stateId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
