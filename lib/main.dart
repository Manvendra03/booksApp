import 'dart:async';
import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notary_app/dashboard_page.dart';
import 'package:notary_app/internet.dart';
import 'package:notary_app/login_page.dart';
import 'package:notary_app/custom_colors.dart';
import 'package:notary_app/services/notary_services.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() async {
  await Future.delayed(Duration(seconds: 3));
  WidgetsFlutterBinding.ensureInitialized();

  AwesomeNotifications().initialize(
    'resource://drawable/ic_launcher',
    [
      // Your notification channels go here
      NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'apt_details',
          channelName: 'apt_details',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white)
    ],
    // Channel groups are only visual and are not required
    channelGroups: [
      NotificationChannelGroup(
          channelGroupkey: 'apt_details', channelGroupName: 'apt_details')
    ],
  );

  // await Firebase.initializeApp();
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      await checkNetwork();
    });

    AwesomeNotifications().actionStream.listen((event) async {
      print('event received!');
      print(event.runtimeType);
      print(event.toString());
      var map = event.toMap();
      String keyPressed = map["buttonKeyPressed"];
      var split = keyPressed.split(",");

      String tapedbutton = split[0];
      String apptID = split[1];
      String reason = map["buttonKeyInput"];

      print("tappedButton : " + tapedbutton);
      print("apptId " + apptID);
      print("reason " + reason);

      if (tapedbutton == "accept") {
        print("Accepted");
        var temp = await NotaryServices.acceptAppointment(apptID);
        print(temp);
      }

      if (tapedbutton == "reject") {
        print("rejected");
        var temp = await NotaryServices.rejectAppointment(apptID, reason);
        print(temp);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    subscription.cancel();
    super.dispose();
  }

  // This widget is the root of your application.  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: LoginPage(),
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      onGenerateRoute: (routeSettings) {
        switch (routeSettings.name) {
          case 'error':
            return MaterialPageRoute(builder: (context) => NoInternetPage());
          case 'login':
            return MaterialPageRoute(builder: (context) => LoginPage());
          default:
            return MaterialPageRoute(builder: (context) => LoginPage());
        }
      },
      navigatorKey: navigatorKey,
      routes: {
        '/login_page_route': (context) => LoginPage(),
        '/error_page_route': (context) => NoInternetPage(),
        '/dashboard_page_route': (context) => DashBoardPage(),
      },
    );
  }
}

Future<void> checkNetwork() async {
  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.mobile) {
    // navigatorKey.currentState?.pop();

    print('Mobile Network ');
  } else if (connectivityResult == ConnectivityResult.wifi) {
    // navigatorKey.currentState?.pop();
    print('Wifi Network');
  } else {
    navigatorKey.currentState?.pushNamed('error');
    print('No connection found');
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("new noti is arrived");
  print(jsonEncode(message.data));
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  // I will send in Notification data itself what buttons to show
  // Use this method to automatically convert the push data, in case you gonna use our data standard
  bool flag = await AwesomeNotifications()
      .createNotificationFromJsonData(jsonDecode(message.data["data"]));
  print("completed : " + flag.toString());
}
