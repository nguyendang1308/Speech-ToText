import 'package:avatar_glow/avatar_glow.dart';
import 'package:demo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchVoice(),
    );
  }
}

class SearchVoice extends StatefulWidget {
  const SearchVoice({super.key});

  @override
  State<SearchVoice> createState() => _SearchVoiceState();
}

class _SearchVoiceState extends State<SearchVoice> {
  late SpeechToText speechToText;
  var text = "Hold the button";
  var isListening = false;

  @override
  void initState() {
    super.initState();
    speechToText = SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius: 75,
        animate: isListening,
        duration: const Duration(milliseconds: 2000),
        glowColor: bgColor,
        repeat: true,
        repeatPauseDuration: const Duration(milliseconds: 100),
        showTwoGlows: true,
        child: GestureDetector(
          onTapDown: (details) async {
            if (!isListening) {
              var available = await speechToText.initialize();
              if (available) {
                setState(() {
                  isListening = true;
                  speechToText.listen(
                    onResult: (result) {
                      setState(() {
                        text = result.recognizedWords;
                      });
                    },
                  );
                });
              }
            }
          },
          onTapUp: (details) {
            setState(() {
              isListening = false;
            });
            speechToText.stop();
          },
          child: const CircleAvatar(
            backgroundColor: bgColor,
            radius: 35,
            child: Icon(
              Icons.mic,
              color: Colors.white,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: bgColor,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Speech to Text",
          style: TextStyle(fontWeight: FontWeight.w600, color: textColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          margin: const EdgeInsets.only(bottom: 150),
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 24,
                color: Colors.black87,
                fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}
