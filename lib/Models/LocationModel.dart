// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';


class LocationModel {
  LocationModel({
    this.status,
    this.date,
  });

  String status;
  List<Date> date = [];

  LocationModel.fromJson(Map<String, dynamic> json) {
    List data = [];
    status = json["status"];
    data = json["date"] as List ?? [];
    date =  data.map((e) => Date.fromJson(e)).toList();
  }

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
    this.stateId,
    this.companyId,
    this.longitude,
    this.latitude,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  int countryId;
  int stateId;
  String companyId;
  String longitude;
  String latitude;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

   Date.fromJson(Map<String, dynamic> json) {
     id = json["id"];
     name= json["name"];
     countryId= json["country_id"];
     stateId= json["state_id"];
     companyId= json["company_id"];
     longitude= json["longitude"];
     latitude= json["latitude"];
     status= json["status"];
     createdAt= DateTime.parse(json["created_at"]);
     updatedAt= DateTime.parse(json["updated_at"]);
   }

  Map<String, dynamic> toJson()  {
     final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"]= id;
    data["name"]= name;
    data["country_id"]= countryId;
    data["state_id"]= stateId;
    data["company_id"]= companyId;
    data["longitude"]= longitude;
    data["latitude"]= latitude;
   data["status"]= status;
   data["created_at"]= createdAt.toIso8601String();
    data["updated_at"]= updatedAt.toIso8601String();
  }
}
