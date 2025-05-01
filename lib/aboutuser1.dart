import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import google_fonts
import 'homescreen.dart'; // Import the homepage.dart file
import 'userpass.dart';

abstract class about1 extends StatefulWidget {
  const about1({super.key});

  get _selectedIndex => null;

  get _onItemTapped => null;


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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}