// To parse this JSON data, do
//
//     final revisitModel = revisitModelFromJson(jsonString);

import 'dart:convert';

RevisitModel revisitModelFromJson(String str) => RevisitModel.fromJson(json.decode(str));

String revisitModelToJson(RevisitModel data) => json.encode(data.toJson());

class RevisitModel {
  RevisitModel({
    this.status,
    this.msg,
    this.purpose,
    this.data,
  });

  String status;
  String msg;
  String purpose;
  List<RevisitData> data;

  RevisitModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    msg = json["msg"];
    purpose = json["purpose"];
    data = List<RevisitData>.from(json["data"].map((x) => RevisitData.fromJson(x)));
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "purpose": purpose,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class RevisitData {
  RevisitData({
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
    this.preInvitePin,
    this.requestType,
  });

  int id;
  String name;
  String type;
  int officerId;
  String companyId;
  String documentType;
  dynamic adharNo;
  String mobile;
  String email;
  String referCode;
  String gender;
  String image;
  int addedBy;
  dynamic updateBy;
  int status;
  String appStatus;
  DateTime visiteTime;
  dynamic preVisitDateTime;
  dynamic employeeUniqueId;
  String imageBase;
  String vaccine;
  String vaccineName;
  String vaccineCount;
  String symptoms;
  String travelledStates;
  String patient;
  dynamic temprature;
  String departmentId;
  int locationId;
  int countryId;
  int buildingId;
  int stateId;
  int cityId;
  dynamic pincode;
  dynamic address1;
  dynamic address2;
  int orgaCountryId;
  int orgaStateId;
  int orgaCityId;
  dynamic orgaPincode;
  dynamic organizationName;
  String visiteDuration;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String services;
  String attachmant;
  dynamic attachmantBase;
  dynamic vehicalType;
  dynamic vehicalRegNum;
  dynamic assetsName;
  dynamic assetsNumber;
  dynamic assetsBrand;
  String carryingDevice;
  dynamic panDrive;
  dynamic hardDisk;
  String visitType;
  dynamic preInvitePin;
  int requestType;

  RevisitData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    type = json["type"];
    officerId = json["officer_id"];
    companyId = json["company_id"];
    documentType = json["document_type"];
    adharNo = json["adhar_no"];
    mobile = json["mobile"];
    email = json["email"];
    referCode = json["refer_code"];
    gender = json["gender"];
    image = json["image"];
    addedBy = json["added_by"];
    updateBy = json["update_by"];
    status = json["status"];
    appStatus = json["app_status"];
    visiteTime = DateTime.parse(json["visite_time"]);
    preVisitDateTime = json["pre_visit_date_time"];
    employeeUniqueId = json["employee_unique_id"];
    imageBase = json["image_base"];
    vaccine = json["vaccine"];
    vaccineName = json["vaccine_name"];
    vaccineCount = json["vaccine_count"];
    symptoms = json["symptoms"];
    travelledStates = json["travelled_states"];
    patient = json["patient"];
    temprature = json["temprature"];
    departmentId = json["department_id"];
    locationId = json["location_id"];
    countryId = json["country_id"];
    buildingId = json["building_id"];
    stateId = json["state_id"];
    cityId = json["city_id"];
    pincode = json["pincode"];
    address1 = json["address_1"];
    address2 = json["address_2"];
    orgaCountryId = json["orga_country_id"];
    orgaStateId = json["orga_state_id"];
    orgaCityId = json["orga_city_id"];
    orgaPincode = json["orga_pincode"];
    organizationName = json["organization_name"];
    visiteDuration = json["visite_duration"];
    createdAt = DateTime.parse(json["created_at"]);
    updatedAt = DateTime.parse(json["updated_at"]);
    deletedAt = json["deleted_at"];
    services = json["services"];
    attachmant = json["attachmant"];
    attachmantBase = json["attachmant_base"];
    vehicalType = json["vehical_type"];
    vehicalRegNum = json["vehical_reg_num"];
    assetsName = json["assets_name"];
    assetsNumber = json["assets_number"];
    assetsBrand = json["assets_brand"];
    carryingDevice = json["carrying_device"];
    panDrive = json["pan_drive"];
    hardDisk = json["hard_disk"];
    visitType = json["visit_type"];
    preInvitePin = json["pre_invite_pin"];
    requestType = json["request_type"];
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "officer_id": officerId,
    "company_id": companyId,
    "document_type": documentType,
    "adhar_no": adharNo,
    "mobile": mobile,
    "email": email,
    "refer_code": referCode,
    "gender": gender,
    "image": image,
    "added_by": addedBy,
    "update_by": updateBy,
    "status": status,
    "app_status": appStatus,
    "visite_time": visiteTime.toIso8601String(),
    "pre_visit_date_time": preVisitDateTime,
    "employee_unique_id": employeeUniqueId,
    "image_base": imageBase,
    "vaccine": vaccine,
    "vaccine_name": vaccineName,
    "vaccine_count": vaccineCount,
    "symptoms": symptoms,
    "travelled_states": travelledStates,
    "patient": patient,
    "temprature": temprature,
    "department_id": departmentId,
    "location_id": locationId,
    "country_id": countryId,
    "building_id": buildingId,
    "state_id": stateId,
    "city_id": cityId,
    "pincode": pincode,
    "address_1": address1,
    "address_2": address2,
    "orga_country_id": orgaCountryId,
    "orga_state_id": orgaStateId,
    "orga_city_id": orgaCityId,
    "orga_pincode": orgaPincode,
    "organization_name": organizationName,
    "visite_duration": visiteDuration,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "services": services,
    "attachmant": attachmant,
    "attachmant_base": attachmantBase,
    "vehical_type": vehicalType,
    "vehical_reg_num": vehicalRegNum,
    "assets_name": assetsName,
    "assets_number": assetsNumber,
    "assets_brand": assetsBrand,
    "carrying_device": carryingDevice,
    "pan_drive": panDrive,
    "hard_disk": hardDisk,
    "visit_type": visitType,
    "pre_invite_pin": preInvitePin,
    "request_type": requestType,
  };
}
