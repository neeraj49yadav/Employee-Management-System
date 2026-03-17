class EmployeeFilter {
  final String? role;
  final bool? isActive;

  const EmployeeFilter({
    this.role,
    this.isActive,
  });

  Map<String, dynamic> toQueryParams() {
    return {
      if (role != null) 'role': role,
      if (isActive != null) 'isActive': isActive,
    };
  }

  EmployeeFilter copyWith({
    String? role,
    bool? isActive,
  }) {
    return EmployeeFilter(
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
    );
  }
}
