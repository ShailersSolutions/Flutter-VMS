// To parse this JSON data, do
//
//     final currentVisitorModel = currentVisitorModelFromJson(jsonString);

import 'dart:convert';

CurrentVisitorModel currentVisitorModelFromJson(String str) => CurrentVisitorModel.fromJson(json.decode(str));

String currentVisitorModelToJson(CurrentVisitorModel data) => json.encode(data.toJson());

class CurrentVisitorModel {
  CurrentVisitorModel({
    this.status,
    this.msg,
    this.data,
  });

  String status;
  String msg;
  List<CurrentData> data;

  factory CurrentVisitorModel.fromJson(Map<String, dynamic> json) => CurrentVisitorModel(
    status: json["status"],
    msg: json["msg"],
    data: List<CurrentData>.from(json["data"].map((x) => CurrentData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CurrentData {
  CurrentData({
    this.id,
    this.name,
    this.type,
    this.officerId,
    this.companyId,
    this.documentType,
    this.adharNo,
    this.mobile,
    this.email,
    this.referCode,
    this.gender,
    this.image,
    this.addedBy,
    this.updateBy,
    this.status,
    this.appStatus,
    this.visiteTime,
    this.preVisitDateTime,
    this.employeeUniqueId,
    this.imageBase,
    this.vaccine,
    this.vaccineName,
    this.vaccineCount,
    this.symptoms,
    this.travelledStates,
    this.patient,
    this.temprature,
    this.departmentId,
    this.locationId,
    this.countryId,
    this.buildingId,
    this.stateId,
    this.cityId,
    this.pincode,
    this.address1,
    this.address2,
    this.orgaCountryId,
    this.orgaStateId,
    this.orgaCityId,
    this.orgaPincode,
    this.organizationName,
    this.visiteDuration,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.services,
    this.attachmant,
    this.attachmantBase,
    this.vehicalType,
    this.vehicalRegNum,
    this.assetsName,
    this.assetsNumber,
    this.assetsBrand,
    this.carryingDevice,
    this.panDrive,
    this.hardDisk,
    this.visitType,
    this.visitorGroup,
    this.officerDetail,
    this.officerDepartment,
    this.country,
    this.state,
    this.city,
    this.location,
    this.building,
    this.orgaCountry,
    this.orgaState,
    this.orgaCity,
    this.allVisit,
  });

  int id;
  String name;
  Type type;
  int officerId;
  String companyId;
  String documentType;
  String adharNo;
  String mobile;
  String email;
  String referCode;
  Gender gender;
  String image;
  int addedBy;
  int updateBy;
  int status;
  AppStatus appStatus;
  String visiteTime;
  dynamic preVisitDateTime;
  String employeeUniqueId;
  String imageBase;
  String vaccine;
  VaccineName vaccineName;
  String vaccineCount;
  Symptoms symptoms;
  Patient travelledStates;
  Patient patient;
  String temprature;
  String departmentId;
  int locationId;
  int countryId;
  int buildingId;
  int stateId;
  int cityId;
  String pincode;
  String address1;
  String address2;
  int orgaCountryId;
  int orgaStateId;
  int orgaCityId;
  dynamic orgaPincode;
  String organizationName;
  String visiteDuration;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  Services services;
  String attachmant;
  String attachmantBase;
  VehicalType vehicalType;
  String vehicalRegNum;
  AssetsName assetsName;
  String assetsNumber;
  AssetsBrand assetsBrand;
  String carryingDevice;
  String panDrive;
  String hardDisk;
  VisitType visitType;
  List<dynamic> visitorGroup;
  OfficerDetail officerDetail;
  var officerDepartment;
  var country;
  var state;
  var city;
  var location;
  var building;
  var orgaCountry;
  var orgaState;
  var orgaCity;
  AllVisit allVisit;

  CurrentData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    type = typeValues.map[json["type"]];
    officerId = json["officer_id"];
    companyId = json["company_id"];
    documentType = json["document_type"];
    adharNo = json["adhar_no"];
    mobile = json["mobile"];
    email = json["email"];
    referCode = json["refer_code"];
    gender = genderValues.map[json["gender"]];
    image = json["image"];
    addedBy = json["added_by"];
    updateBy = json["update_by"];
    status = json["status"];
    appStatus = appStatusValues.map[json["app_status"]];
    visiteTime = json["visite_time"] == null ? null : json["visite_time"];
    preVisitDateTime = json["pre_visit_date_time"];
    employeeUniqueId = json["employee_unique_id"] == null ? null : json["employee_unique_id"];
    imageBase = json["image_base"] == null ? null : json["image_base"];
    vaccine = json["vaccine"];
    vaccineName = vaccineNameValues.map[json["vaccine_name"]];
    vaccineCount = json["vaccine_count"];
    symptoms = symptomsValues.map[json["symptoms"]];
    travelledStates = patientValues.map[json["travelled_states"]];
    patient = patientValues.map[json["patient"]];
    temprature = json["temprature"];
    departmentId = json["department_id"];
    locationId = json["location_id"];
    countryId = json["country_id"];
    buildingId = json["building_id"];
    stateId = json["state_id"];
    cityId = json["city_id"];
    pincode = json["pincode"] == null ? null : json["pincode"];
    address1 = json["address_1"] == null ? null : json["address_1"];
    address2 = json["address_2"] == null ? null : json["address_2"];
    orgaCountryId = json["orga_country_id"] == null ? null : json["orga_country_id"];
    orgaStateId = json["orga_state_id"] == null ? null : json["orga_state_id"];
    orgaCityId = json["orga_city_id"] == null ? null : json["orga_city_id"];
    orgaPincode = json["orga_pincode"];
    organizationName = json["organization_name"];
    visiteDuration = json["visite_duration"];
    createdAt = DateTime.parse(json["created_at"]);
    updatedAt = DateTime.parse(json["updated_at"]);
    deletedAt = json["deleted_at"];
    services = servicesValues.map[json["services"]];
    attachmant = json["attachmant"] == null ? null : json["attachmant"];
    attachmantBase = json["attachmant_base"] == null ? null : json["attachmant_base"];
    vehicalType = json["vehical_type"] == null ? null : vehicalTypeValues.map[json["vehical_type"]];
    vehicalRegNum = json["vehical_reg_num"] == null ? null : json["vehical_reg_num"];
    assetsName = assetsNameValues.map[json["assets_name"]];
    assetsNumber = json["assets_number"];
    assetsBrand = assetsBrandValues.map[json["assets_brand"]];
    carryingDevice = json["carrying_device"] == null ? null : json["carrying_device"];
    panDrive = json["pan_drive"] == null ? null : json["pan_drive"];
    hardDisk = json["hard_disk"] == null ? null : json["hard_disk"];
    visitType = visitTypeValues.map[json["visit_type"]];
    visitorGroup = List<dynamic>.from(json["visitor_group"].map((x) => x));
    officerDetail = OfficerDetail.fromJson(json["officer_detail"]) ?? null;
    if(json['country_id'] != null){
    officerDepartment = Building.fromJson(json["officer_department"]) ?? null;
    country = Building.fromJson(json["country"]) ?? null;
    if(json['state_id'] != null){
      state = Building.fromJson(json["state"]) ?? null;
      if(json['city_id'] != null){
        city = Building.fromJson(json["city"]) ?? null;
      }
      city = Building.fromJson(json["city"]) ?? null;
    }

    location = Building.fromJson(json["location"]) ?? null;
    building = Building.fromJson(json["building"]) ?? null;
    }
    if(json['orga_country_id'] != null && json["orga_country_id"] != 0){
      orgaCountry = Building.fromJson(json["orga_country"]) ?? null;
      if(json['orga_state_id'] != null && json["orga_state_id"] != 0){
        orgaState = Building.fromJson(json["orga_state"]) ?? null;
        if(json['orga_city_id'] != null && json["orga_city_id"] != 0) {
          orgaCity = Building.fromJson(json["orga_city"]) ?? null;
        }
      }
    }

    allVisit =  AllVisit.fromJson(json["all_visit"])??null ;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": typeValues.reverse[type],
    "officer_id": officerId,
    "company_id": companyId,
    "document_type": documentType,
    "adhar_no": adharNo,
    "mobile": mobile,
    "email": email,
    "refer_code": referCode,
    "gender": genderValues.reverse[gender],
    "image": image,
    "added_by": addedBy,
    "update_by": updateBy,
    "status": status,
    "app_status": appStatusValues.reverse[appStatus],
    "visite_time": visiteTime == null ? null : visiteTime,
    "pre_visit_date_time": preVisitDateTime,
    "employee_unique_id": employeeUniqueId == null ? null : employeeUniqueId,
    "image_base": imageBase == null ? null : imageBase,
    "vaccine": vaccine,
    "vaccine_name": vaccineNameValues.reverse[vaccineName],
    "vaccine_count": vaccineCount,
    "symptoms": symptomsValues.reverse[symptoms],
    "travelled_states": patientValues.reverse[travelledStates],
    "patient": patientValues.reverse[patient],
    "temprature": temprature,
    "department_id": departmentId,
    "location_id": locationId,
    "country_id": countryId,
    "building_id": buildingId,
    "state_id": stateId,
    "city_id": cityId,
    "pincode": pincode == null ? null : pincode,
    "address_1": address1 == null ? null : address1,
    "address_2": address2 == null ? null : address2,
    "orga_country_id": orgaCountryId,
    "orga_state_id": orgaStateId,
    "orga_city_id": orgaCityId,
    "orga_pincode": orgaPincode,
    "organization_name": organizationName,
    "visite_duration": visiteDuration,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "services": servicesValues.reverse[services],
    "attachmant": attachmant == null ? null : attachmant,
    "attachmant_base": attachmantBase == null ? null : attachmantBase,
    "vehical_type": vehicalType == null ? null : vehicalTypeValues.reverse[vehicalType],
    "vehical_reg_num": vehicalRegNum == null ? null : vehicalRegNum,
    "assets_name": assetsNameValues.reverse[assetsName],
    "assets_number": assetsNumber,
    "assets_brand": assetsBrandValues.reverse[assetsBrand],
    "carrying_device": carryingDevice == null ? null : carryingDevice,
    "pan_drive": panDrive == null ? null : panDrive,
    "hard_disk": hardDisk == null ? null : hardDisk,
    "visit_type": visitTypeValues.reverse[visitType],
    "visitor_group": List<dynamic>.from(visitorGroup.map((x) => x)),
    "officer_detail": officerDetail.toJson(),
    "officer_department": officerDepartment.toJson(),
    "country": country.toJson(),
    "state": state.toJson(),
    "city": city.toJson(),
    "location": location.toJson(),
    "building": building.toJson(),
    "orga_country": orgaCountry.toJson(),
    "orga_state": orgaState.toJson(),
    "orga_city": orgaCity.toJson(),
      "all_visit": allVisit.toJson(),
  };
}

class AllVisit {
  AllVisit({
    this.id,
    this.userId,
    this.inTime,
    this.inDevice,
    this.inStatus,
    this.outDevice,
    this.outTime,
    this.outStatus,
  });

  int id;
  int userId;
  DateTime inTime;
  Device inDevice;
  Status inStatus;
  Device outDevice;
  DateTime outTime;
  Status outStatus;

  factory AllVisit.fromJson(Map<String, dynamic> json) => AllVisit(
    id: json["id"],
    userId: json["user_id"],
    inTime: DateTime.parse(json["in_time"]),
    inDevice: deviceValues.map[json["in_device"]],
    inStatus: statusValues.map[json["in_status"]],
    outDevice: json["out_device"] == null ? null : deviceValues.map[json["out_device"]],
    outTime: DateTime.parse(json["out_time"]),
    outStatus: statusValues.map[json["out_status"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "in_time": inTime.toIso8601String(),
    "in_device": deviceValues.reverse[inDevice],
    "in_status": statusValues.reverse[inStatus],
    "out_device": outDevice == null ? null : deviceValues.reverse[outDevice],
    "out_time": outTime.toIso8601String(),
    "out_status": statusValues.reverse[outStatus],
  };
}

enum Device { NA }

final deviceValues = EnumValues({
  "NA": Device.NA
});

enum Status { YES, NO }

final statusValues = EnumValues({
  "No": Status.NO,
  "Yes": Status.YES
});

enum AppStatus { APPROVE, PENDING }

final appStatusValues = EnumValues({
  "Approve": AppStatus.APPROVE,
  "Pending": AppStatus.PENDING
});

enum AssetsBrand { HP, EMPTY, ACER }

final assetsBrandValues = EnumValues({
  "Acer": AssetsBrand.ACER,
  "": AssetsBrand.EMPTY,
  "hp": AssetsBrand.HP
});

enum AssetsName { LAPTOP, EMPTY, ASSETS_NAME_LAPTOP }

final assetsNameValues = EnumValues({
  "Laptop": AssetsName.ASSETS_NAME_LAPTOP,
  "": AssetsName.EMPTY,
  "laptop": AssetsName.LAPTOP
});

class Building {
  Building({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Building.fromJson(Map<String, dynamic> json) => Building(
    id: json["id"] == null ? "null" : json["id"],
    name: json["name"] == null ? "null": json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}


enum Gender { MALE, GENDER_MALE, FEMALE }

final genderValues = EnumValues({
  "female": Gender.FEMALE,
  "male": Gender.GENDER_MALE,
  "Male": Gender.MALE
});

class OfficerDetail {
  OfficerDetail({
    this.id,
    this.name,
    this.email,
    this.mobile,
  });

  int id;
  String name;
  String email;
  String mobile;

  factory OfficerDetail.fromJson(Map<String, dynamic> json) => OfficerDetail(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile": mobile,
  };
}



enum Patient { NO, YES }

final patientValues = EnumValues({
  "no": Patient.NO,
  "yes": Patient.YES
});

enum Services { OFFICIAL, PERSONAL }

final servicesValues = EnumValues({
  "Official": Services.OFFICIAL,
  "Personal": Services.PERSONAL
});

enum Symptoms { NONE_OF_THE_ABOVE, FEVER, NO }

final symptomsValues = EnumValues({
  "Fever": Symptoms.FEVER,
  "No": Symptoms.NO,
  "None of the Above": Symptoms.NONE_OF_THE_ABOVE
});

enum Type { VISITOR }

final typeValues = EnumValues({
  "Visitor": Type.VISITOR
});

enum VaccineName { COVISHIELD, COVAXIN }

final vaccineNameValues = EnumValues({
  "Covaxin": VaccineName.COVAXIN,
  "Covishield": VaccineName.COVISHIELD
});

enum VehicalType { THE_2_WHEELER, VEHICAL_TYPE_2_WHEELER }

final vehicalTypeValues = EnumValues({
  "2 wheeler": VehicalType.THE_2_WHEELER,
  "2 Wheeler": VehicalType.VEHICAL_TYPE_2_WHEELER
});

enum VisitType { SINGLE }

final visitTypeValues = EnumValues({
  "single": VisitType.SINGLE
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
