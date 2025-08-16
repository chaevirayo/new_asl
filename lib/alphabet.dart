import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlphabetLesson extends StatelessWidget {
  const AlphabetLesson({super.key});

  @override
  Widget build(BuildContext context) {
    // List of letters and their corresponding image paths
    final alphabets = List.generate(
      26,
      (index) => {
        'letter': String.fromCharCode(65 + index), // A-Z
        'imagePath': 'assets/images/alphabet/${String.fromCharCode(97 + index)}.png' // a.png to z.png
      },
    );

    return Scaffold(
      backgroundColor: const Color(0xFF007AFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF007AFF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Alphabet Lesson',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
        ),
        child: ListView.builder(
          itemCount: alphabets.length, // Number of items in the list
          itemBuilder: (context, index) {
            final alphabet = alphabets[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                leading: Image.asset(
                  alphabet['imagePath']!, // Display the alphabet image
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                ),
                title: Text(
                  'Letter ${alphabet['letter']}',
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'Sign for ${alphabet['letter']}',
                  style: GoogleFonts.poppins(),
                ),
                onTap: () {
                  // Open the image in a larger view
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      contentPadding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Display the enlarged image
                          Image.asset(
                            alphabet['imagePath']!,
                            width: 200,
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 10),
                          // Display the letter as a title
                          Text(
                            'Letter ${alphabet['letter']}',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}