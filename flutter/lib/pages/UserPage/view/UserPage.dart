import 'package:flutter/material.dart';
import 'package:flutter1/controllers/User_controller.dart';
import 'package:flutter1/pages/UserPage/modules/ininfo.dart';
import 'package:flutter1/pages/UserPage/modules/product/index.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // Controller to manage the tab index
  late UserPageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = UserPageController(); // Initialize the controller
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Page'),
        backgroundColor: const Color.fromARGB(0, 253, 250, 250), // Make the AppBar background transparent
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 29, 90, 245), // Start color (blue)
                Color.fromARGB(255, 255, 255, 255), // End color (white)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), // Make edges rounded
          border: Border.all(color: Colors.blueAccent, width: 2), // Add a blue border around the content
        ),
        child: IndexedStack(
          index: _controller.selectedIndex, // Show the selected tab content
          children: const [
            UserInfoTab(), // Display the user information tab
            ProductTab(),  // Display the product tab
          ],
        ),
      ),
      backgroundColor: Colors.white, // Set the background color to white for a clean look
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _controller.selectedIndex, // The currently selected tab
        onTap: (int i) {
          setState(() {
            _controller.updateIndex(i); // Update index through the controller
          });
        },
        backgroundColor: Colors.blueAccent, // Blue background for the bottom bar
        selectedItemColor: Colors.white, // White color for the active tab
        unselectedItemColor: Colors.lightBlueAccent, // Light blue for inactive tabs
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'ข้อมูลผู้ใช้', // User Info Tab
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'สินค้า', // Product Tab
          ),
        ],
      ),
    );
  }
}
