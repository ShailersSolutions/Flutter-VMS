import 'package:facechk_app/Models/BuildingModel.dart';
import 'package:facechk_app/Models/DepartmentModel.dart';
import 'package:facechk_app/Models/GaurdLoginModel.dart';
import 'package:facechk_app/Models/LocationModel.dart';
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
import 'package:facechk_app/Models/staff_login_model.dart';
import 'package:facechk_app/Models/visitor_detail_by_id.dart';
import 'package:facechk_app/RequestManager/RequestManager.dart';
import 'package:flutter/cupertino.dart';

class PreInvitationFormProvider with ChangeNotifier{

  TextEditingController verifyPhone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController emerVerifyPhone = TextEditingController();
  TextEditingController emerEmail = TextEditingController();
  TextEditingController emerName = TextEditingController();
  TextEditingController dateFrom = TextEditingController();
  TextEditingController dateTo = TextEditingController();
  // OfficeUrlModel officeUrlModel;
  // String companyLogo,companyName,companyId;
  String staffName,staffEmail,staffMobile;
  int staffId;

  var locationId, buildingId, departmentId;
  List<Date> locationList = [];
  List<DepartmentData> departmentList = [];
  List<BuildingData> buildingList = [];
  List<PreInvitationData> preInvitationList = [];
  List<OverStayingData> overStayingList = [];
  List<ReportData> reportList = [];
  List<AllVisitorData> allVisitorData = [];
  UpComingData upComingVisitor;
  List<CurrentData> currentVisitor = [];
  List<EmergencyData> emergencyData = [];
  List<KnowStatusData> knowStatusData = [];
  StaffLoginModel staffLoginModel;
  VisitorByIdData visitorDetailByIdModel;
  OfficeUrlModel officeUrlModel;
  Block block;
  Block sendPanic;
  Block addPre;
  VisitorDetailByIdModel qrCode;
  DataVerify dataVerify;
  GuardLoginModel guardLoginModel;
  String dateTime = DateTime.now().toString();


  setLocationList(List<Date> list){
    locationList = list;
    notifyListeners();
  }
  setKnowStatusList(List<KnowStatusData> list){
    knowStatusData = list;
    notifyListeners();
  }

  setDataVerify(DataVerify model){
    dataVerify = model;
    notifyListeners();
  }

  setAllVisitorDataList(List<AllVisitorData> list){
    allVisitorData = list;
    notifyListeners();
  }

  setEmergencyList(List<EmergencyData> list){
    emergencyData = list;
    notifyListeners();
  }

  setBuildingList(List<BuildingData> list){
    buildingList = list;
    notifyListeners();
  }
  setDepartmentList(List<DepartmentData> list){
    departmentList = list;
    notifyListeners();
  }

  setReportList(List<ReportData> list){
    reportList = list;
    notifyListeners();
  }

  setPreInvitationList(List<PreInvitationData> list){
    preInvitationList = list;
    notifyListeners();
  }

  setOverStayingList(List<OverStayingData> list){
    overStayingList = list;
    notifyListeners();
  }

  setUpComingVisitor(UpComingData list){
    upComingVisitor = list;
    notifyListeners();
  }

  setCurrentVisitor(List<CurrentData> list){
    currentVisitor = list;
    notifyListeners();
  }

  Future companyUrl(String officeUrl) async {
    var res = await RequestManager().officeUrl(officeUrl);
    setOfficeUrlDetails(res);
    notifyListeners();
  }

  Future locationApi() async {
    var res = await RequestManager().getLocationApi();
    setLocationList(res.date);
    buildingList = [];
    notifyListeners();
  }
  Future buildingApi(var locId) async {
    var res = await RequestManager().getBuilding(locId);
    setBuildingList(res.date);
  }

  Future knowStatusApi(String mobile) async {
    var res = await RequestManager().knowStatus(mobile);
    setKnowStatusList(res.data);
  }

  Future departmentApi(var buildId) async {
    var res = await RequestManager().getDepartment(buildId, officeUrlModel.id);
    setDepartmentList(res.date);
  }

  Future upComingVisitorApi() async{
    var res = await RequestManager().upComingVisitorData(staffId, officeUrlModel.id);
    setUpComingVisitor(res.data);
  }

  Future preDataVerifyApi(int id) async{
    var res = await RequestManager().preDataVerify(id, officeUrlModel.id);
    setDataVerify(res);
  }

  Future emergencyListApi() async{
    var res = await RequestManager().emergencyList(staffId, officeUrlModel.id);
    setEmergencyList(res.data);
  }

