import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:notary_app/Models/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:notary_app/widgets.dart';

class AuthService {
  final String login_url =
      "https://notaryapp-staging.herokuapp.com/customer/login";

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> logInUserWithEmail(
      String userId, String password, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      final UserCredential UserCred = await _auth.signInWithEmailAndPassword(
          email: userId, password: password);

      final User currentUSer = await _auth.currentUser!;
      final String tokenId = await currentUSer.getIdToken();
      final String token = tokenId.toString();

      String? pushToken = await FirebaseMessaging.instance.getToken();
      print('push token is here : ' + pushToken.toString());
      pref.setString('pushToken', pushToken!);

      print(' email ' + currentUSer.email.toString());
      // print(token);
      print(currentUSer.uid);

      http.Response login_response = await http.post(Uri.parse(login_url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'email': currentUSer.email.toString(),
            'uid': currentUSer.uid.toString(),
            'pushToken': token.toString(),
            'fromMobile': true
          }));

      if (login_response.statusCode == 200 &&
          jsonDecode(login_response.body)['status'] == 2) {
        print("\n\n\nResponse :  ${login_response.body} \n\n\n");
        Map<String, dynamic> response_body =
            jsonDecode(login_response.body)["customer"];
        UserProfile user = UserProfile.fromJson(response_body);

        pref.setBool("isLogin", true);
        storeUser(user);

        return 'noerror';
        // buttonController.reset();
      } else {
        //something went wrong;
        showtoast("something went wrong ");
        return 'false';
      }
    } on FirebaseAuthException catch (error) {
      print("Error ${error.code}");
      return error.code;
    }
    // buttonController.reset();
  }

  void storeUser(UserProfile userProfile) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('userName', userProfile.userName);
    String UserData = jsonEncode(userProfile);
    pref.setString('UserData', UserData);
  }

  static Future<UserProfile> getUserInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String UserData = pref.getString('UserData')!;
    Map<String, dynamic> userProfile = jsonDecode(UserData);
    UserProfile userProfilee = UserProfile.fromJson(userProfile);
    return userProfilee;
  }

  Future<bool> logoutUser() async {
    try {
      await _auth.signOut();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<void> hitApi(String pushToken, String apptId) async {
    String url =
        "https://notaryapp-staging.herokuapp.com/sendPushMock?token=$pushToken&aptId=$apptId";
    try {
      var response = await http.get(Uri.parse(url));
      print(response.statusCode);
    } catch (e) {
      print("catch");
      print(e);
    }
  }

  // Future<void> saveTokenToDatabase(String token) async {
  //   // Assume user is logged in for this example
  //   String userId = FirebaseAuth.instance.currentUser!.uid;

  //   final tokenRef = FirebaseFirestore.instance
  //       .collection('vendors')
  //       .doc(userId)
  //       .collection('tokens')
  //       .doc(token);
  //   await tokenRef.set(
  //       TokenModel(token: token, creadtedAt: FieldValue.serverTimestamp())
  //           .toJson());
  // }

  // // @override
  // // void initState() {
  // //   getToken();
  // //   super.initState();
  // // }

  // getToken() async {
  //   // Get the token each time the application loads
  //   String? token = await FirebaseMessaging.instance.getToken();

  //   // Save the initial token to the database
  //   await saveTokenToDatabase(token!);

  //   // Any time the token refreshes, store this in the database too.
  //   FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  // }
}
