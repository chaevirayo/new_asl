import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import google_fonts
import 'profile.dart'; // Import the profile.dart file
import 'settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        // Navigate to Assessment Page (replace with your actual page)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Placeholder()), // Replace Placeholder
        );
      } else if (index == 2) {
        // Navigate to the UserProfile page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UserProfile()),
        );
      } else if (index == 3) {
        // Navigate to Settings Page (replace with your actual page)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UserSettings()), // Replace Placeholder
        );
      }
    });
  }

  void _handleMenuButtonTap(String buttonText) {
    if (buttonText == 'LESSONS') {
      _onItemTapped(0); // Mimic home button tap
    } else if (buttonText == 'ASSESSMENT') {
      _onItemTapped(1); // Mimic school button tap
    } else if (buttonText == 'PROFILE') {
      // Navigate to the profile page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserProfile()),
      );
      print('$buttonText button tapped');
    }
    // You can add specific navigation or actions for each menu button here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF007AFF),
      body: Stack(
        children: [
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
                    const SizedBox(height: 50), // Space for the welcome text
                    TappableMenuButton(
                      text: 'LESSONS',
                      onPressed: () => _handleMenuButtonTap('LESSONS'),
                    ),
                    const SizedBox(height: 20),
                    TappableMenuButton(
                      text: 'ASSESSMENT',
                      onPressed: () => _handleMenuButtonTap('ASSESSMENT'),
                    ),
                    const SizedBox(height: 20),
                    TappableMenuButton(
                      text: 'PROFILE',
                      onPressed: () => _handleMenuButtonTap('PROFILE'),
                    ),
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
          // Welcome text positioned above the white container
          Positioned(
            top: 100, // Adjust this value to position the text correctly
            left: 24,
            right: 24,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Welcome to ASL Learning App, ',
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: 'username',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
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
              _buildIconButton(Icons.home, 0, selectedIndex == 0),
              _buildIconButton(Icons.school, 1, selectedIndex == 1),
              _buildIconButton(Icons.person, 2, selectedIndex == 2),
              _buildIconButton(Icons.settings, 3, selectedIndex == 3),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, int index, bool isSelected) {
    return IconButton(
      icon: Icon(
        icon,
        color: isSelected ? const Color(0xFF00254C) : const Color(0xFF007AFF),
      ),
      onPressed: () => onItemTapped(index),
    );
  }
}

class TappableMenuButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;

  const TappableMenuButton({super.key, required this.text, this.onPressed});

  @override
  State<TappableMenuButton> createState() => _TappableMenuButtonState();
}

class _TappableMenuButtonState extends State<TappableMenuButton> {
  bool _isTapped = false;

  // Define styles as variables
  TextStyle _buttonTextStyle(bool isTapped) => GoogleFonts.poppins( // Apply Poppins here
    color: isTapped ? Colors.white : Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  BoxDecoration _buttonDecoration(bool isTapped) => BoxDecoration(
    color: isTapped ? const Color(0xFF007AFF) : const Color(0xFFE5F2FF),
    borderRadius: BorderRadius.circular(30),
  );

  EdgeInsets _buttonPadding = const EdgeInsets.symmetric(horizontal: 36); // Removed vertical padding

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => _isTapped = true);
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
        if (widget.text == 'PROFILE') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UserProfile()),
          );
        }
        // Revert the tapped state after a short delay
        Future.delayed(const Duration(milliseconds: 200), () {
          setState(() => _isTapped = false);
        });
      },
      child: SizedBox( // Use SizedBox to control the size
        width: 250,
        height: 75,
        child: Container(
          padding: _buttonPadding,
          decoration: _buttonDecoration(_isTapped),
          child: Center(
            child: Text(
              widget.text,
              style: _buttonTextStyle(_isTapped),
            ),
          ),
        ),
      ),
    );
  }
}