// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

CountryModel countryModelFromJson(String str) => CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  CountryModel({
    this.status,
    this.date,
  });

  String status;
  List<CountryData> date;

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    status: json["status"],
    date: List<CountryData>.from(json["date"].map((x) => CountryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "date": List<dynamic>.from(date.map((x) => x.toJson())),
  };
}

class CountryData {
  CountryData({
    this.id,
    this.sortname,
    this.name,
    this.phonecode,
    this.createdAt,
    this.updatedAt,
  });

 final int id;
 final String sortname;
 final String name;
 final int phonecode;
 final DateTime createdAt;
 final DateTime updatedAt;

  factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
    id: json["id"],
    sortname: json["sortname"],
    name: json["name"],
    phonecode: json["phonecode"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sortname": sortname,
    "name": name,
    "phonecode": phonecode,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
