class Medicine {
  String name;
  String time; // format: HH:mm

  Medicine({required this.name, required this.time});

  Map<String, dynamic> toMap() {
    return {'name': name, 'time': time};
  }

  factory Medicine.fromMap(Map<String, dynamic> map) {
    return Medicine(
      name: map['name'],
      time: map['time'],
    );
  }
}