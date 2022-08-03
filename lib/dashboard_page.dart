import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:notary_app/Models/appointment_info.dart';

import 'package:notary_app/custom_colors.dart';
import 'package:notary_app/services/auth.dart';
import 'package:notary_app/services/notary_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: white_color,
      body: Center(
        child: Container(
          child: ElevatedButton(
              onPressed: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                String token = await preferences.getString('pushToken')!;
                String appId = "62e90a122bb76f0016a54747";
                print(token);
                AuthService.hitApi(token, appId);
              },
              child: Text("get user name ")),
        ),
      ),
    ));
  }
}
