import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/employee/presentation/screens/employee_list_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../theme/theme_provider.dart';

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {

  int index = 0;

  final screens = const [
    DashboardScreen(),
    EmployeeListScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(

      appBar: AppBar(
        title: const Text("Employee Management"),
        actions: [

          IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),

        ],
      ),

      drawer: !isDesktop
          ? Drawer(
              child: Column(
                children: [

                  const DrawerHeader(
                    child: Text("Menu"),
                  ),

                  _item(Icons.dashboard, "Dashboard", 0),
                  _item(Icons.people, "Employees", 1),
                  _item(Icons.settings, "Settings", 2),

                ],
              ),
            )
          : null,

      body: Row(
        children: [

          if (isDesktop)
            NavigationRail(
              selectedIndex: index,
              labelType: NavigationRailLabelType.all,
              onDestinationSelected: (i) {
                setState(() {
                  index = i;
                });
              },
              destinations: const [

                NavigationRailDestination(
                  icon: Icon(Icons.dashboard),
                  label: Text("Dashboard"),
                ),

                NavigationRailDestination(
                  icon: Icon(Icons.people),
                  label: Text("Employees"),
                ),

                NavigationRailDestination(
                  icon: Icon(Icons.settings),
                  label: Text("Settings"),
                ),

              ],
            ),

          Expanded(child: screens[index]),

        ],
      ),
    );
  }

  Widget _item(IconData icon, String label, int i) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        setState(() {
          index = i;
        });
        Navigator.pop(context);
      },
    );
  }
}