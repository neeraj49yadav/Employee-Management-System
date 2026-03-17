import 'package:flutter/material.dart';

class ActivityLog extends StatelessWidget {

  final List<String> activities;

  const ActivityLog({
    super.key,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Recent Activity",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            if (activities.isEmpty)
              const Text("No activity yet"),

            ...activities.map((activity) {

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(activity),
              );

            }),

          ],
        ),
      ),
    );
  }
}