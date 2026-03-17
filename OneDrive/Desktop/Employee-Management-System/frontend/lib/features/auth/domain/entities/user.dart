// lib/features/auth/domain/entities/user.dart

class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final List<String> permissions;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.permissions,
  });

  bool hasPermission(String permission) {
    return permissions.contains(permission);
  }
}