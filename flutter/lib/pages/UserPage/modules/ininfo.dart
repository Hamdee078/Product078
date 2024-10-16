import 'package:flutter/material.dart';
import 'package:flutter1/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter1/HomePage.dart'; // Import your HomePage

class UserInfoTab extends StatelessWidget {
  const UserInfoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Access Token"),
        const SizedBox(height: 16),
        Consumer<UserProvider>(
          builder: (context, userProvider, child) => Text(
            userProvider.accessToken,
            style: const TextStyle(color: Colors.blue, fontSize: 10),
          ),
        ),
        const SizedBox(height: 16),
        const Text("Refresh Token"),
        const SizedBox(height: 16),
        Consumer<UserProvider>(
          builder: (context, userProvider, child) => Text(
            userProvider.refreshToken,
            style: const TextStyle(color: Colors.blue, fontSize: 10),
          ),
        ),
        const SizedBox(height: 16),

        // Logout Button
        ElevatedButton(
          onPressed: () {
            // Show confirmation dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    'ยืนยันการออกจากระบบ',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
                  ),
                  content: Text(
                    'คุณต้องการที่จะ Logout ใช่หรือไม่?',
                    style: TextStyle(color: Colors.black87),
                  ),
                  actions: [
                    // No button styled
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'ไม่',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    // Yes button styled
                    TextButton(
                      onPressed: () {
                        Provider.of<UserProvider>(context, listen: false).onLogout();
                        Navigator.of(context).pop(); // Close the dialog
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                          (route) => false, // Removes all previous routes
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'ใช่',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(120, 50), // Set button size to match other buttons
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: const Color.fromARGB(255, 255, 25, 0), // Set button color to red
          ),
          child: const Text(
            'Logout',
            style: TextStyle(
              color: Colors.white, // Text color to white
            ),
          ),
        ),
      ],
    );
  }
}
