import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'alphabet.dart';
import 'basic_words.dart';
import 'verbs.dart';
import 'homescreen.dart';
import 'profile.dart';
import 'settings.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF007AFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF007AFF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Redirect back to the HomePage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
        title: Text('Lessons', style: GoogleFonts.poppins(color: Colors.white)),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      'What do you want to learn today?',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF007AFF),
                      ),
                    ),
                    const SizedBox(height: 40),
                    _buildLessonButton(context, 'ALPHABET', const AlphabetLesson()),
                    const SizedBox(height: 20),
                    _buildLessonButton(context, 'BASIC WORDS', const BasicWordsLesson()),
                    const SizedBox(height: 20),
                    _buildLessonButton(context, 'VERBS', const VerbsLesson()),
                    const Spacer(),
                    _BottomNavigationBar(selectedIndex: 1),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonButton(BuildContext context, String text, Widget targetScreen) {
    return SizedBox(
      width: 250,
      height: 75,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => targetScreen));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE5F2FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  final int selectedIndex;

  const _BottomNavigationBar({required this.selectedIndex});

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
          IconButton(
            icon: Icon(
              Icons.home,
              color: selectedIndex == 0 ? const Color(0xFF00254C) : const Color(0xFF007AFF),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.school,
              color: selectedIndex == 1 ? const Color(0xFF00254C) : const Color(0xFF007AFF),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              color: selectedIndex == 2 ? const Color(0xFF00254C) : const Color(0xFF007AFF),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const UserProfile()),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: selectedIndex == 3 ? const Color(0xFF00254C) : const Color(0xFF007AFF),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const UserSettings()),
              );
            },
          ),
        ],
      ),
    );
  }
}