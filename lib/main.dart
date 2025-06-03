import 'package:flutter/material.dart';
import 'screens/landing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Litera App',
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _iconController;
  late Animation<Offset> _iconOffset;
  late AnimationController _textController;
  bool _showText = false;

  @override
  void initState() {
    super.initState();

    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _iconOffset = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(-0.8, 0),
    ).animate(
      CurvedAnimation(parent: _iconController, curve: Curves.easeInOut),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Mulai animasi ikon setelah 1 detik
    Future.delayed(const Duration(seconds: 1), () {
      _iconController.forward();
    });

    // Munculkan teks setelah animasi ikon selesai
    _iconController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showText = true;
        });
        _textController.forward();
      }
    });

    // Tampilkan splash selama 6 detik sebelum navigasi ke landing screen
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LandingScreen()),
      );
    });
  }

  @override
  void dispose() {
    _iconController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFADD8FF), // Biru muda
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SlideTransition(
                position: _iconOffset,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/book_icon.png'),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              if (_showText)
                FadeTransition(
                  opacity: _textController,
                  child: const Text(
                    'Litera',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DancingScript',
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
