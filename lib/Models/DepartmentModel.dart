// To parse this JSON data, do
//
//     final departmentModel = departmentModelFromJson(jsonString);

import 'dart:convert';

class DepartmentModel {
  DepartmentModel({
    this.status,
    this.date,
  });

  String status;
  List<DepartmentData> date;

  DepartmentModel.fromJson(Map<String, dynamic> json) {
    List data = [];
    status = json["status"];
    data = json["date"] as List ?? [];
    date =  data.map((e) => DepartmentData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "date": List<dynamic>.from(date.map((x) => x.toJson())),
  };
}

class DepartmentData {
  DepartmentData({
    this.id,
    this.name,
    this.buildingId,
    this.locationId,
    this.companyId,
    this.status,
  });

  int id;
  String name;
  int buildingId;
  int locationId;
  String companyId;
  int status;

  DepartmentData.fromJson(Map<String, dynamic> json) {
    id= json["id"];
    name= json["name"];
    buildingId= json["building_id"];
    locationId= json["location_id"];
    companyId= json["company_id"];
    status= json["status"];
  }

  Map<String, dynamic> toJson()  {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    data["building_id"] = buildingId;
    data["location_id"] = locationId;
    data["company_id"] = companyId;
    data["status"] = status;
  }
}
