// ignore_for_file: unrelated_type_equality_checks, avoid_print

import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2rp1/FE/mainScreen/login_screen4.dart';
import 'package:v2rp1/FE/navbar/navbar.dart';
import 'package:v2rp1/FE/navbar/navbar.dart' as navbar_module;
import 'additional/splash.dart';

// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

// Local notifications plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Global variable to store FCM token
String? fcmToken;

// Global navigator key for navigation
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Function to handle notification navigation
void _handleNotificationNavigation(String payload) {
  try {
    final data = jsonDecode(payload);
    final String? route = data['route'] as String?;
    final String? screen = data['screen'] as String?;
    final String? type = data['type'] as String?;
    final Map<String, dynamic>? extraData =
        data['data'] as Map<String, dynamic>?;

    print(
        'Navigating from notification - route: $route, screen: $screen, type: $type');

    // Check if user is logged in
    SharedPreferences.getInstance().then((prefs) {
      final String? kulonuwun = prefs.getString('kulonuwun');
      final String? monggo = prefs.getString('monggo');

      if (kulonuwun == null || monggo == null) {
        print('User not logged in, cannot navigate');
        return;
      }

      // Navigate based on route/screen/type
      if (route != null || screen != null || type != null) {
        _navigateToScreen(
            route: route, screen: screen, type: type, data: extraData);
      }
    });
  } catch (e) {
    print('Error parsing notification payload: $e');
  }
}

// Function to navigate to specific screen
void _navigateToScreen({
  String? route,
  String? screen,
  String? type,
  Map<String, dynamic>? data,
}) {
  // Wait for app to be ready
  Future.delayed(const Duration(milliseconds: 500), () {
    if (navigatorKey.currentContext == null) {
      print('Navigator context not ready yet');
      return;
    }

    // Navigate to Navbar first if not already there
    try {
      Get.offAll(const Navbar());
    } catch (e) {
      print('Error navigating to Navbar: $e');
      return;
    }

    // Then navigate to specific screen based on route/screen/type
    Future.delayed(const Duration(milliseconds: 500), () {
      int? targetTabIndex;

      // Handle route-based navigation (main tabs)
      if (route != null) {
        switch (route.toLowerCase()) {
          case 'home':
          case 'home_screen':
            targetTabIndex = 0; // Home screen (index 0)
            break;
          case 'approval':
          case 'approval_screen':
            targetTabIndex = 1; // Approval screen (index 1)
            break;
          case 'setting':
          case 'setting_screen':
            targetTabIndex = 2; // Setting screen (index 2)
            break;
          default:
            print('Unknown route: $route');
        }
      }

      // Handle type-based navigation (fallback)
      if (targetTabIndex == null && type != null) {
        switch (type.toLowerCase()) {
          case 'home':
            targetTabIndex = 0;
            break;
          case 'approval':
          case 'approve':
            targetTabIndex = 1;
            break;
          case 'setting':
          case 'settings':
          case 'profile':
            targetTabIndex = 2;
            break;
          default:
            print('Unknown type: $type');
        }
      }

      // Navigate to the target tab if found
      if (targetTabIndex != null) {
        // Try to access Navbar state and navigate
        try {
          // Wait a bit more for navbar to be fully built
          Future.delayed(const Duration(milliseconds: 200), () {
            // Use global reference from navbar.dart
            if (navbar_module.currentNavbarState != null) {
              navbar_module.currentNavbarState!.navigateToTab(targetTabIndex!);
              print('Navigated to tab index: $targetTabIndex');
            } else {
              // If navbar not ready, navigate first then set tab
              Get.offAll(() => Navbar());
              Future.delayed(const Duration(milliseconds: 500), () {
                if (navbar_module.currentNavbarState != null) {
                  navbar_module.currentNavbarState!
                      .navigateToTab(targetTabIndex!);
                  print('Navigated to tab index: $targetTabIndex (delayed)');
                }
              });
            }
          });
        } catch (e) {
          print('Error navigating to tab: $e');
        }
      }

      // Handle specific screens within approval (if needed)
      if (screen != null) {
        print('Navigate to screen: $screen with data: $data');
        // This would need custom navigation logic based on screen name
        // For example, navigate to specific approval detail screen
      }
    });
  });
}

// Function to save FCM token to SharedPreferences
Future<void> saveFcmTokenToLocal(String? token) async {
  if (token != null) {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcm_token', token);
    print('FCM Token saved to local storage');
  }
}

// Function to get and save FCM token
Future<String?> getAndSaveFcmToken() async {
  try {
    final FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();

    if (token != null) {
      fcmToken = token;
      await saveFcmTokenToLocal(token);
      print('FCM Token generated: $token');
    }

    return token;
  } catch (e) {
    print('Error getting FCM token: $e');
    return null;
  }
}

// Initialize local notifications
Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      // Handle notification tap
      if (response.payload != null) {
        _handleNotificationNavigation(response.payload!);
      }
    },
  );

  // Android notification channel
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Firebase
    await Firebase.initializeApp();
    print('Firebase initialized successfully');

    // Set up background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Initialize local notifications
    await initializeNotifications();
    print('Local notifications initialized successfully');

    // Request notification permissions
    final FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted notification permission');

      // Get and save FCM token
      await getAndSaveFcmToken();

      // Listen for token refresh
      messaging.onTokenRefresh.listen((String newToken) {
        print('FCM Token refreshed: $newToken');
        fcmToken = newToken;
        saveFcmTokenToLocal(newToken);
        // Token will be sent when user chooses role again
      });

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');

        if (message.notification != null) {
          print(
              'Message also contained a notification: ${message.notification}');

          // Prepare payload for navigation
          String payload = jsonEncode(message.data);

          // Show local notification when app is in foreground
          flutterLocalNotificationsPlugin.show(
            message.hashCode,
            message.notification?.title,
            message.notification?.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                'high_importance_channel',
                'High Importance Notifications',
                channelDescription:
                    'This channel is used for important notifications.',
                importance: Importance.high,
              ),
              iOS: DarwinNotificationDetails(
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
              ),
            ),
            payload: payload,
          );
        }
      });

      // Handle notification taps when app is in background/terminated
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');
        print('Message data: ${message.data}');

        // Handle navigation from background notification
        if (message.data.isNotEmpty) {
          String payload = jsonEncode(message.data);
          _handleNotificationNavigation(payload);
        }
      });

      // Check if app was opened from a terminated state via notification
      RemoteMessage? initialMessage = await messaging.getInitialMessage();
      if (initialMessage != null) {
        print('App opened from terminated state via notification');
        print('Message data: ${initialMessage.data}');

        // Handle navigation from terminated state notification
        if (initialMessage.data.isNotEmpty) {
          String payload = jsonEncode(initialMessage.data);
          _handleNotificationNavigation(payload);
        }
      }
    } else {
      print('User declined or has not accepted notification permissions');
    }
  } catch (e, stackTrace) {
    print('Error initializing Firebase/FCM: $e');
    print('Stack trace: $stackTrace');
    // Continue even if Firebase fails to initialize
  }

  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  String? finalUsername;

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      title: 'V2RP',
      initialRoute: '/',
      routes: {
        '/Login': (context) => const LoginPage4(),
        // '/Second': (context) => const SecondScreen()
      },
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

//test github baru