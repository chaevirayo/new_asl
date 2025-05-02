import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'aboutuser1.dart'; // Ensure you have a file named about1.dart

class UserPass extends StatelessWidget {
  const UserPass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF007AFF),
      body: Stack(
        children: [
          Positioned(
            top: 125,
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
                      Text(
                        'Sign up to start learning',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const UserNameInput(),
                      const SizedBox(height: 20),
                      const PasswordInput(),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF007AFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            print('Continue button pressed - Navigating to UserPass...');
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const About1()),
                            );
                          },
                          child: Text(
                            'Continue',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          'By joining, I declare that I have read and accept the Terms and Privacy Policy',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF8A8A8E),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            children: [
                              WidgetSpan(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                  child: Text(
                                    'Log in',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF007AFF),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
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
}

class UserNameInput extends StatelessWidget {
  const UserNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'User Name',
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'username001',
            filled: true,
            hintStyle: const TextStyle(color: Color(0xFFD7D7D7)),
            fillColor: const Color(0xFFF8F8F8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFF1F1F1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF007AFF)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Create a unique username, you can use numbers from 0 to 9 and underscores and dashes',
          style: GoogleFonts.poppins(
            color: const Color(0xFF121212),
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.25,
            letterSpacing: -0.05,
          ),
        ),
      ],
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Enter your password',
            filled: true,
            hintStyle: const TextStyle(color: Color(0xFFD7D7D7)),
            fillColor: const Color(0xFFF8F8F8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFF1F1F1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF007AFF)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            suffixIcon: const SizedBox(width: 24, height: 24),
          ),
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Your password must contain ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF121212),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.25,
                  letterSpacing: -0.05,
                ),
              ),
              TextSpan(
                text: '8 characters',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF121212),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.25,
                  letterSpacing: -0.06,
                ),
              ),
              const TextSpan(
                text: ', ',
                style: TextStyle(
                  color: Color(0xFF121212),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.25,
                  letterSpacing: -0.05,
                ),
              ),
              TextSpan(
                text: '1 uppercase and 1 number.',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF121212),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.25,
                  letterSpacing: -0.06,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
