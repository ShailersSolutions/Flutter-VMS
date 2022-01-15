// To parse this JSON data, do
//
//     final allVisitorsListModel = allVisitorsListModelFromJson(jsonString);

import 'dart:convert';

AllVisitorsListModel allVisitorsListModelFromJson(String str) => AllVisitorsListModel.fromJson(json.decode(str));

String allVisitorsListModelToJson(AllVisitorsListModel data) => json.encode(data.toJson());

class AllVisitorsListModel {
  AllVisitorsListModel({
    this.status,
    this.msg,
    this.data,
  });

  String status;
  String msg;
  List<AllVisitorData> data;

  factory AllVisitorsListModel.fromJson(Map<String, dynamic> json) => AllVisitorsListModel(
    status: json["status"],
    msg: json["msg"],
    data: List<AllVisitorData>.from(json["data"].map((x) => AllVisitorData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class AllVisitorData {
  AllVisitorData({
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
  String type;
  int officerId;
  CompanyId companyId;
  DocumentType documentType;
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
  String preVisitDateTime;
  String employeeUniqueId;
  String imageBase;
  Patient vaccine;
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
  var orgaCountryId;
  var orgaStateId;
  var orgaCityId;
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
  String assetsName;
  String assetsNumber;
  String assetsBrand;
  String carryingDevice;
  String panDrive;
  String hardDisk;
  VisitType visitType;
  List<dynamic> visitorGroup;
  OfficerDetail officerDetail;
  Building officerDepartment;
  Building country;
  Building state;
  Building city;
  Building location;
  Building building;
  Building orgaCountry;
  Building orgaState;
  Building orgaCity;
  AllVisit allVisit;

  factory AllVisitorData.fromJson(Map<String, dynamic> json) => AllVisitorData(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    officerId: json["officer_id"],
    companyId: companyIdValues.map[json["company_id"]],
    documentType: json["document_type"] == null ? null : documentTypeValues.map[json["document_type"]],
    adharNo: json["adhar_no"] == null ? null : json["adhar_no"],
    mobile: json["mobile"],
    email: json["email"],
    referCode: json["refer_code"] == null ? null : json["refer_code"],
    gender: json["gender"] == null ? null : genderValues.map[json["gender"]],
    image: json["image"] == null ? null : json["image"],
    addedBy: json["added_by"] == null ? null : json["added_by"],
    updateBy: json["update_by"] == null ? null : json["update_by"],
    status: json["status"],
    appStatus: appStatusValues.map[json["app_status"]],
    visiteTime: json["visite_time"] == null ? null : json["visite_time"],
    preVisitDateTime: json["pre_visit_date_time"] == null ? null : json["pre_visit_date_time"],
    employeeUniqueId: json["employee_unique_id"] == null ? null : json["employee_unique_id"],
    imageBase: json["image_base"] == null ? null : json["image_base"],
    vaccine: json["vaccine"] == null ? null : patientValues.map[json["vaccine"]],
    vaccineName: json["vaccine_name"] == null ? null : vaccineNameValues.map[json["vaccine_name"]],
    vaccineCount: json["vaccine_count"] == null ? null : json["vaccine_count"],
    symptoms: json["symptoms"] == null ? null : symptomsValues.map[json["symptoms"]],
    travelledStates: json["travelled_states"] == null ? null : patientValues.map[json["travelled_states"]],
    patient: json["patient"] == null ? null : patientValues.map[json["patient"]],
    temprature: json["temprature"] == null ? null : json["temprature"],
    departmentId: json["department_id"] == null ? null : json["department_id"],
    locationId: json["location_id"] == null ? null : json["location_id"],
    countryId: json["country_id"] == null ? null : json["country_id"],
    buildingId: json["building_id"] == null ? null : json["building_id"],
    stateId: json["state_id"] == null ? null : json["state_id"],
    cityId: json["city_id"] == null ? null : json["city_id"],
    pincode: json["pincode"] == null ? null : json["pincode"],
    address1: json["address_1"] == null ? null : json["address_1"],
    address2: json["address_2"] == null ? null : json["address_2"],
    orgaCountryId: json["orga_country_id"] == null ? null : json["orga_country_id"],
    orgaStateId: json["orga_state_id"] == null ? null : json["orga_state_id"],
    orgaCityId: json["orga_city_id"] == null ? null : json["orga_city_id"],
    orgaPincode: json["orga_pincode"],
    organizationName: json["organization_name"] == null ? null : json["organization_name"],
    visiteDuration: json["visite_duration"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    services: json["services"] == null ? null : servicesValues.map[json["services"]],
    attachmant: json["attachmant"] == null ? null : json["attachmant"],
    attachmantBase: json["attachmant_base"] == null ? null : json["attachmant_base"],
    vehicalType: json["vehical_type"] == null ? null : vehicalTypeValues.map[json["vehical_type"]],
    vehicalRegNum: json["vehical_reg_num"] == null ? null : json["vehical_reg_num"],
    assetsName: json["assets_name"] == null ? null : json["assets_name"],
    assetsNumber: json["assets_number"] == null ? null : json["assets_number"],
    assetsBrand: json["assets_brand"] == null ? null : json["assets_brand"],
    carryingDevice: json["carrying_device"] == null ? null : json["carrying_device"],
    panDrive: json["pan_drive"] == null ? null : json["pan_drive"],
    hardDisk: json["hard_disk"] == null ? null : json["hard_disk"],
    visitType: visitTypeValues.map[json["visit_type"]],
    visitorGroup: List<dynamic>.from(json["visitor_group"].map((x) => x)),
    officerDetail: OfficerDetail.fromJson(json["officer_detail"]),
    officerDepartment: json["officer_department"] == null ? null : Building.fromJson(json["officer_department"]),
    country: json["country"] == null ? null : Building.fromJson(json["country"]),
    state: json["state"] == null ? null : Building.fromJson(json["state"]),
    city: json["city"] == null ? null : Building.fromJson(json["city"]),
    location: json["location"] == null ? null : Building.fromJson(json["location"]),
    building: json["building"] == null ? null : Building.fromJson(json["building"]),
    orgaCountry: json["orga_country"] == null ? null : Building.fromJson(json["orga_country"]),
    orgaState: json["orga_state"] == null ? null : Building.fromJson(json["orga_state"]),
    orgaCity: json["orga_city"] == null ? null : Building.fromJson(json["orga_city"]),
    allVisit: json["all_visit"] == null ? null : AllVisit.fromJson(json["all_visit"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "officer_id": officerId,
    "company_id": companyIdValues.reverse[companyId],
    "document_type": documentType == null ? null : documentTypeValues.reverse[documentType],
    "adhar_no": adharNo == null ? null : adharNo,
    "mobile": mobile,
    "email": email,
    "refer_code": referCode == null ? null : referCode,
    "gender": gender == null ? null : genderValues.reverse[gender],
    "image": image == null ? null : image,
    "added_by": addedBy == null ? null : addedBy,
    "update_by": updateBy == null ? null : updateBy,
    "status": status,
    "app_status": appStatusValues.reverse[appStatus],
    "visite_time": visiteTime == null ? null : visiteTime,
    "pre_visit_date_time": preVisitDateTime == null ? null : preVisitDateTime,
    "employee_unique_id": employeeUniqueId == null ? null : employeeUniqueId,
    "image_base": imageBase == null ? null : imageBase,
    "vaccine": vaccine == null ? null : patientValues.reverse[vaccine],
    "vaccine_name": vaccineName == null ? null : vaccineNameValues.reverse[vaccineName],
    "vaccine_count": vaccineCount == null ? null : vaccineCount,
    "symptoms": symptoms == null ? null : symptomsValues.reverse[symptoms],
    "travelled_states": travelledStates == null ? null : patientValues.reverse[travelledStates],
    "patient": patient == null ? null : patientValues.reverse[patient],
    "temprature": temprature == null ? null : temprature,
    "department_id": departmentId == null ? null : departmentId,
    "location_id": locationId == null ? null : locationId,
    "country_id": countryId == null ? null : countryId,
    "building_id": buildingId == null ? null : buildingId,
    "state_id": stateId == null ? null : stateId,
    "city_id": cityId == null ? null : cityId,
    "pincode": pincode == null ? null : pincode,
    "address_1": address1 == null ? null : address1,
    "address_2": address2 == null ? null : address2,
    "orga_country_id": orgaCountryId == null ? null : orgaCountryId,
    "orga_state_id": orgaStateId == null ? null : orgaStateId,
    "orga_city_id": orgaCityId == null ? null : orgaCityId,
    "orga_pincode": orgaPincode,
    "organization_name": organizationName == null ? null : organizationName,
    "visite_duration": visiteDuration,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "services": services == null ? null : servicesValues.reverse[services],
    "attachmant": attachmant == null ? null : attachmant,
    "attachmant_base": attachmantBase == null ? null : attachmantBase,
    "vehical_type": vehicalType == null ? null : vehicalTypeValues.reverse[vehicalType],
    "vehical_reg_num": vehicalRegNum == null ? null : vehicalRegNum,
    "assets_name": assetsName == null ? null : assetsName,
    "assets_number": assetsNumber == null ? null : assetsNumber,
    "assets_brand": assetsBrand == null ? null : assetsBrand,
    "carrying_device": carryingDevice == null ? null : carryingDevice,
    "pan_drive": panDrive == null ? null : panDrive,
    "hard_disk": hardDisk == null ? null : hardDisk,
    "visit_type": visitTypeValues.reverse[visitType],
    "visitor_group": List<dynamic>.from(visitorGroup.map((x) => x)),
    "officer_detail": officerDetail.toJson(),
    "officer_department": officerDepartment == null ? null : officerDepartment.toJson(),
    "country": country == null ? null : country.toJson(),
    "state": state == null ? null : state.toJson(),
    "city": city == null ? null : city.toJson(),
    "location": location == null ? null : location.toJson(),
    "building": building == null ? null : building.toJson(),
    "orga_country": orgaCountry == null ? null : orgaCountry.toJson(),
    "orga_state": orgaState == null ? null : orgaState.toJson(),
    "orga_city": orgaCity == null ? null : orgaCity.toJson(),
    "all_visit": allVisit == null ? null : allVisit.toJson(),
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
  String inTime;
  Device inDevice;
  Status inStatus;
  Device outDevice;
  String outTime;
  Status outStatus;

  factory AllVisit.fromJson(Map<String, dynamic> json) => AllVisit(
    id: json["id"],
    userId: json["user_id"],
    inTime: json["in_time"],
    inDevice: json["in_device"] == null ? null : deviceValues.map[json["in_device"]],
    inStatus: statusValues.map[json["in_status"]],
    outDevice: json["out_device"] == null ? null : deviceValues.map[json["out_device"]],
    outTime: json["out_time"],
    outStatus: statusValues.map[json["out_status"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "in_time": inTime,
    "in_device": inDevice == null ? null : deviceValues.reverse[inDevice],
    "in_status": statusValues.reverse[inStatus],
    "out_device": outDevice == null ? null : deviceValues.reverse[outDevice],
    "out_time": outTime,
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

class Building {
  Building({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Building.fromJson(Map<String, dynamic> json) => Building(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

enum CompanyId { CID9 }

final companyIdValues = EnumValues({
  "CID9": CompanyId.CID9
});

enum DocumentType { GOVT_ID_PF, ADHAR_CARD, DL }

final documentTypeValues = EnumValues({
  "adhar_card": DocumentType.ADHAR_CARD,
  "dl": DocumentType.DL,
  "govt_id_pf": DocumentType.GOVT_ID_PF
});

enum Gender { MALE, FEMALE, GENDER_MALE }

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

// enum Email { PREEASHI_GMAIL_COM }
//
// final emailValues = EnumValues({
//   "preeashi@gmail.com": Email.PREEASHI_GMAIL_COM
// });

// enum Name { HIMANSHU_VERMA }
//
// final nameValues = EnumValues({
//   "Himanshu verma": Name.HIMANSHU_VERMA
// });

enum Patient { YES, NO }

final patientValues = EnumValues({
  "no": Patient.NO,
  "yes": Patient.YES
});

enum Services { OFFICIAL, PERSONAL }

final servicesValues = EnumValues({
  "Official": Services.OFFICIAL,
  "Personal": Services.PERSONAL
});

enum Symptoms { NONE_OF_THE_ABOVE, FEVER, DIFFICULTY_IN_BREATHING, NO }

final symptomsValues = EnumValues({
  "Difficulty in breathing": Symptoms.DIFFICULTY_IN_BREATHING,
  "Fever": Symptoms.FEVER,
  "No": Symptoms.NO,
  "None of the Above": Symptoms.NONE_OF_THE_ABOVE
});

enum VaccineName { COVISHIELD, COVAXIN, SPUTNIK_V }

final vaccineNameValues = EnumValues({
  "Covaxin": VaccineName.COVAXIN,
  "Covishield": VaccineName.COVISHIELD,
  "Sputnik V": VaccineName.SPUTNIK_V
});

enum VehicalType { THE_2_WHEELER, VEHICAL_TYPE_2_WHEELER, THE_4_WHEELER }

final vehicalTypeValues = EnumValues({
  "2 wheeler": VehicalType.THE_2_WHEELER,
  "4 Wheeler": VehicalType.THE_4_WHEELER,
  "2 Wheeler": VehicalType.VEHICAL_TYPE_2_WHEELER
});

enum VisitType { SINGLE, GROUP }

final visitTypeValues = EnumValues({
  "group": VisitType.GROUP,
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
