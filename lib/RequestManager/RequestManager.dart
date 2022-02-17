import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:facechk_app/Models/BuildingModel.dart';
import 'package:facechk_app/Models/CityModel.dart';
import 'package:facechk_app/Models/CountryModel.dart';
import 'package:facechk_app/Models/DepartmentModel.dart';
import 'package:facechk_app/Models/DetailQRModel.dart';
import 'package:facechk_app/Models/GaurdLoginModel.dart';
import 'package:facechk_app/Models/LocationModel.dart';
import 'package:facechk_app/Models/NewRegistrationModel.dart';
import 'package:facechk_app/Models/OfficerModel.dart';
import 'package:facechk_app/Models/OtpVerifyModel.dart';
import 'package:facechk_app/Models/StateModel.dart';
import 'package:facechk_app/Models/all_visitors_list.dart';
import 'package:facechk_app/Models/block.dart';
import 'package:facechk_app/Models/current_visitors.dart';
import 'package:facechk_app/Models/emergency_contact.dart';
import 'package:facechk_app/Models/know_status_model.dart';
import 'package:facechk_app/Models/over_staying_model.dart';
import 'package:facechk_app/Models/pre_data_verify.dart';
import 'package:facechk_app/Models/upcoming_visitor_model.dart';
import 'package:facechk_app/Models/office_url_model.dart';
import 'package:facechk_app/Models/pre_invitation_list_model.dart';
import 'package:facechk_app/Models/reports_model.dart';
import 'package:facechk_app/Models/sendOtpModel.dart';
import 'package:facechk_app/Models/staff_login_model.dart';
import 'package:facechk_app/Models/visitor_detail_by_id.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RequestManager {

  // static const baseUrl = "https://vztor.in/starcrest/public/api/";
  static const baseUrl = "https://vztor.in/h-oneindia/public/api/";
  Dio dio = Dio();

  Future<SendOtpModel> sendOtp(mobile, purpose) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/otpSend';
    SendOtpModel updatorderStatusModel = SendOtpModel();
    var headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({
      'mobile': mobile,
      'purpose': purpose,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      // jsonDecode('Update Status:$data');
      updatorderStatusModel = SendOtpModel.fromJson(jsonDecode(data));
      print('otp:${updatorderStatusModel.msg}');

      return updatorderStatusModel;
    } else {
      return updatorderStatusModel;
    }
  }

  Future<OtpVerifyModel> verifyOtp(mobile, otp, purpose) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/otpVerify';
      OtpVerifyModel otpverifymodel = OtpVerifyModel();
      var headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({
      'mobile': mobile,
      'otp': otp,
      'purpose': purpose,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      otpverifymodel = OtpVerifyModel.fromJson(jsonDecode(data));
      print('otp:${otpverifymodel.msg}');
      return otpverifymodel;
    } else {
      return otpverifymodel;
    }
  }

  Future<NewRegistrationModel> newRegistrationApi(

    visnName,
    visEmail,
    visPhone,
    visdocumentType,
    visitorAdhdhar,
    purposeVisitType,
    genderType,
    myDate,
    visite_duration,
    fileName,
    officerType,
    takenVaccineType,
    currentVaccineDose,
    currentVaccineCompany,
    currentSymptomsType,
    dayTravelledType,
    touchCovidPatientType,
    covidBodyTempCtrl,
    country_id,
    state_id,
    city_id,
    visitorPinNo,
    address_1,
    address_2,
    organizationNameCtrl,
    orga_country_id,
    orga_state_id,
    orga_city_id,
    organizationpinCtrl,
    department_id,
    location_id,
    building_id,
    vehical_type,
    vehical_reg_num,
    pan_drive,
    hard_disk,
    assets_name,
    assets_number,
    assets_brand,
    fileNameProfile,
  ) async {
    NewRegistrationModel newRegistrationModel = NewRegistrationModel();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/newVisit';
    print("new visit url $url");
    var headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    print(
        ' $visnName, $visEmail,$visPhone,$visdocumentType,$visitorAdhdhar,$purposeVisitType,$genderType,'
            '$myDate,$officerType,$takenVaccineType,$currentSymptomsType,$dayTravelledType,'
            '$touchCovidPatientType,$covidBodyTempCtrl,$country_id,$state_id,$city_id,$visitorPinNo,'
            '$address_1,$address_2,$organizationNameCtrl,$orga_country_id,$orga_state_id,$orga_city_id,'
            '$organizationpinCtrl,$department_id,$location_id,$building_id,$visite_duration,$vehical_type,'
            '$vehical_reg_num,$pan_drive,$hard_disk,$assets_name,$assets_number,$assets_brand');

    String fileName1 = fileName.split('/').last;
    print("filename==  $fileName1");
    String fileName2 = fileNameProfile.split('/').last;
    print("filename==  $fileName2");

    var formData = FormData.fromMap({
      'name': visnName,
      'email': visEmail,
      'mobile': visPhone,
      'document_type': visdocumentType,
      'adhar_no': visitorAdhdhar,
      'services': purposeVisitType,
      'gender': genderType,
      'visite_time': myDate,
      'attachmant': await MultipartFile.fromFile(fileName, filename: fileName1,contentType: MediaType("image", "png")),
      'officer_id': officerType,
      'vaccine': takenVaccineType,
      'vaccine_count': currentVaccineDose,
      'vaccine_name': currentVaccineCompany,
      'symptoms': currentSymptomsType,
      'states': dayTravelledType,
      'patient': touchCovidPatientType,
      'temprature': covidBodyTempCtrl,
      'country_id': country_id,
      'state_id': state_id,
      'city_id': city_id,
      'pincode': visitorPinNo,
      'address_1': address_1,
      'address_2': address_2,
      'organization_name': organizationNameCtrl,
      'orga_country_id': orga_country_id,
      'orga_state_id': orga_state_id,
      'orga_city_id': orga_city_id,
      'orga_pincode': organizationpinCtrl,
      'department_id': department_id,
      'location_id': location_id,
      'building_id': building_id,
      'visite_duration': visite_duration,
      'vehical_type': vehical_type,
      'vehical_reg_num': vehical_reg_num,
      'carrying_device': '2',
      'pan_drive': pan_drive,
      'hard_disk': hard_disk,
      'assets_name': assets_name,
      'assets_number': assets_number,
      'assets_brand': assets_brand,
      'visit_type': 'single',
      'group_name': '',
      'group_mobile': '',
      'group_id_proof': '',
      'group_gender': '',
      'file_names': '',
      'attachments': '',
      'file_name': await MultipartFile.fromFile(fileNameProfile, filename: fileName2,contentType: MediaType("image", "png")),
    });
    print(formData.fields);
    var response = await dio.post(url,data: formData);
    print("response of newVisit == ${response.data}");
    print("response of newVisit == ${response.data.runtimeType}");
    print("response of newVisit == ${response.data}");
    // http.Response response = await http.post(Uri.parse(url),body: body);
    // if (response.statusCode == 200) {
    //   newRegistrationModel = NewRegistrationModel.fromJson(jsonDecode(response.data));
    //   print('otp:${newRegistrationModel.message}');
    //   return newRegistrationModel;
    // } else {
      return NewRegistrationModel.fromJson(response.data);

  }

  Future<LocationModel> getLocationApi() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://vztor.in/$companyUrl/public/api/getLocation'));
    request.fields.addAll({

    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      print("location $data");
      return LocationModel.fromJson(jsonDecode(data));
    }
  }

  Future<BuildingModel> getBuilding(var locationId) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://vztor.in/$companyUrl/public/api/getBuilding'));
    request.fields.addAll({
      'location_id': locationId,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      return BuildingModel.fromJson(jsonDecode(data));
    }
  }


  Future<DepartmentModel> getDepartment(var buildingId, String companyId) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/getDepartment';
    print(url);
    Map<String, dynamic> body = {
      'building_id': buildingId,
      'company_id' : companyId,
    };
    var response = await http.post(Uri.parse(url),body: body);
    print(response.body);
    print(response.statusCode);
    if(response.statusCode == 200){
      return DepartmentModel.fromJson(jsonDecode(response.body));
    }

  }

  Future<OfficerModel> getOfficer(var departmentId) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/getOfficer';
    print(url);
    Map<String, dynamic> body = {
      'department_id': departmentId,
    };
    var response = await http.post(Uri.parse(url),body: body);
    print(response.body);
    print(response.statusCode);
    if(response.statusCode == 200){
      return OfficerModel.fromJson(jsonDecode(response.body));
    }

  }

  // Future<DetailQrModel> GenerateSlipApi(visit_id) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var companyUrl = prefs.getString('baseUrl');
  //   var url = 'https://vztor.in/$companyUrl/public/api/generateSlip';
  //   DetailQrModel generatemodel = DetailQrModel();
  //   var headers = {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse(url));
  //   request.fields.addAll({
  //     'visit_id': visit_id,
  //   });
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     var data = await response.stream.bytesToString();
  //     generatemodel = DetailQrModel.fromJson(jsonDecode(data));
  //     print('QR :${generatemodel.status}');
  //     return generatemodel;
  //   } else {
  //     return generatemodel;
  //   }
  // }

  Future<OfficeUrlModel> officeUrl(String officeUrl) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = 'https://vztor.in/$officeUrl/public/api/getCompany';
    print(url);
    print(officeUrl);
    Map<String, dynamic> body = {
      "full_url" : 'https://vztor.in/$officeUrl/public',
    };
    print(body);
    var response = await http.post(Uri.parse(url),body: body);
    print(response.body);
    if(response.statusCode == 200){
      prefs.setString('companyData', response.body);

      return OfficeUrlModel.fromJson(jsonDecode(response.body));
    }

  }

  Future<OfficeUrlModel> companyData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return OfficeUrlModel.fromJson(jsonDecode(prefs.getString('companyData')));
  }

  Future<StaffLoginModel> staffLogin(String email,String password, String companyId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/staffLogin';
    print(url);
    Map<String, dynamic> body = {
      "email" : email,
      "password" : password,
      "company_id" : companyId,
    };
    print(body);
    var response = await http.post(Uri.parse(url),body: body);
    print(response.body);
    prefs.setString('staffData', response.body);
    return StaffLoginModel.fromJson(jsonDecode(response.body));
  }

  Future<GuardLoginModel> guardLogin(String email,String password, String companyId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/gaurdLogin';
    print(url);
    Map<String, dynamic> body = {
      "email" : email,
      "password" : password,
      "company_id" : companyId,
    };
    print(body);
    var response = await http.post(Uri.parse(url),body: body);
    print(response.body);
    prefs.setString('guardData', response.body);
    return GuardLoginModel.fromJson(jsonDecode(response.body));
  }

  Future<StaffLoginModel> staffData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return StaffLoginModel.fromJson(jsonDecode(prefs.getString('staffData')));
  }

  Future<GuardLoginModel> guardData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return GuardLoginModel.fromJson(jsonDecode(prefs.getString('guardData')));
  }

  Future<UpComingVisitor> upComingVisitorData(int userId, String companyId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/visitor_recoard';
    Map<String, dynamic> body = {
      "user_id" : userId.toString(),
      "company_id" : companyId,
    };
    print(body);
    var response = await http.post(Uri.parse(url),body: body);
    print("visitor_recoard   === ${response.body}");
    return UpComingVisitor.fromJson(jsonDecode(response.body));
  }

  Future<DataVerify> preDataVerify(int userId, String companyId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/get_data_verify';
    Map<String, dynamic> body = {
      "user_id" : userId.toString(),
      "company_id" : companyId,
    };
    print(body);
    var response = await http.post(Uri.parse(url),body: body);
    return DataVerify.fromJson(jsonDecode(response.body));
  }
  Future preVisitVerify(int userId, String image) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/pre_visit_verify';
    Map<String, dynamic> body = {
      "user_id" : userId.toString(),
      "image" : image,
    };
    print(body);
    var response = await http.post(Uri.parse(url),body: body);
    return jsonDecode(response.body);
  }

  Future markIn(String userId, String temp, String companyId, String guardId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/visitorIn';
    Map<String, dynamic> body = {
      "user_id" : userId,
      "temperature" : temp,
      "company_id" : companyId,
      "guard_id" : guardId,
    };
    print(body);
    var response = await http.post(Uri.parse(url),body: body);
    return jsonDecode(response.body);
  }

  Future markOut(String userId, String companyId, String guardId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/visitorOut';
    Map<String, dynamic> body = {
      "user_id" : userId ,
      "company_id" : companyId,
      "guard_id" : guardId,
    };
    print(body);
    var response = await http.post(Uri.parse(url),body: body);
    return jsonDecode(response.body);
  }


  Future<CurrentVisitorModel> currentVisitor(int userId, String companyId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/all_in_visitor';
    Map<String, dynamic> body = {
      "user_id" : userId.toString(),
      "company_id" : companyId,
    };
    print(body);
    var response = await http.post(Uri.parse(url),body: body);

    return CurrentVisitorModel.fromJson(jsonDecode(response.body));
  }

  Future<PreInvitationListModel> preInvitationList(int userId, String companyId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/preinvitation_list';
    Map<String, dynamic> body = {
      "user_id" : userId.toString(),
      "company_id" : companyId,
    };
    print(body);
    var response = await http.post(Uri.parse(url),body: body);
    return PreInvitationListModel.fromJson(jsonDecode(response.body));
  }

  Future<OverStayingVisitor> overStayingList(int userId, String companyId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/over_staiyng';
    Map<String, dynamic> body = {
      "officer_id" : userId.toString(),
      "company_id" : companyId,
    };
    print(body);
    var response = await http.post(Uri.parse(url),body: body);
    return OverStayingVisitor.fromJson(jsonDecode(response.body));
  }

  Future<EmergencyContact> emergencyList(int userId, String companyId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/emergency_contact_list';
    Map<String, dynamic> body = {
      "user_id" : userId.toString(),
      "company_id" : companyId,
    };
    print(body);
    var response = await http.post(Uri.parse(url),body: body);

    return EmergencyContact.fromJson(jsonDecode(response.body));
  }

  Future<ReportListModel> reportsList(int userId, String companyId, {String dateFrom, String dateTo}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/visitor_report';
    Map<String, dynamic> body = {
      "user_id" : userId.toString(),
      "company_id" : companyId,
      "start_date":dateFrom == null ? "" : dateFrom,
      "end_date": dateTo == null ? "" : dateTo
    };
    print(body);
    var response = await http.post(Uri.parse(url),body: body);
    return ReportListModel.fromJson(jsonDecode(response.body));
  }

  Future<AllVisitorsListModel> allVisitorsList(int userId, String companyId,
      {String status}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/all_visitor_reports';
    Map<String, dynamic> body = {
      "user_id" : userId.toString(),
      "company_id" : companyId,
      "status":status == null ? "" :status,
    };
    print(body);
    var response = await http.post(Uri.parse(url),body: body);
    return AllVisitorsListModel.fromJson(jsonDecode(response.body));
  }

  Future<VisitorDetailByIdModel> visitorDetailById(String userId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/visitor_detail';
    Map<String, dynamic> body = {
      "user_id" : userId,
    };
    print(body);
    var response = await http.post(Uri.parse(url),body: body);
    return VisitorDetailByIdModel.fromJson(jsonDecode(response.body));
  }

  Future<Block> sendPanicAlert(String userId,String companyId, String visitorId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/send_panic_alert';
    Map<String, dynamic> body = {
      "user_id" : userId,
      "company_id" : companyId,
      "visitor_id" : visitorId,
    };
    print(body);
    var response = await http.post(Uri.parse(url),body: body);
    print("response of panic alert == ${response.body}");
    return Block.fromJson(jsonDecode(response.body));
  }

  Future<Block> blockVisitor(String visitorId/*,{bool isUnblock = false}*/) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/blocked_visitor';
    Map<String, dynamic> body = {
      "visitor_id" : visitorId,
    };
    print(body);
    var response = await http.post(Uri.parse(url),body: body);
    print("response of block == ${response.body}");
    return Block.fromJson(jsonDecode(response.body));
  }

  Future addEmergency(String name, String mobile, String email, int userid, String compnayId) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/add_emergency_contact';
    Map<String, dynamic> body = {
      "name" : name,
      "mobile" : mobile,
      "email" : email,
      "user_id" : userid.toString(),
      "company_id" : compnayId,
    };
    print(body);
    var response = await http.post(Uri.parse(url),body: body);
    print("response of add emer == ${response.body}");
    return jsonDecode(response.body);
  }

  Future<Block> addPreInvitation(String imageGallery, String name,
      String mobile, String email, int userid, String companyId, var dateTime,
      var locId, var buildId, var deptId, var officerId) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/add_preinvitation';

    String fileName = imageGallery.split('/').last;
    print("filename==  $fileName");
    var formData = FormData.fromMap({
      "name" : name,
      "mobile" : mobile,
      "email" : email,
      "user_id" : userid.toString(),
      "company_id" : companyId,
      "pre_visit_date_time": dateTime,
      "location_id": locId,
      "building_id": buildId,
      "department_id": deptId,
      "image": await MultipartFile.fromFile(imageGallery, filename: fileName),
      "officer_id" : officerId
    });
    print(formData.fields);
    var response = await dio.post(url,data: formData);
    print("response of addPreInvitation == ${response.data}");
    return Block.fromJson(jsonDecode(response.data));
  }

  Future editEmergency(String name, String mobile, String email, int userid) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/update_emergency_contact';
    Map<String, dynamic> body = {
      "name" : name,
      "mobile" : mobile,
      "email" : email,
      "id" : userid.toString(),
      "status" : "1",
    };
    print(body);
    var response = await http.post(Uri.parse(url),body: body);
    print("response of edit emer == ${response.body}");
    return jsonDecode(response.body);
  }

  Future<KnowStatusModel> knowStatus(String mobile) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/my_visit_list';
    Map<String, dynamic> body = {
      "mobile" : mobile,
    };
    print(body);
    var response = await http.post(Uri.parse(url),body: body);
    print("response of my_visit_list == ${response.body}");
    return KnowStatusModel.fromJson(jsonDecode(response.body));
  }

  Future approve(String officerId, String visitorId) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/visitor_approve';
    Map<String, dynamic> body = {
      "officer_id" : officerId,
      "visitor_id" : visitorId,
    };
    print(body);
    var response = await http.post(Uri.parse(url),body: body);
    print("response of approve == ${response.body}");
    return jsonDecode(response.body);
  }

  Future reject(String officerId, String visitorId) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/visitor_reject';
    Map<String, dynamic> body = {
      "officer_id" : officerId,
      "visitor_id" : visitorId,
    };
    print(body);
    var response = await http.post(Uri.parse(url),body: body);
    print("response of visitor_reject == ${response.body}");
    return jsonDecode(response.body);
  }

  Future reSchedule(String officerId, String visitorId,var dateTime) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/visitor_rescheduled';
    Map<String, dynamic> body = {
      "officer_id" : officerId,
      "visitor_id" : visitorId,
      "rescheduled_visite_time" : dateTime,
    };
    print(body);
    var response = await http.post(Uri.parse(url),body: body);
    print("response of visitor_rescheduled == ${response.body}");
    return jsonDecode(response.body);
  }


}

