import 'package:facechk_app/Models/re_visit_model.dart';
import 'package:flutter/cupertino.dart';

class VisitorFormProvider with ChangeNotifier{

  TextEditingController visitorName = TextEditingController();
  TextEditingController visitorEmail = TextEditingController();
  TextEditingController visitorPhone = TextEditingController();
  TextEditingController docId = TextEditingController();
  TextEditingController vehicleRegNum = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController orgName = TextEditingController();
  TextEditingController orgPinCode = TextEditingController();
  TextEditingController assetName = TextEditingController();
  TextEditingController serialNum = TextEditingController();
  TextEditingController assetBrand = TextEditingController();
  TextEditingController penDrive = TextEditingController();
  TextEditingController hardDisk = TextEditingController();

  var gender,docType,visitDuration,purposeOfVisit,
      vehicleType,country,state,city,location,building,department,officer,dateTime,orgCountry, orgState, orgCity,
  takenVaccine,doseOfVaccine,doseOfVaccineValue,vaccineName,currentlyExperiencing,travelled,covidPatient;

  List<RevisitData> reVisit = [];

  Future setRevisitData(List<RevisitData> data)async{
    reVisit = data;
    visitorName.text = reVisit[0].name;
    visitorEmail.text = reVisit[0].email;
    visitorPhone.text = reVisit[0].mobile;
    gender = reVisit[0].gender;
    docType = reVisit[0].documentType;
    docId.text = reVisit[0].adharNo;
    visitDuration = reVisit[0].visiteDuration;
    purposeOfVisit = reVisit[0].services;
    notifyListeners();
  }

  Future clearRevisitData()async{
    visitorName.text = "";
    visitorEmail.text = "";
    visitorPhone.text = "";
    docId.text = "";
    visitDuration = "";
    gender = "";
    docType = "";
    purposeOfVisit = "";
  }



}
