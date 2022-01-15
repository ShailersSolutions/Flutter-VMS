// To parse this JSON data, do
//
//     final detailQrModel = detailQrModelFromJson(jsonString);

import 'dart:convert';

DetailQrModel detailQrModelFromJson(String str) =>
    DetailQrModel.fromJson(json.decode(str));

String detailQrModelToJson(DetailQrModel data) => json.encode(data.toJson());

class DetailQrModel {
  DetailQrModel({
    this.status,
    this.msg,
    this.data,
  });

  String status;
  String msg;
  Data data;

  factory DetailQrModel.fromJson(Map<String, dynamic> json) => DetailQrModel(
        status: json["status"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data.toJson(),
      };
}

class Data {
  Data({
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
    this.companyName,
    this.slipId,
  });

  int id;
  String name;
  String type;
  int officerId;
  String companyId;
  String documentType;
  String adharNo;
  String mobile;
  String email;
  String referCode;
  String gender;
  String image;
  int addedBy;
  dynamic updateBy;
  int status;
  String appStatus;
  String visiteTime;
  dynamic preVisitDateTime;
  dynamic employeeUniqueId;
  String imageBase;
  String vaccine;
  dynamic vaccineName;
  dynamic vaccineCount;
  String symptoms;
  String travelledStates;
  String patient;
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
  String orgaCountryId;
  String orgaStateId;
  String orgaCityId;
  String orgaPincode;
  String organizationName;
  String visiteDuration;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String services;
  String attachmant;
  dynamic attachmantBase;
  String vehicalType;
  String vehicalRegNum;
  String assetsName;
  String assetsNumber;
  String assetsBrand;
  String carryingDevice;
  String panDrive;
  String hardDisk;
  String visitType;
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
  String companyName;
  String slipId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        officerId: json["officer_id"],
        companyId: json["company_id"],
        documentType: json["document_type"],
        adharNo: json["adhar_no"],
        mobile: json["mobile"],
        email: json["email"],
        referCode: json["refer_code"],
        gender: json["gender"],
        image: json["image"],
        addedBy: json["added_by"],
        updateBy: json["update_by"],
        status: json["status"],
        appStatus: json["app_status"],
        visiteTime: json["visite_time"],
        preVisitDateTime: json["pre_visit_date_time"],
        employeeUniqueId: json["employee_unique_id"],
        imageBase: json["image_base"],
        vaccine: json["vaccine"],
        vaccineName: json["vaccine_name"],
        vaccineCount: json["vaccine_count"],
        symptoms: json["symptoms"],
        travelledStates: json["travelled_states"],
        patient: json["patient"],
        temprature: json["temprature"],
        departmentId: json["department_id"],
        locationId: json["location_id"],
        countryId: json["country_id"],
        buildingId: json["building_id"],
        stateId: json["state_id"],
        cityId: json["city_id"],
        pincode: json["pincode"],
        address1: json["address_1"],
        address2: json["address_2"],
        orgaCountryId: json["orga_country_id"],
        orgaStateId: json["orga_state_id"],
        orgaCityId: json["orga_city_id"],
        orgaPincode: json["orga_pincode"],
        organizationName: json["organization_name"],
        visiteDuration: json["visite_duration"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        services: json["services"],
        attachmant: json["attachmant"],
        attachmantBase: json["attachmant_base"],
        vehicalType: json["vehical_type"],
        vehicalRegNum: json["vehical_reg_num"],
        assetsName: json["assets_name"],
        assetsNumber: json["assets_number"],
        assetsBrand: json["assets_brand"],
        carryingDevice: json["carrying_device"],
        panDrive: json["pan_drive"],
        hardDisk: json["hard_disk"],
        visitType: json["visit_type"],
        visitorGroup: List<dynamic>.from(json["visitor_group"].map((x) => x)),
        officerDetail: OfficerDetail.fromJson(json["officer_detail"]),
        officerDepartment: Building.fromJson(json["officer_department"]),
        country: Building.fromJson(json["country"]),
        state: Building.fromJson(json["state"]),
        city: Building.fromJson(json["city"]),
        location: Building.fromJson(json["location"]),
        building: Building.fromJson(json["building"]),
        orgaCountry: Building.fromJson(json["orga_country"]),
        orgaState: Building.fromJson(json["orga_state"]),
        orgaCity: Building.fromJson(json["orga_city"]),
        companyName: json["company_name"],
        slipId: json["slip_id"],
      );

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
        "visite_time": visiteTime,
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
        "company_name": companyName,
        "slip_id": slipId,
      };
}

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
