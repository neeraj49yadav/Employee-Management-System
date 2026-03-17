import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/employee.dart';
import '../providers/employee_provider.dart';

class EmployeeFormScreen extends ConsumerStatefulWidget {
  final Employee? employee;

  const EmployeeFormScreen({super.key, this.employee});

  @override
  ConsumerState<EmployeeFormScreen> createState() =>
      _EmployeeFormScreenState();
}

class _EmployeeFormScreenState
    extends ConsumerState<EmployeeFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;

  String _selectedRole = "EMPLOYEE";
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();

    _nameController =
        TextEditingController(text: widget.employee?.name ?? '');
    _emailController =
        TextEditingController(text: widget.employee?.email ?? '');
    _selectedRole = widget.employee?.role ?? "EMPLOYEE";
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.employee != null;

    return Scaffold(
      appBar: AppBar(
        title:
            Text(isEdit ? "Edit Employee" : "Create Employee"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(maxWidth: 500),
            child: TweenAnimationBuilder(
              tween: Tween(begin: 0.95, end: 1.0),
              duration: const Duration(milliseconds: 300),
              builder:
                  (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: Opacity(
                    opacity: value,
                    child: child,
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(16),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          isEdit
                              ? "Update Employee Details"
                              : "Add New Employee",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium,
                        ),
                        const SizedBox(height: 24),

                        _buildNameField(),
                        const SizedBox(height: 16),

                        _buildEmailField(),
                        const SizedBox(height: 16),

                        _buildRoleDropdown(),
                        const SizedBox(height: 32),

                        _buildSubmitButton(isEdit),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: const InputDecoration(
        labelText: "Full Name",
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Name is required";
        }
        if (value.length < 2) {
          return "Name too short";
        }
        return null;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: "Email Address",
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Email is required";
        }
        if (!value.contains("@")) {
          return "Enter valid email";
        }
        return null;
      },
    );
  }

  Widget _buildRoleDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedRole,
      decoration: const InputDecoration(
        labelText: "Role",
        border: OutlineInputBorder(),
      ),
      items: const [
        DropdownMenuItem(
          value: "ADMIN",
          child: Text("ADMIN"),
        ),
        DropdownMenuItem(
          value: "HR",
          child: Text("HR"),
        ),
        DropdownMenuItem(
          value: "EMPLOYEE",
          child: Text("EMPLOYEE"),
        ),
      ],
      onChanged: (value) {
        setState(() {
          _selectedRole = value!;
        });
      },
    );
  }

  Widget _buildSubmitButton(bool isEdit) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed:
            _isSubmitting ? null : () => _submit(isEdit),
        child: AnimatedSwitcher(
          duration:
              const Duration(milliseconds: 200),
          child: _isSubmitting
              ? const SizedBox(
                  key: ValueKey("loading"),
                  height: 20,
                  width: 20,
                  child:
                      CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  isEdit
                      ? "Update Employee"
                      : "Create Employee",
                  key:
                      const ValueKey("text"),
                ),
        ),
      ),
    );
  }

  Future<void> _submit(bool isEdit) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      if (isEdit) {
        await ref.read(employeeProvider.notifier).updateEmployee(
              id: widget.employee!.id,
              name: _nameController.text.trim(),
              email: _emailController.text.trim(),
              role: _selectedRole,
            );
      } else {
        await ref.read(employeeProvider.notifier).createEmployee(
              name: _nameController.text.trim(),
              email: _emailController.text.trim(),
              role: _selectedRole,
            );
      }

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (_) {}

    if (mounted) {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
