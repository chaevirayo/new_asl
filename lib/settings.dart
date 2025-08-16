import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import google_fonts
import 'homescreen.dart'; // Import the homepage.dart file
import 'profile.dart';
import 'lesson.dart';
import 'main.dart'; // Import the main.dart file for the LoginScreen

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  int _selectedIndex = 3; // Initialize selected index to 3 (SETTINGS)
  bool _notificationsEnabled = true; // State for notification toggle

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else if (index == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LessonScreen()),
        );
      } else if (index == 2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UserProfile()),
        );
      }
    });
  }

  void _logout() {
    // Navigate back to the Login Screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF007AFF),
      body: Stack(
        children: [
          // Title at the top
          Positioned(
            top: 80, // Adjusted position
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Settings',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // White card container for settings
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      // Notifications setting
                      _buildSettingsItem(
                        title: 'Enable Notifications',
                        icon: Icons.notifications_outlined,
                        trailing: Switch(
                          value: _notificationsEnabled,
                          onChanged: (value) {
                            setState(() {
                              _notificationsEnabled = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Account preferences
                      _buildSettingsItem(
                        title: 'Account Preferences',
                        icon: Icons.person_outline,
                        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserProfile()),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      // Logout button
                      _buildSettingsItem(
                        title: 'Logout',
                        icon: Icons.logout,
                        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                        onTap: _logout,
                      ),
                      const Spacer(),
                      // Bottom navigation bar
                      _BottomNavigationBar(
                        selectedIndex: _selectedIndex,
                        onItemTapped: _onItemTapped,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required String title,
    required IconData icon,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: const Color(0xFF007AFF)),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            trailing ?? const SizedBox(),
          ],
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
    return Container(
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
    );
  }

  Widget _buildIconButton(
      IconData icon, int index, bool isSelected, BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: isSelected ? const Color(0xFF00254C) : const Color(0xFF007AFF),
      ),
      onPressed: () => onItemTapped(index),
    );
  }
}