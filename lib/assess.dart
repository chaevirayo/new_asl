import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class AssessmentScreen extends StatelessWidget {
  const AssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF007AFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF007AFF),
        title: Text(
          'Assessment',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Choose Difficulty',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              _buildCategoryButton(
                context,
                category: 'Easy',
                color: Colors.greenAccent,
              ),
              const SizedBox(height: 20),
              _buildCategoryButton(
                context,
                category: 'Medium',
                color: Colors.orangeAccent,
              ),
              const SizedBox(height: 20),
              _buildCategoryButton(
                context,
                category: 'Hard',
                color: Colors.redAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context, {required String category, required Color color}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizScreen(category: category),
          ),
        );
      },
      child: Text(
        category,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  final String category;

  const QuizScreen({super.key, required this.category});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _showFeedback = false;
  String _feedbackMessage = '';
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void _loadQuestions() {
    if (widget.category == 'Easy') {
      _questions.addAll([
        {
          'question': 'Which image represents the letter A?',
          'images': [
            {'path': 'assets/images/alphabet/1.png', 'isCorrect': true},
            {'path': 'assets/images/alphabet/2.png', 'isCorrect': false},
            {'path': 'assets/images/alphabet/3.png', 'isCorrect': false},
            {'path': 'assets/images/alphabet/4.png', 'isCorrect': false},
          ],
        },
        {
          'question': 'Which image represents the letter G?',
          'images': [
            {'path': 'assets/images/alphabet/5.png', 'isCorrect': false},
            {'path': 'assets/images/alphabet/6.png', 'isCorrect': false},
            {'path': 'assets/images/alphabet/7.png', 'isCorrect': true},
            {'path': 'assets/images/alphabet/8.png', 'isCorrect': false},
          ],
        },
      ]);
    } else if (widget.category == 'Medium') {
      _questions.addAll([
        {
          'question': 'Which video shows the ASL sign for "Hello"?',
          'videos': [
            {'path': 'assets/videos/hello.mp4', 'isCorrect': true},
            {'path': 'assets/videos/please.mp4', 'isCorrect': false},
            {'path': 'assets/videos/thank_you.mp4', 'isCorrect': false},
            {'path': 'assets/videos/sorry.mp4', 'isCorrect': false},
          ],
        },
        {
          'question': 'Which video shows the ASL sign for "Thank You"?',
          'videos': [
            {'path': 'assets/videos/hello.mp4', 'isCorrect': false},
            {'path': 'assets/videos/please.mp4', 'isCorrect': false},
            {'path': 'assets/videos/thank_you.mp4', 'isCorrect': true},
            {'path': 'assets/videos/sorry.mp4', 'isCorrect': false},
          ],
        },
      ]);
    } else if (widget.category == 'Hard') {
      _questions.addAll([
        {
          'question': 'Which video shows the ASL sign for "Run"?',
          'videos': [
            {'path': 'assets/videos/run.mp4', 'isCorrect': true},
            {'path': 'assets/videos/sleep.mp4', 'isCorrect': false},
            {'path': 'assets/videos/eat.mp4', 'isCorrect': false},
            {'path': 'assets/videos/jump.mp4', 'isCorrect': false},
          ],
        },
        {
          'question': 'Which video shows the ASL sign for "Jump"?',
          'videos': [
            {'path': 'assets/videos/run.mp4', 'isCorrect': false},
            {'path': 'assets/videos/sleep.mp4', 'isCorrect': false},
            {'path': 'assets/videos/eat.mp4', 'isCorrect': false},
            {'path': 'assets/videos/jump.mp4', 'isCorrect': true},
          ],
        },
      ]);
    }
  }

  void _answerQuestion(bool isCorrect, int index) {
    setState(() {
      _selectedIndex = index;
      if (isCorrect) {
        _score++;
        _feedbackMessage = 'Correct!';
      } else {
        _feedbackMessage = 'Wrong!';
      }
      _showFeedback = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showFeedback = false;
        _selectedIndex = null;
        if (_currentQuestionIndex < _questions.length - 1) {
          _currentQuestionIndex++;
        } else {
          _showResults();
        }
      });
    });
  }

  void _showResults() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Completed!'),
        content: Text('Your score: $_score / ${_questions.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Return to assessment screen
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final question = _questions[_currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category, style: GoogleFonts.poppins()),
        centerTitle: true,
        backgroundColor: const Color(0xFF007AFF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              question['question'],
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),
            if (widget.category == 'Easy')
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: question['images'].length,
                  itemBuilder: (context, index) {
                    final image = question['images'][index];
                    final isSelected = index == _selectedIndex;
                    return GestureDetector(
                      onTap: () => _answerQuestion(image['isCorrect'], index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.white,
                          border: Border.all(
                            color: isSelected ? Colors.blue : Colors.grey,
                            width: isSelected ? 3 : 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            image['path'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Text(
                                  'Image not found',
                                  style: TextStyle(color: Colors.red),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            if (widget.category == 'Medium' || widget.category == 'Hard')
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: question['videos'].length,
                  itemBuilder: (context, index) {
                    final video = question['videos'][index];
                    final isSelected = index == _selectedIndex;
                    return GestureDetector(
                      onTap: () => _answerQuestion(video['isCorrect'], index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.transparent,
                          border: Border.all(
                            color: isSelected ? Colors.blue : Colors.grey,
                            width: isSelected ? 3 : 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: VideoOption(
                          videoPath: video['path'],
                          onTap: () => _answerQuestion(video['isCorrect'], index),
                        ),
                      ),
                    );
                  },
                ),
              ),
            if (_showFeedback)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  _feedbackMessage,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _feedbackMessage == 'Correct!' ? Colors.green : Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class VideoOption extends StatefulWidget {
  final String videoPath;
  final VoidCallback onTap;

  const VideoOption({super.key, required this.videoPath, required this.onTap});

  @override
  _VideoOptionState createState() => _VideoOptionState();
}

class _VideoOptionState extends State<VideoOption> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Expanded(
            child: _controller.value.isInitialized
                ? GestureDetector(
                    onTap: () {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
          ElevatedButton(
            onPressed: widget.onTap,
            child: const Text('Select'),
          ),
        ],
      ),
    );
  }
}