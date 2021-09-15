import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:pn_204_sam/Auth/auth.dart';
import 'package:pn_204_sam/Auth/shifts.dart';
import 'package:pn_204_sam/models/UserPreferences.dart';
import 'package:pn_204_sam/screens/client/client_dashboard.dart';
import 'package:pn_204_sam/screens/login.dart';
import 'package:pn_204_sam/screens/manager/manager_dashboard.dart';
import 'package:pn_204_sam/screens/splash_screen.dart';
import 'package:pn_204_sam/screens/staff/staff_dashboard.dart';
import 'package:pn_204_sam/screens/supervisor/Supervisor_dashboard.dart';
import 'package:pn_204_sam/utilites/size_configration.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/PushNotificationMessage.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  String msg = Bidi.stripHtmlIfNeeded("${message.notification!.body}");
  print('background message ${message.notification!.body}');
}

AndroidNotificationChannel? channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp();
  assert(app != null);
  print('Initialized default app $app');
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print(" App Open ${message.notification?.body}");
    PushNotification notification = PushNotification(
      title: message.notification?.title,
      body: message.notification?.body,
    );
  });

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel!);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    home: SplashScreen(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future _getUserToken() => UserPreferences().getToken();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => Shifts()),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfig().init(constraints, orientation);
              return MaterialApp(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                home: FutureBuilder(
                  future: _getUserToken(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return CircularProgressIndicator();
                      default:
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');
                        // ignore: unnecessary_null_comparison
                        else if (snapshot.data == null) {
                          return Login();
                        } else {
                          return Dashboard();
                        }
                    }
                  },
                ),
                routes: {
                  '/dashboard': (context) => Login(),
                  '/login': (context) => Login(),
                },
              );
            },
          );
        },
      ),
      // child: MaterialApp(
      //   title: 'Flutter Demo',
      //   debugShowCheckedModeBanner: false,
      //   home: FutureBuilder(
      //     future: _getUserToken(),
      //     builder: (context, snapshot) {
      //       switch (snapshot.connectionState) {
      //         case ConnectionState.none:
      //         case ConnectionState.waiting:
      //           return CircularProgressIndicator();
      //         default:
      //           if (snapshot.hasError)
      //             return Text('Error: ${snapshot.error}');
      //           // ignore: unnecessary_null_comparison
      //           else if (snapshot.data == null) {
      //             return Login();
      //           } else {
      //             return Dashboard();
      //           }
      //       }
      //     },
      //   ),
      //   routes: {
      //     '/dashboard': (context) => Login(),
      //     '/login': (context) => Login(),
      //   },
      // ),
    );
  }
}

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  getDashboard() async {
    // UserPreferences().removeToken();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var roleId = prefs.getString("roleId");
    print(roleId);
    switch (roleId) {
      case "2":
        {
          print("User is Manager $roleId");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ManagerDashboard(),
            ),
          );
        }
        break;
      case "3":
        {
          print("User is supervisor");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SupervisorDashboard(),
            ),
          );
        }
        break;
      case "4":
        {
          print("User is staff");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => StaffDashboard(),
            ),
          );
        }
        break;
      case "5":
        {
          print("User is Client");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ClientDashboard(),
            ),
          );
        }
        break;

      default:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    setState(() {
      getDashboard();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Refresh Page"),
        ),
      ),
    );
  }
}
