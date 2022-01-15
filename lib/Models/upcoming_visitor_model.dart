// // To parse this JSON data, do
// //
// //     final buildingModel = buildingModelFromJson(jsonString);
//
// import 'dart:convert';
//
// class CurrentVisitorModel{
//   String status;
//   Map<String, CurrentVisitor> data;
//   CurrentVisitorModel({this.data,this.status});
//   CurrentVisitorModel.fromJson(Map<String, dynamic> json){
//     Map temp = {};
//     status = json['status'];
//     temp = json['data'] as Map ?? {};
//     data = temp.map((key, value) => CurrentVisitor.fromJson(json));
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['data'] = data;
//     data['status'] = status;
//   }
// }
//
// class CurrentVisitor {
//   CurrentVisitor({
//     this.appointments,this.totalInVisitor,this.newVisitor,this.todayVisitor,
//     this.totalOutVisitor,this.totalVisitor
//   });
//
//   int totalVisitor, todayVisitor, newVisitor, totalInVisitor, totalOutVisitor;
//   List<AppointmentList> appointments;
//
//   CurrentVisitor.fromJson(Map<String, dynamic> json) {
//     List data = [];
//     totalInVisitor = json['total_in_visitor'];
//     totalVisitor = json['total_visitor'];
//     todayVisitor = json['today_visitor'];
//     newVisitor = json['new_visitor'];
//     totalOutVisitor = json['total_out_visitor'];
//     data = json["appointments"] as List ?? [];
//     appointments =  data.map((e) => AppointmentList.fromJson(e)).toList();
//   }
//
//   Map<String, dynamic> toJson() => {
//     "appointments": List<dynamic>.from(appointments.map((x) => x.toJson())),
//   };
// }
//
// class AppointmentList {
//   AppointmentList({
//     this.id,this.name,this.companyId,this.email,this.mobile,this.status,this.aadharNumber,
//     this.appStatus,this.documentType,this.gender,this.officerId,
//   this.profile,this.referCode,this.type,this.visitTime,
//   });
//
//   int id,officerId;
//   String name,type,companyId, documentType, aadharNumber,mobile,email,referCode, gender, profile, appStatus, visitTime,status,addedBy,markIn;
//
//   AppointmentList.fromJson(Map<String, dynamic> json) {
//     id= json["id"];
//     officerId = json['officer_id'];
//     name= json["name"];
//     type = json['type'];
//     companyId= json["company_id"];
//     status= json["status"];
//     documentType = json['document_type'];
//     aadharNumber = json['adhar_no'];
//     mobile = json['mobile'];
//     email = json['email'];
//     referCode = json['refer_code'];
//     gender = json['gender'];
//     profile = json['image'];
//     appStatus = json['app_status'];
//     visitTime = json['visite_time'];
//     addedBy = json['parent_detail']['name'];
//     markIn = json['get_in_out_status']['in_status'];
//   }
//
//   Map<String, dynamic> toJson(){
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data["id"] = id;
//     data['officer_id'] = officerId;
//     data["name"] = name;
//     data['type'] = type;
//     data["company_id"] = companyId;
//     data["status"] = status;
//     data['document_type'] = documentType;
//     data['adhar_no'] = aadharNumber;
//     data['mobile'] = mobile;
//     data['email'] = email;
//     data['refer_code'] = referCode;
//     data['gender'] = gender;
//     data['image'] = profile;
//     data['app_status'] = appStatus;
//     data['visite_time'] = visitTime;
//     data['addedBy'] = addedBy;
//     data['markIn'] = markIn;
//   }
// }

// To parse this JSON data, do
//
//     final currentVisitor = currentVisitorFromJson(jsonString);

import 'dart:convert';

UpComingVisitor currentVisitorFromJson(String str) => UpComingVisitor.fromJson(json.decode(str));

String currentVisitorToJson(UpComingVisitor data) => json.encode(data.toJson());

class UpComingVisitor {
  UpComingVisitor({
    this.status,
    this.msg,
    this.data,
  });

  String status;
  String msg;
  var data;

  factory UpComingVisitor.fromJson(Map<String, dynamic> json) => UpComingVisitor(
    status: json["status"],
    msg: json["msg"],
    data: UpComingData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data.toJson(),
  };
}

