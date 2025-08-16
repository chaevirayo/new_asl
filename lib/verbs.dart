import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart'; // Import video player package

class VerbsLesson extends StatelessWidget {
  const VerbsLesson({super.key});

  @override
  Widget build(BuildContext context) {
    // Map each verb to its corresponding video asset or URL
    final Map<String, String> verbVideos = {
      'Run': 'assets/videos/run1.mp4',
      'Jump': 'assets/videos/jump1.mp4',
      'Eat': 'assets/videos/eat1.mp4',
      'Sleep': 'assets/videos/sleep1.mp4',
      'Write': 'assets/videos/write1.mp4',
    };

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
          'Verbs',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Common Verbs in ASL:',
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            ...verbVideos.keys.map((verb) => Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                title: Text(verb, style: GoogleFonts.poppins()),
                trailing: const Icon(Icons.play_circle_fill, color: Color(0xFF007AFF)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPlayerScreen(
                        verb: verb,
                        videoPath: verbVideos[verb]!,
                      ),
                    ),
                  );
                },
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String verb;
  final String videoPath;

  const VideoPlayerScreen({
    super.key,
    required this.verb,
    required this.videoPath,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {}); // Refresh the widget once the video is initialized
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the video controller to free resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.verb,
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF007AFF),
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}