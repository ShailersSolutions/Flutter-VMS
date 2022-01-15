enum Gender {Male, Female, Other}

String genderId(Gender genderType){
  switch(genderType){
    case Gender.Male:
      return "male";
    case Gender.Female:
      return "female";
    case Gender.Other:
      return "other";
  }
}

String genderName(Gender genderSelected){
  switch(genderSelected){
    case Gender.Male:
      return "Male";
    case Gender.Female:
      return "Female";
    case Gender.Other:
      return "Other";
  }
}

enum Document {DrivingLicence, AadharCard, GovtIdentityProof,Pancard}

String documentId(Document documentType){
  switch(documentType){
    case Document.DrivingLicence:
      return "dl";
    case Document.AadharCard:
      return "adhar_card";
    case Document.GovtIdentityProof:
      return "govt_id_pf";
    case Document.Pancard:
      return "Pancard";
  }
}

String documentName(Document documentSelected){
  switch(documentSelected){
    case Document.DrivingLicence:
      return "Driving Licence";
    case Document.AadharCard:
      return "Aadhar Card";
    case Document.GovtIdentityProof:
      return "Govt Identity Proof";
    case Document.Pancard:
      return "Pancard";
  }
}

enum Vehicle {TwoWheeler, FourWheeler}

String vehicleId(Vehicle vehicleType){
  switch(vehicleType){
    case Vehicle.TwoWheeler:
      return "2 wheeler";
    case Vehicle.FourWheeler:
      return "4 wheeler";
  }
}

String vehicleName(Vehicle vehicleSelected){
  switch(vehicleSelected){
    case Vehicle.TwoWheeler:
      return "2 Wheeler";
    case Vehicle.FourWheeler:
      return "4 Wheeler";
  }
}

enum VisitDuration {Fifteen, Thirty, FortyFive, One,OnePointFive, Two, Four, FullDay}

String visitId(VisitDuration visitDuration){
  switch(visitDuration){
    case VisitDuration.Fifteen:
      return "15";
    case VisitDuration.Thirty:
      return "30";
    case VisitDuration.FortyFive:
      return "45";
    case VisitDuration.One:
      return "60";
    case VisitDuration.OnePointFive:
      return "90";
    case VisitDuration.Two:
      return "120";
    case VisitDuration.Four:
      return "240";
    case VisitDuration.FullDay:
      return "1440";


  }
}

String visitName(VisitDuration visitSelected){
  switch(visitSelected){
    case VisitDuration.Fifteen:
      return "15 Min";
    case VisitDuration.Thirty:
      return "30 Min";
    case VisitDuration.FortyFive:
      return "45 Min";
    case VisitDuration.One:
      return "1 Hour";
    case VisitDuration.OnePointFive:
      return "1.5 Hour";
    case VisitDuration.Two:
      return "2 Hour";
    case VisitDuration.Four:
      return "4 Hour";
    case VisitDuration.FullDay:
      return "Full Day";
  }
}

enum PurposeVisitType {Official, Personal /*AadharServicesComplaint, BirthCertificate*/}

String purposeId(PurposeVisitType purposeVisitType){
  switch(purposeVisitType){
    case PurposeVisitType.Official:
      return "Official";
    case PurposeVisitType.Personal:
      return "Personal";
    // case PurposeVisitType.AadharServicesComplaint:
    //   return "Aadhar Services Complaint";
    // case PurposeVisitType.BirthCertificate:
    //   return "Birth Certificate";
  }
}

String purposeName(PurposeVisitType type){
  switch(type){
    case PurposeVisitType.Official:
      return "Official";
    case PurposeVisitType.Personal:
      return "Personal";
    // case PurposeVisitType.AadharServicesComplaint:
    //   return "Aadhar Services Complaint";
    // case PurposeVisitType.BirthCertificate:
    //   return "Birth Certificate";
  }
}

enum Status {Approve, Reject, ReSchedule}

int statusId(Status statusType){
  switch(statusType){
    case Status.Approve:
      return 1;
    case Status.Reject:
      return 2;
    case Status.ReSchedule:
      return 3;
  }
}

String statusName(Status statusSelected){
  switch(statusSelected){
    case Status.Approve:
      return "Approve";
    case Status.Reject:
      return "Reject";
    case Status.ReSchedule:
      return "Re-Schedule";
  }
}