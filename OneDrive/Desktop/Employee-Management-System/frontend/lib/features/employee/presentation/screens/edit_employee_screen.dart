import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../data/models/employee_model.dart';
import '../providers/employee_provider.dart';

class EditEmployeeScreen extends ConsumerStatefulWidget {
  final Employee employee;

  const EditEmployeeScreen({
    super.key,
    required this.employee,
  });

  @override
  ConsumerState<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends ConsumerState<EditEmployeeScreen> {

  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController departmentController;
  late TextEditingController positionController;
  late TextEditingController salaryController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.employee.name);
    emailController = TextEditingController(text: widget.employee.email);
    departmentController = TextEditingController(text: widget.employee.department);
    positionController = TextEditingController(text: widget.employee.position);
    salaryController = TextEditingController(text: widget.employee.salary.toString());
  }

  Future<void> updateEmployee() async {

    if (!_formKey.currentState!.validate()) return;

    final updatedEmployee = Employee(
      id: widget.employee.id,
      name: nameController.text,
      email: emailController.text,
      department: departmentController.text,
      position: positionController.text,
      salary: double.parse(salaryController.text),
    );

    await ref.read(employeeProvider.notifier).updateEmployee(updatedEmployee);

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Employee"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: ListView(
            children: [

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) =>
                    value!.isEmpty ? "Enter name" : null,
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) =>
                    value!.isEmpty ? "Enter email" : null,
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: departmentController,
                decoration: const InputDecoration(labelText: "Department"),
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: positionController,
                decoration: const InputDecoration(labelText: "Position"),
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: salaryController,
                decoration: const InputDecoration(labelText: "Salary"),
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: updateEmployee,
                child: const Text("Update Employee"),
              )

            ],
          ),
        ),
      ),
    );
  }
}