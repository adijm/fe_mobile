import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: const Text(
        "Are you sure you want to\nLog Out?",
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true); // Confirm logout
          },
          child: const Text("Yes, Log Out"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false); // Cancel
          },
          child: const Text("Cancel", style: TextStyle(color: Colors.red)),
        )
      ],
    );
  }
}
