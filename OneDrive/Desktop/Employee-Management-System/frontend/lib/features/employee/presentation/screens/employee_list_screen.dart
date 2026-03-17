import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../providers/employee_provider.dart';
import '../../data/models/employee_model.dart';
import 'create_employee_screen.dart';
import 'edit_employee_screen.dart';

class EmployeeListScreen extends ConsumerStatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  ConsumerState<EmployeeListScreen> createState() =>
      _EmployeeListScreenState();
}

class _EmployeeListScreenState extends ConsumerState<EmployeeListScreen> {

  final searchController = TextEditingController();

  /*
  |--------------------------------------------------------------------------
  | Upload CSV (WEB SAFE)
  |--------------------------------------------------------------------------
  */

  Future<void> uploadCSV() async {

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
      withData: true,
    );

    if (result == null) return;

    final file = result.files.single;

    final api = ref.read(apiClientProvider);

    final formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(
        file.bytes!,
        filename: file.name,
      )
    });

    try {

      await api.dio.post(
        "/employees/import",
        data: formData,
      );

      ref.read(employeeProvider.notifier).loadEmployees();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("CSV uploaded successfully")),
        );
      }

    } catch (e) {

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("CSV upload failed: $e")),
        );
      }

    }
  }

  /*
  |--------------------------------------------------------------------------
  | Export CSV (Authenticated)
  |--------------------------------------------------------------------------
  */

  Future<void> exportCSV() async {

    final api = ref.read(apiClientProvider);

    try {

      final response = await api.dio.get(
        "/employees/export",
        options: Options(responseType: ResponseType.bytes),
      );

      debugPrint("CSV downloaded. Size: ${response.data.length}");

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("CSV exported successfully")),
        );
      }

    } catch (e) {

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Export failed: $e")),
        );
      }

    }
  }

  @override
  Widget build(BuildContext context) {

    final employeesAsync = ref.watch(employeeProvider);

    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Employees",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [

                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      labelText: "Search employees",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      ref.read(employeeProvider.notifier).search(value);
                    },
                  ),
                ),

                const SizedBox(width: 10),

                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text("Add"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CreateEmployeeScreen(),
                      ),
                    );
                  },
                ),

                const SizedBox(width: 10),

                ElevatedButton.icon(
                  icon: const Icon(Icons.upload),
                  label: const Text("Upload CSV"),
                  onPressed: uploadCSV,
                ),

                const SizedBox(width: 10),

                ElevatedButton.icon(
                  icon: const Icon(Icons.download),
                  label: const Text("Export CSV"),
                  onPressed: exportCSV,
                ),

              ],
            ),

            const SizedBox(height: 20),

            Expanded(

              child: employeesAsync.when(

                loading: () =>
                    const Center(child: CircularProgressIndicator()),

                error: (err, stack) =>
                    Center(child: Text(err.toString())),

                data: (employees) {

                  if (employees.isEmpty) {
                    return const Center(
                      child: Text("No employees found"),
                    );
                  }

                  return SingleChildScrollView(

                    child: DataTable(

                      columns: const [

                        DataColumn(label: Text("Name")),
                        DataColumn(label: Text("Email")),
                        DataColumn(label: Text("Department")),
                        DataColumn(label: Text("Position")),
                        DataColumn(label: Text("Actions")),

                      ],

                      rows: employees.map((Employee employee) {

                        return DataRow(
                          cells: [

                            DataCell(Text(employee.name)),
                            DataCell(Text(employee.email)),
                            DataCell(Text(employee.department)),
                            DataCell(Text(employee.position ?? "")),

                            DataCell(
                              Row(
                                children: [

                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              EditEmployeeScreen(
                                                employee: employee,
                                              ),
                                        ),
                                      );

                                    },
                                  ),

                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {

                                      ref
                                          .read(employeeProvider.notifier)
                                          .deleteEmployee(employee.id);

                                    },
                                  ),

                                ],
                              ),
                            ),

                          ],
                        );

                      }).toList(),

                    ),

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