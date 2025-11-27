import 'package:flutter/material.dart';
import '../models/medicine.dart';

class HomeScreen extends StatefulWidget {
  final List<Medicine> medicines;
  final Function(Medicine) onAddMedicine;

  const HomeScreen({super.key, required this.medicines, required this.onAddMedicine});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medicine Reminder')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Medicine Name'),
            ),
            TextField(
              controller: _timeController,
              decoration: const InputDecoration(labelText: 'Time (HH:mm)'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isEmpty || _timeController.text.isEmpty) return;
                final newMed = Medicine(
                    name: _nameController.text, time: _timeController.text);
                widget.onAddMedicine(newMed);
                _nameController.clear();
                _timeController.clear();
              },
              child: const Text('Add Medicine'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.medicines.length,
                itemBuilder: (context, index) {
                  final med = widget.medicines[index];
                  return ListTile(
                    title: Text(med.name),
                    subtitle: Text(med.time),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}