import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:notary_app/main.dart';
import 'package:notary_app/widgets.dart';

class NoInternetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("Assets/images/no_internet.gif", height: height * .35),
            const Divider(color: Colors.transparent),
            const Text(
              "Oops...",
              style: TextStyle(fontSize: 40),
            ),
            const Divider(color: Colors.transparent),
            const Text(
              "There is a connection error. Please check your internet connection and try again.",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: height * .04),
            ElevatedButton(
              onPressed: () {
                checkNetwork();
              },
              child: Text("Retry"),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> checkNetwork() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    navigatorKey.currentState?.pop();
    print('Mobile Network ');
  } else if (connectivityResult == ConnectivityResult.wifi) {
    navigatorKey.currentState?.pop();
    print('Wifi Network');
  } else {
    showtoast("No Internet Connection Available ");
  }
}
