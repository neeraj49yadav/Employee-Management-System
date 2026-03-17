import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/employee_provider.dart';

class CreateEmployeeScreen extends ConsumerStatefulWidget {
  const CreateEmployeeScreen({super.key});

  @override
  ConsumerState<CreateEmployeeScreen> createState() =>
      _CreateEmployeeScreenState();
}

class _CreateEmployeeScreenState
    extends ConsumerState<CreateEmployeeScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final departmentController = TextEditingController();
  final positionController = TextEditingController();
  final salaryController = TextEditingController();

  Future<void> createEmployee() async {
    await ref.read(employeeProvider.notifier).createEmployee(
          nameController.text,
          emailController.text,
          departmentController.text,
          positionController.text,
          double.tryParse(salaryController.text) ?? 0,
        );

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Employee"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: departmentController,
              decoration: const InputDecoration(labelText: "Department"),
            ),
            TextField(
              controller: positionController,
              decoration: const InputDecoration(labelText: "Position"),
            ),
            TextField(
              controller: salaryController,
              decoration: const InputDecoration(labelText: "Salary"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: createEmployee,
              child: const Text("Create"),
            )
          ],
        ),
      ),
    );
  }
}