# Medicine Reminder 

This project is a **Flutter-based medicine reminder app** designed for elderly people and anyone who needs help keeping track of their daily medications. Users can add their medicines and the app sends notifications at scheduled times.

## Features

- Single codebase for **Android, iOS, and Web**
- User-friendly interface
- Add, edit, and delete medicines
- Daily reminder notifications
- Secure local storage (SQLite / Hive)
- Clear and readable design for elderly users

## Technologies

- **Flutter & Dart**
- Database: SQLite or Hive
- Notifications: flutter_local_notifications

## Installation

1. Clone the repository:  
   ```bash
   git clone https://github.com/asya-yilmaz/medicine-reminder.git

2. Flutter Starter Code (main.dart)**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicine Reminder',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final TextEditingController _controller = TextEditingController();
  List<String> medicines = [];

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void addMedicine() async {
    if (_controller.text.isEmpty) return;
    setState(() {
      medicines.add(_controller.text);
    });


    var androidDetails = AndroidNotificationDetails(
        'channelId', 'channelName',
        importance: Importance.max);
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails);
    await flutterLocalNotificationsPlugin.show(
        0, 'Medicine Reminder', _controller.text, generalNotificationDetails);

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Medicine Reminder')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Medicine Name'),
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: addMedicine, child: Text('Add')),
            Expanded(
              child: ListView.builder(
                itemCount: medicines.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(medicines[index]));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
