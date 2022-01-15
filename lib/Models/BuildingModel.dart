// To parse this JSON data, do
//
//     final buildingModel = buildingModelFromJson(jsonString);

import 'dart:convert';

class BuildingModel {
  BuildingModel({
    this.status,
    this.date,
  });

  String status;
  List<BuildingData> date;

  BuildingModel.fromJson(Map<String, dynamic> json) {
    List data = [];
    status = json["status"];
    data = json["date"] as List ?? [];
    date =  data.map((e) => BuildingData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "date": List<dynamic>.from(date.map((x) => x.toJson())),
  };
}

class BuildingData {
  BuildingData({
    this.id,
    this.name,
    this.locationId,
    this.companyId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  int locationId;
  String companyId;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  BuildingData.fromJson(Map<String, dynamic> json) {
     id= json["id"];
     name= json["name"];
     locationId= json["location_id"];
     companyId= json["company_id"];
     status= json["status"];
     createdAt= DateTime.parse(json["created_at"]);
     updatedAt= DateTime.parse(json["updated_at"]);
   }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    data["location_id"] = locationId;
    data["company_id"] = companyId;
    data["status"] = status;
    data["created_at"] = createdAt.toIso8601String();
    data["updated_at"] = updatedAt.toIso8601String();
  }
}
