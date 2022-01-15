import 'dart:math';

class StaffLoginModel{
  String message;
  String msg;
  int id;
  int roleId;
  String companyId;
  int departmentId;
  int locationId;
  int buildingId;
  int deviceId;
  String name;
  String email;
  String mobile;
  String autoApproved;
  String avatar;
  String roleName;
  String locationName;
  String departmentName;
  String buildingName;
  var data;

  StaffLoginModel({this.id,this.name,this.companyId,this.locationId,this.email,this.data,
    this.autoApproved,this.avatar,this.buildingId,this.departmentId,this.deviceId,this.message,
  this.mobile,this.msg,this.roleId,this.buildingName,this.departmentName,this.locationName,this.roleName});

  StaffLoginModel.fromJson(Map<String, dynamic> json){
    print("office details   ====  $json");

    msg = json['msg'];
    message = json['message'];
    data = json['data'];
    if(json['data'] != null){
      id = json['data']['id'];
      name = json['data']['name'];
      companyId = json['data']['company_id'];
      locationId = json['data']['location_id'];
      email = json['data']['email'];
      buildingId = json['data']['building_id'];
      departmentId = json['data']['department_id'];
      avatar = json['data']['avatar'];
      autoApproved = json['data']['auto_approved'];
      deviceId = json['data']['device_id'];
      roleId = json['data']['role_id'];
      mobile = json['data']['mobile'];
      roleName = json['data']['role']['name'];
      locationName = json['data']['get_location']['name'];
      buildingName = json['data']['get_building']['name'];
      departmentName = json['data']['get_department']['name'];
    }
  }
}