class UpComingData {
  UpComingData({
    this.allCheckinVisitor,
    this.allOverstayingVisitor,
    this.upcomingVisitor,this.allCheckoutVisitor,
    this.appointments,
  });

  int allCheckinVisitor;
  int allOverstayingVisitor;
  int upcomingVisitor;
  int allCheckoutVisitor;
  List<Appointment> appointments;

  factory UpComingData.fromJson(Map<String, dynamic> json) => UpComingData(
    allCheckinVisitor: json["all_checkin_visitor"],
    allOverstayingVisitor: json["all_overstaying_visitor"],
    upcomingVisitor: json["all_upcoming_visitor"],
    allCheckoutVisitor: json["all_checkout_visitor"],
    appointments: List<Appointment>.from(json["appointments"].map((x) => Appointment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "all_checkin_visitor": allCheckinVisitor,
    "all_overstaying_visitor": allOverstayingVisitor,
    "all_upcoming_visitor": upcomingVisitor,
    "all_checkout_visitor": allCheckoutVisitor,
    "appointments": List<dynamic>.from(appointments.map((x) => x.toJson())),
  };
}

class Appointment {
  Appointment({
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
    this.vehicalType,
    this.vehicalRegNum,
    this.assetsName,
    this.assetsNumber,
    this.assetsBrand,
    this.carryingDevice,
    this.panDrive,
    this.hardDisk,
    this.visitType,
    this.parentDetail,
    this.officerDetail,
    this.getInOutStatus,
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
  String vehicalType;
  String vehicalRegNum;
  String assetsName;
  String assetsNumber;
  String assetsBrand;
  dynamic carryingDevice;
  dynamic panDrive;
  dynamic hardDisk;
  String visitType;
  Detail parentDetail;
  Detail officerDetail;
  GetInOutStatus getInOutStatus;

  Appointment.fromJson(Map<String, dynamic> json) {
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
    vehicalType = json["vehical_type"];
    vehicalRegNum = json["vehical_reg_num"];
    assetsName = json["assets_name"];
    assetsNumber = json["assets_number"];
    assetsBrand = json["assets_brand"];
    carryingDevice = json["carrying_device"];
    panDrive = json["pan_drive"];
    hardDisk = json["hard_disk"];
    visitType = json["visit_type"];
    if(json["added_by"] != 0){
      parentDetail = Detail.fromJson(json["parent_detail"]);
    }
    officerDetail = Detail.fromJson(json["officer_detail"]);
    getInOutStatus = GetInOutStatus.fromJson(json["get_in_out_status"]);
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
    "vehical_type": vehicalType,
    "vehical_reg_num": vehicalRegNum,
    "assets_name": assetsName,
    "assets_number": assetsNumber,
    "assets_brand": assetsBrand,
    "carrying_device": carryingDevice,
    "pan_drive": panDrive,
    "hard_disk": hardDisk,
    "visit_type": visitType,
    "parent_detail": parentDetail.toJson(),
    "officer_detail": officerDetail.toJson(),
    "get_in_out_status": getInOutStatus.toJson(),
  };
}

class GetInOutStatus {
  GetInOutStatus({
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
  String inDevice;
  String inStatus;
  dynamic outDevice;
  DateTime outTime;
  String outStatus;

  factory GetInOutStatus.fromJson(Map<String, dynamic> json) => GetInOutStatus(
    id: json["id"],
    userId: json["user_id"],
    inTime: DateTime.parse(json["in_time"]),
    inDevice: json["in_device"],
    inStatus: json["in_status"],
    outDevice: json["out_device"],
    outTime: DateTime.parse(json["out_time"]),
    outStatus: json["out_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "in_time": inTime.toIso8601String(),
    "in_device": inDevice,
    "in_status": inStatus,
    "out_device": outDevice,
    "out_time": outTime.toIso8601String(),
    "out_status": outStatus,
  };
}

class Detail {
  Detail({
    this.id,
    this.name,
    this.roleId,
  });

  int id;
  String name;
  int roleId;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    id: json["id"],
    name: json["name"],
    roleId: json["role_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "role_id": roleId,
  };
}
