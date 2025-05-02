import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import google_fonts
import 'homescreen.dart'; // Import the homepage.dart file
import 'profile.dart';
import 'main.dart';

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
        // Navigate to Assessment Page (replace with your actual page)
        Navigator.pop(context); // Example: Go back
      } else if (index == 2) {
        // Navigate to User Profile Page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UserProfile()),
        );
      }
      // index 3 is the current settings page, so no navigation needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Account'),
              _buildSettingsItem('User Name', _buildSettingsItemText('Text')),
              _buildDivider(),
              _buildSettingsItem('Avatar', _buildAvatar()),
              _buildDivider(),
              _buildSettingsItem('About Me', _buildSettingsItemText('Write a little about yourself')),
              _buildDivider(),
              _buildSettingsItem('Email', _buildSettingsItemText('username@gmail.com')),
              _buildDivider(),
              _buildSettingsItem('I am', _buildSettingsItemText('Hearing Impaired person')),
              _buildDivider(),
              const SizedBox(height: 16),
              _buildSectionTitle('General'),
              _buildSettingsItem('Notification', _buildSwitch()),
              _buildDivider(),
              _buildSettingsItem('Interface language', _buildSettingsItemText('English')),
              _buildDivider(),
              _buildSettingsItem('Support', _buildSettingsItemText('Contact us')),
              _buildDivider(),
              const SizedBox(height: 24),
              _buildClearLessons(),
              const SizedBox(height: 24),
              _buildLogoutButton(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _BottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          color: const Color(0xFF121212),
          fontSize: 18,
          fontWeight: FontWeight.w500,
          letterSpacing: -0.05,
        ),
      ),
    );
  }

  Widget _buildSettingsItem(String label, Widget trailing) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              color: const Color(0xFF121212),
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.05,
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  Widget _buildSettingsItemText(String text) {
    return Text(
      text,
      textAlign: TextAlign.right,
      style: GoogleFonts.poppins(
        color: const Color(0xFF8A8A8E),
        fontSize: 16,
        letterSpacing: -0.05,
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: Color(0xFFF1F1F1),
      height: 1,
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFD7D7D7),
        image: const DecorationImage(
          image: NetworkImage("https://placehold.co/32x32"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildSwitch() {
    return const SizedBox(width: 40, height: 24); // Placeholder for a switch (adjust size as needed)
  }

  Widget _buildClearLessons() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Clear lessons date',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF121212),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.05,
                ),
              ),
              Text(
                '669.6kb',
                textAlign: TextAlign.right,
                style: GoogleFonts.poppins(
                  color: const Color(0xFFD7D7D7),
                  fontSize: 16,
                  letterSpacing: -0.05,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Free up space on your device. Information about archives within the lessons will not be lost',
            style: GoogleFonts.poppins(
              color: const Color(0xFF121212),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.43,
              letterSpacing: -0.04,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF007AFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Clear',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.41,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        },
        child: Text(
          'Log out',
          style: GoogleFonts.poppins(
            color: const Color(0xFFD53F36),
            fontSize: 18,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.05,
          ),
        ),
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
      mainAxisSize: MainAxisSize.min, // Changed to min to wrap content
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFE5F2FF),
            borderRadius: BorderRadius.circular(0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround, // Changed to spaceAround for better distribution
            children: [
              _buildIconButton(Icons.home, 0, selectedIndex == 0, context, 'Home'),
              _buildIconButton(Icons.school, 1, selectedIndex == 1, context, 'Assess'),
              _buildIconButton(Icons.person, 2, selectedIndex == 2, context, 'Profile'),
              _buildIconButton(Icons.settings, 3, selectedIndex == 3, context, 'Settings'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, int index, bool isSelected, BuildContext context, String label) {
    return InkWell( // Use InkWell for better tap feedback
      onTap: () {
        onItemTapped(index);
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else if (index == 1) {
          // Navigate to Assessment Page (replace with your actual page)
          Navigator.pop(context); // Example: Go back
        } else if (index == 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const UserProfile()),
          );
        }
        // index 3 is the current settings page, no navigation needed
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFF00254C) : const Color(0xFF007AFF),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFF00254C) : const Color(0xFF007AFF),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
