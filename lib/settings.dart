import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import google_fonts
import 'homescreen.dart'; // Import the homepage.dart file
import 'profile.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  int _selectedIndex = 3; // Initialize selected index to 3 (SETTINGS)

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Add navigation logic here if you want other icons to navigate away
      if (index == 0) {
        // Navigate to Home Page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else if (index == 1) {
        // Navigate to Assessment Page
        Navigator.pop(context); // Example: Go back to the previous page
      } else if (index == 2) {
        // Navigate to User Profile Page
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const UserProfile()),
        );      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF007AFF),
      body: Stack(
        children: [
          // Centered "User Profile!" title
          Positioned(
            top: 125, // Adjust this value to position "User Profile!" correctly
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'User Settings!',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // White card background
          Positioned(
            top: 200, // Adjust top position of the white container
            left: 0,
            right: 0,
            bottom: 0, // Extend to the bottom
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(34)), // Rounded top only
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 30), // Top padding inside the container
                    const SizedBox(height: 50), // Space for content
                    const Spacer(), // Push the bottom navigation bar to the bottom
                    _BottomNavigationBar(
                      selectedIndex: _selectedIndex,
                      onItemTapped: _onItemTapped,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const _BottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFE5F2FF),
            borderRadius: BorderRadius.circular(0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildIconButton(Icons.home, 0, selectedIndex == 0, context),
              _buildIconButton(Icons.school, 1, selectedIndex == 1, context),
              _buildIconButton(Icons.person, 2, selectedIndex == 2, context),
              _buildIconButton(Icons.settings, 3, selectedIndex == 3, context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, int index, bool isSelected, BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: isSelected ? const Color(0xFF00254C) : const Color(0xFF007AFF),
      ),
      onPressed: () {
        onItemTapped(index);
        if (index == 0) {
          // Navigate to Home Page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      },
    );
  }
}