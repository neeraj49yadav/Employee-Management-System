import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_notifier.dart';
import '../../../../core/theme/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Padding(
      padding: const EdgeInsets.all(24),

      child: ListView(
        children: [

          const Text(
            "Settings",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
            subtitle: const Text("View account information"),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text("Toggle Dark Mode"),
            onTap: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),

          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("About Us"),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.contact_mail),
            title: const Text("Contact Us"),
            onTap: () {},
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              ref.read(authNotifierProvider.notifier).logout();
            },
          ),

        ],
      ),
    );
  }
}