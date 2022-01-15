import 'dart:convert';

StateModel stateModelFromJson(String str) => StateModel.fromJson(json.decode(str));

String stateModelToJson(StateModel data) => json.encode(data.toJson());

class StateModel {
  StateModel({
    this.status,
    this.date,
  });

  String status;
  List<Date> date;

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
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
    this.countryId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  int countryId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
    id: json["id"],
    name: json["name"],
    countryId: json["country_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country_id": countryId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
