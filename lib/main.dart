import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'screens/home_screen.dart';
import 'models/medicine.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  List<Medicine> medicines = [];

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void addMedicine(Medicine med) async {
    setState(() {
      medicines.add(med);
    });

    // Example notification: 5 seconds after adding
    var androidDetails =
        const AndroidNotificationDetails('channelId', 'channelName', importance: Importance.max);
    var generalNotificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
        0, 'Medicine Reminder', med.name, generalNotificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicine Reminder',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(
        medicines: medicines,
        onAddMedicine: addMedicine,
      ),
    );
  }
}