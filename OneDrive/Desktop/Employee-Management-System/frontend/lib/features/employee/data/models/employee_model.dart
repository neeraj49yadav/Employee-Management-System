class Employee {
  final String id;
  final String name;
  final String email;
  final String department;
  final String position;
  final double salary;

  Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.department,
    required this.position,
    required this.salary,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      department: json["department"] ?? "",
      position: json["position"] ?? "",
      salary: (json["salary"] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "department": department,
      "position": position,
      "salary": salary,
    };
  }
}