  Future currentVisitorApi() async{
    var res = await RequestManager().currentVisitor(staffId, officeUrlModel.id);
    setCurrentVisitor(res.data);
  }

  Future preInvitationApi() async{
    var res = await RequestManager().preInvitationList(staffId, officeUrlModel.id);
    setPreInvitationList(res.data);
  }

  Future overStayingApi() async{
    var res = await RequestManager().overStayingList(staffId, officeUrlModel.id);
    setOverStayingList(res.data);
  }

  Future reportListApi({String dateFrom, String dateTo}) async{
    var res = await RequestManager().reportsList(staffId, officeUrlModel.id,dateFrom: dateFrom,dateTo: dateTo);
    setReportList(res.data);
  }

  Future allVisitorApi({String status}) async{
    var res = await RequestManager().allVisitorsList(staffId, officeUrlModel.id,status: status);
    setAllVisitorDataList(res.data);
  }

  Future visitorDetailByIdApi(String userId) async{
    var res = await RequestManager().visitorDetailById(userId);
    setVisitorDataById(res.data);
    setVisitorDataByIdQrCode(res);
  }

  Future sendPanicAlertApi(String visitorId) async{
    var res = await RequestManager().sendPanicAlert(staffId.toString(), officeUrlModel.id,visitorId);
    setPanicAlert(res);
    print("panic ${res}");
    return res;
  }

  Future markInApi(var userId, var temp, var guardId) async{
    var res = await RequestManager().markIn(userId,temp, officeUrlModel.id,guardId);

    return res;
  }

  Future markOutApi(var userId, var guardId) async{
    var res = await RequestManager().markOut(userId, officeUrlModel.id, guardId);

    return res;
  }

  Future addEmergencyContactApi() async{
    var res = await RequestManager().addEmergency(emerName.text,emerVerifyPhone.text,emerEmail.text,staffId, officeUrlModel.id);
    notifyListeners();
    print("add ${res.runtimeType}");
    return res;
  }

  Future addPreInvitationApi(image) async{
    var res = await RequestManager().addPreInvitation(image,name.text,verifyPhone.text,email.text,staffId,
        officeUrlModel.id,dateTime,locationId,buildingId,departmentId);
    setPreInvitation(res);
    print("addPreInvitationApi ${res.runtimeType}");
    return res;
  }


  Future editEmergencyContactApi(int id) async{
    var res = await RequestManager().editEmergency(emerName.text,emerVerifyPhone.text,emerEmail.text,id);
    notifyListeners();
    print("edit ${res.runtimeType}");
    return res;
  }

  Future setEmergencyData(String name, String phone, String email){
    emerName.text = name;
    emerVerifyPhone.text = phone;
    emerEmail.text = email;
    notifyListeners();
  }
  clearEmergencyData(){
    emerName.text = "";
    emerVerifyPhone.text = "";
    emerEmail.text = "";
    notifyListeners();
  }

  setGuardLoginDetails(GuardLoginModel guardLogin){
    guardLoginModel = guardLogin;
    print("guardLoginModel ${guardLoginModel.data}");
    notifyListeners();
  }

  clearPreInvitationData(){
    name.text = "";
    verifyPhone.text = "";
    email.text = "";
    dateTime = '';
    locationId = null;
    buildingId = null;
    departmentId = null;
    notifyListeners();
  }

  Future blockVisitorApi(String visitorId,/* bool isUnblock*/) async{
    var res = await RequestManager().blockVisitor(visitorId /*isUnblock: isUnblock*/);
    setBlock(res);
    return res;
  }

  setVisitorDataById(VisitorByIdData model){
    visitorDetailByIdModel = model;
    notifyListeners();
  }
  setVisitorDataByIdQrCode(VisitorDetailByIdModel model){
    qrCode = model;
    notifyListeners();
  }

  setBlock(Block model){
    block = model;
    notifyListeners();
  }

  setPanicAlert(Block model){
    sendPanic = model;
    notifyListeners();
  }

  setPreInvitation(Block model){
    addPre = model;
    notifyListeners();
  }

  Future setOfficeUrlDetails(OfficeUrlModel model){
    // companyLogo = model.logo;
    // companyName = model.name;
    // companyId = model.id;
    officeUrlModel = model;
    notifyListeners();
  }

  Future setStaffLoginDetails(StaffLoginModel model){
    staffLoginModel = model;
    staffEmail = model.email;
    staffName = model.name;
    staffMobile = model.mobile;
    staffId = model.id;
    print("staffID ========");
    print(staffId);
    print(staffId.runtimeType);
    notifyListeners();
  }



}
