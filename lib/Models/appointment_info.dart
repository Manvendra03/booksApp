import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class AppointmentInfo {
  final String appointment_id;
  final String signerFirstName;
  final String signerLastName;
  final String companyName;
  final bool isOnlineSigning;
  final String drivingDistanceinMins;
  final String date;
  final String time;
  final String customerFirstName;
  final String customerLastName;
  final String longitude;
  final String latitude;
  final String signerPhoneNumber;
  final String signerEmailAddress;
  final String customerPhoneNumber;
  final String customerEmailAddress;
  // final String x;
  // final bool isPropertySigning;
  //  // property signing is not ther for notary id

//   {
//     "notaryId": "62d7bc0d725fc90016166880"
// }

  AppointmentInfo({
    required this.appointment_id,
    required this.signerFirstName,
    required this.signerLastName,
    required this.companyName,
    required this.isOnlineSigning,
    required this.drivingDistanceinMins,
    required this.date,
    required this.time,
    required this.customerFirstName,
    required this.customerLastName,
    required this.customerEmailAddress,
    required this.customerPhoneNumber,
    required this.latitude,
    required this.longitude,
    required this.signerEmailAddress,
    required this.signerPhoneNumber,
    // required this.x,
    // required this.isPropertySigning
  });

  factory AppointmentInfo.fromJson(Map<String, dynamic> json) {
    print("Nect variable ");
    return AppointmentInfo(
      appointment_id: json["_id"].toString(),
      signerFirstName:
          json["signingInfo"]["signerInfo"]["fisrtName"].toString(),
      signerLastName: json["signingInfo"]["signerInfo"]["lastName"].toString(),
      companyName: json["endCustomerInfo"]["company"]["name"].toString(),
      isOnlineSigning: json["isOnlineSigning"],
      drivingDistanceinMins: json["drivingDistanceinMins"].toString(),
      date: json["appointmentInfo"]["date"].toString(),
      time: json["appointmentInfo"]["time"].toString(),
      customerFirstName: json["endCustomerInfo"]["firstName"].toString(),
      customerLastName: json["endCustomerInfo"]["lastName"].toString(),
      longitude: json["appointmentInfo"]["place"]["lon"].toString(),
      latitude: json["appointmentInfo"]["place"]["lon"].toString(),
      customerEmailAddress: json["endCustomerInfo"]["email"].toString(),

      customerPhoneNumber: json["endCustomerInfo"]["phoneNumber"].toString(),
      signerEmailAddress: json["signingInfo"]["signerInfo"]["email"].toString(),
      signerPhoneNumber:
          json["signingInfo"]["signerInfo"]["phoneNumber"].toString(),

      // x: x,
      // isPropertySigning: json["isPropertySigning"] ?? false,
    );
  }
}
