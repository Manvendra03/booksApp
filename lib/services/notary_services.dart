import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'package:notary_app/Models/appointment_info.dart';
import 'package:notary_app/Models/lead_info.dart';
import 'package:notary_app/Models/user_profile.dart';
import 'package:notary_app/widgets.dart';
import 'auth.dart';

class NotaryServices {
  static String baseUrl = "https://notaryapp-staging.herokuapp.com";

  static Future getResponse(String url, int PageNumber) async {
    UserProfile currentuser = await AuthService.getUserInfo();
    final String notaryId = currentuser.notaryId;

    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({"notaryId": notaryId, "pageNumber": PageNumber}));
      return response;
    } catch (e) {
      print("inner $e");
      showtoast("Something went wrong ");
    }
  }

  static Future<List<AppointmentInfo>> getPendingAppointment(
      {required int PageNumber}) async {
    List<AppointmentInfo> appointmentList = [];
    appointmentList.clear();

    String url = "$baseUrl/appointment/getPendingAppointments";
    print(url);

    try {
      http.Response response = await getResponse(url, PageNumber);
      if (response.statusCode == 200) {
        var responsebody = await jsonDecode(response.body);

        print("************************response ********************");
        print(response.body);

        List data = responsebody["appointments"];

        print("length : ${data.length}");

        if (data.length > 0) {
          data.forEach((element) {
            AppointmentInfo temp = AppointmentInfo.fromJson(element);

            print("company nme : ");
            print(temp.companyName);

            appointmentList.add(temp);
          });

          return appointmentList;
        } else {
          print("Zero");
        }
      } else {
        print("status code is n0t 200 ");
        showtoast("Something went wrong ");
      }
    } catch (e) {
      showtoast("Something went wrong ");
      print("catch block : $e");
    }

    return appointmentList;
  }

  static Future<List<AppointmentInfo>> getUpcomingAppointment(
      {required int PageNumber}) async {
    List<AppointmentInfo> appointmentList = [];
    appointmentList.clear();

    String url = "$baseUrl/appointment/getUpcomingAppointments";

    try {
      http.Response response = await getResponse(url, PageNumber);
      if (response.statusCode == 200) {
        var responsebody = await jsonDecode(response.body);

        print("************************response ********************");
        print(response.body);

        List data = responsebody["appointments"];

        print("length : ${data.length}");

        if (data.length > 0) {
          data.forEach((element) {
            AppointmentInfo temp = AppointmentInfo.fromJson(element);

            print("company nme : ");
            print(temp.companyName);

            appointmentList.add(temp);
          });

          return appointmentList;
        } else {
          print("Zero");
        }
      } else {
        print("status code is npt 200 ");
        showtoast("Something went wrong ");
      }
    } catch (e) {
      showtoast("Something went wrong ");
      print("catch block : $e");
    }

    return appointmentList;
  }

  static Future<List<AppointmentInfo>> getPastAppointment(
      {required int PageNumber}) async {
    List<AppointmentInfo> appointmentList = [];
    appointmentList.clear();

    String url = "$baseUrl/appointment/getPastAppointments";

    try {
      http.Response response = await getResponse(url, PageNumber);
      if (response.statusCode == 200) {
        var responsebody = await jsonDecode(response.body);

        print("************************response ********************");
        print(response.body);

        List data = responsebody["appointments"];

        print("length : ${data.length}");

        if (data.length > 0) {
          data.forEach((element) {
            AppointmentInfo temp = AppointmentInfo.fromJson(element);

            print("company nme : ");
            print(temp.companyName);

            appointmentList.add(temp);
          });

          return appointmentList;
        } else {
          print("Zero");
        }
      } else {
        print("status code is n0t 200 ");
        showtoast("Something went wrong ");
      }
    } catch (e) {
      showtoast("Something went wrong ");
      print("catch block : $e");
    }
    return appointmentList;
  }

  static Future getSpecificAppointment(String appointmentID) async {
    String url = "$baseUrl/appointment/getSpecificAppointment";

    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({"appointmentId": appointmentID}));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body)["appointments"];
        AppointmentInfo appointment = AppointmentInfo.fromJson(data);
        return appointment;
      } else {
        print(response.statusCode);
        showtoast("Something went wrong ");
        print("status code : 400 ");
      }
    } catch (e) {
      print("inner $e");
      showtoast("Something went wrong ");
    }
    return false;
  }

  static Future<List<LeadInfo>> getAllLeaad({required int PageNumber}) async {
    List<LeadInfo> leadList = [];
    leadList.clear();
    print("====================================getAllLead===================");

    String url = "$baseUrl/lead/getLeads";

    try {
      http.Response response = await getResponse(url, PageNumber);
      if (response.statusCode == 200) {
        var responsebody = await jsonDecode(response.body);

        print("************************response ********************");
        print(response.body);

        List data = responsebody["leads"];

        print("length : ${data.length}");

        if (data.length > 0) {
          data.forEach((element) {
            LeadInfo temp = LeadInfo.fromJson(element);

            print("company nme : ");
            print(temp.companyName);

            leadList.add(temp);
          });

          return leadList;
        } else {
          print("Zero");
        }
      } else {
        print("status code is n0t 200 ");
        showtoast("Something went wrong ");
      }
    } catch (e) {
      showtoast("Something went wrong ");
      print("catch block : $e");
    }
    return leadList;
  }

  static Future acceptAppointment(String appointmentId) async {
    final String url = "$baseUrl/appointment/acceptAppointment";
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({"apptId": appointmentId}));

      if (response.statusCode == 200) {
        var responsebody = await jsonDecode(response.body);

        if (responsebody["status"] == 1) {
          AppointmentInfo appointmentInfo =
              AppointmentInfo.fromJson(responsebody["appointment"]);
          return appointmentInfo;
        } else {
          showtoast("Something went wrong ");
          print("something went wrong");
          return false;
        }
      } else {
        print("status code is not 200 ");
        showtoast("Something went wrong ");
      }
    } catch (e) {
      print(e);
      showtoast("Something went wrong ");
    }
    return false;
  }

  static Future rejectAppointment(String appointmentId, String reason) async {
    final String url = "$baseUrl/appointment/rejectAppointment";
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({"apptId": appointmentId, "reason": reason}));
      if (response.statusCode == 200) {
        var responsebody = await jsonDecode(response.body);

        if (responsebody["status"] == 1) {
          AppointmentInfo appointmentInfo =
              AppointmentInfo.fromJson(responsebody["appointment"]);
          return appointmentInfo;
        } else {
          print("something went wrong");
          showtoast("Something went wrong ");
          return false;
        }
      } else {
        print("status code is not 200 ");
        showtoast("Something went wrong ");
      }
    } catch (e) {
      print(e);
      showtoast("Something went wrong ");
      return false;
    }
  }

  static Future completedAppointment({required String appointmentId}) async {
    final String url = "$baseUrl/appointment/editStatus";
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({"apptId": appointmentId, "status": 2}));

      if (response.statusCode == 200) {
        var responsebody = await jsonDecode(response.body);

        if (responsebody["status"] == 1) {
          print("------------------------response -----------------");
          print(responsebody);
          AppointmentInfo appointmentInfo =
              AppointmentInfo.fromJson(responsebody["appointment"]);
          return appointmentInfo;
        } else {
          print("something went wrong");
          showtoast("Something went wrong ");
        }
      } else {
        print("status code is not 200 ");
        showtoast("Something went wrong ");
      }
    } catch (e) {
      print(e);
      showtoast("Something went wrong ");
    }

    return false;
  }

  static Future<Map<String, List<AppointmentInfo>>>
      getDashboarAppointment() async {
    var dio = Dio();

    List<AppointmentInfo> pendingAppointmentList = [];
    List<AppointmentInfo> upcomingAppointmentList = [];

    upcomingAppointmentList.clear();
    pendingAppointmentList.clear();

    print(
        "===============================getDashBoardPendingAppointment =======================");

    UserProfile currentUser = await AuthService.getUserInfo();
    final String notaryId = currentUser.notaryId;

    print("notaryId : ${notaryId}");

    String url = "$baseUrl/dashboard/getDashboard/";
    print(url);

    try {
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['Accept'] = 'application/json';

      final response =
          await dio.post(url, data: jsonEncode({"notaryId": notaryId}));

      if (response.statusCode == 200) {
        print("************************response ********************");

        print(response.data.toString());

        List data = response.data['pendingAppointments'];
        print("length ${data.length}");
        data.forEach((element) {
          AppointmentInfo temp = AppointmentInfo.fromJson(element);
          print("company name ${temp.companyName}");
          pendingAppointmentList.add(temp);
        });
        print(
            "......................function changed pending to upcoming ................ ");

        List data2 = response.data['upcomingAppointments'];
        print("length ${data2.length}");
        data2.forEach((element) {
          AppointmentInfo temp = AppointmentInfo.fromJson(element);
          print("company name ${temp.companyName}");
          upcomingAppointmentList.add(temp);
        });

        return (<String, List<AppointmentInfo>>{
          'upcomingAppointmnet': upcomingAppointmentList,
          'pendingAppointment': pendingAppointmentList
        });
      } else {
        print(response.statusCode);
        showtoast("Something went wrong ");
      }
    } catch (e) {
      showtoast("Something went wrong ");
      print(e);
    }
    return (<String, List<AppointmentInfo>>{
      'upcomingAppointmnet': upcomingAppointmentList,
      'pendingAppointment': pendingAppointmentList
    });
  }
}
