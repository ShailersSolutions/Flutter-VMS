
import 'dart:convert';

VisitorDetailByIdModel visitorDetailByIdModelFromJson(String str) => VisitorDetailByIdModel.fromJson(json.decode(str));

String visitorDetailByIdModelToJson(VisitorDetailByIdModel data) => json.encode(data.toJson());

class VisitorDetailByIdModel {
  VisitorDetailByIdModel({
    this.status,
    this.msg,
    this.data,this.qrCode
  });

  String status;
  String msg;
  String qrCode;
  VisitorByIdData data;

  factory VisitorDetailByIdModel.fromJson(Map<String, dynamic> json) => VisitorDetailByIdModel(
    status: json["status"],
    msg: json["msg"],
    qrCode: json["qr_url"],
    data: VisitorByIdData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "qr_url": qrCode,
    "data": data.toJson(),
  };
}

class VisitorByIdData {
  VisitorByIdData({
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
  int updateBy;
  int status;
  String appStatus;
  String visiteTime;
  dynamic preVisitDateTime;
  String employeeUniqueId;
  dynamic imageBase;
  String vaccine;
  String vaccineName;
  String vaccineCount;
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
  dynamic address2;
  var orgaCountryId;
  var orgaStateId;
  var orgaCityId;
  dynamic orgaPincode;
  String organizationName;
  String visiteDuration;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String services;
  String attachmant;
  String attachmantBase;
  String vehicalType;
  String vehicalRegNum;
  String assetsName;
  String assetsNumber;
  String assetsBrand;
  dynamic carryingDevice;
  dynamic panDrive;
  dynamic hardDisk;
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

  VisitorByIdData.fromJson(Map<String, dynamic> json) {
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
    visiteTime = json["visite_time"];
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
    orgaCountryId = json["orga_country_id"] ?? null;
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
    visitorGroup = List<dynamic>.from(json["visitor_group"].map((x) => x));
    officerDetail = json["officer_detail"] == null ? null : OfficerDetail.fromJson(json["officer_detail"]);
    if(json['country_id'] != null){
      officerDepartment = Building.fromJson(json["officer_department"]) ?? null;
      country = Building.fromJson(json["country"]) ?? null;
      if(json['state_id'] != null){
        state = Building.fromJson(json["state"]) ;
        if(json['city_id'] != null){
          city = Building.fromJson(json["city"]);
        }
      }
    }
    if(json["location_id"] != null){
      location = Building.fromJson(json["location"]) ?? null;
      building = Building.fromJson(json["building"]) ?? null;
    }
    if(json["orga_country_id"] != null && json["orga_country_id"] != 0){
      orgaCountry = Building.fromJson(json["orga_country"]) ?? null;
      if(json['orga_state_id'] != null && json["orga_state_id"] != 0){
        orgaState = Building.fromJson(json["orga_state"]) ?? null;
        if(json['orga_city_id'] != null && json["orga_city_id"] != 0){
          orgaCity = Building.fromJson(json["orga_city"]) ?? null;
        }
      }
    }
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
    "officer_detail":  officerDetail == null ? null : officerDetail.toJson(),
    "officer_department":  officerDepartment == null ? null : officerDepartment.toJson(),
    "country":  country == null ? null : country.toJson(),
    "state":  state == null ? null : state.toJson(),
    "city":  city == null ? null : city.toJson(),
    "location":  location == null ? null : location.toJson(),
    "building":  building == null ? null : building.toJson(),
    "orga_country": orgaCountry == null ? null :  orgaCountry.toJson(),
    "orga_state":  orgaState == null ? null : orgaState.toJson(),
    "orga_city":  orgaCity == null ? null : orgaCity.toJson(),
  };
}

class Building {
  Building({
    this.id,
    this.name,
  });

  var id;
  var name;

  factory Building.fromJson(Map<String, dynamic> json) => Building(
    id: json["id"] ?? null,
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
