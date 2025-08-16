import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'lesson.dart'; // Import the lesson screen
import 'profile.dart'; // Import the profile.dart file
import 'settings.dart';
import 'assess.dart'; // Import the assess.dart file

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
      if (index == 0) {
        // Already on Home Page
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
      } else if (index == 3) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UserSettings()),
        );
      }
    });
  }

  void _handleMenuButtonTap(String buttonText) {
    if (buttonText == 'LESSONS') {
      _onItemTapped(1);
    } else if (buttonText == 'ASSESSMENT') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AssessmentScreen()),
      );
      print('$buttonText button tapped');
    } else if (buttonText == 'PROFILE') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserProfile()),
      );
      print('$buttonText button tapped');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF007AFF),
      body: Stack(
        children: [
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    const SizedBox(height: 50),
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
                    const Spacer(),
                    _BottomNavigationBar(
                      selectedIndex: _selectedIndex,
                      onItemTapped: _onItemTapped,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
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

  Widget _buildIconButton(IconData icon, int index, bool isSelected, BuildContext context) {
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

  TextStyle _buttonTextStyle(bool isTapped) => GoogleFonts.poppins(
        color: isTapped ? Colors.white : Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );

  BoxDecoration _buttonDecoration(bool isTapped) => BoxDecoration(
        color: isTapped ? const Color(0xFF007AFF) : const Color(0xFFE5F2FF),
        borderRadius: BorderRadius.circular(30),
      );

  final EdgeInsets _buttonPadding = const EdgeInsets.symmetric(horizontal: 36);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => _isTapped = true);
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
        Future.delayed(const Duration(milliseconds: 200), () {
          setState(() => _isTapped = false);
        });
      },
      child: SizedBox(
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