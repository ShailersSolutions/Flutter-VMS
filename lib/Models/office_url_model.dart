class OfficeUrlModel{
  String status;
  String msg;
  String id;
  String token;
  String logo;
  String name;
  String where;
  var data;
  OfficeUrlModel({this.id,this.name,this.logo,this.status,this.token,this.where,this.msg});

  OfficeUrlModel.fromJson(Map<String, dynamic> json){

    print("company details   ====  ${json['data']['logo']}");

    status = json['status'];
    msg = json['msg'];
    if(json['status'] == "success"){
      data = json['data'];
      id = json['data']['id'];
      token = json['data']['token'];
      logo = json['data']['logo'];
      name = json['data']['name'];
      where = json['data']['where'];
    }

  }
}