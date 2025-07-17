// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:async';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _animationController.forward();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/DashboardPage');
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
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
            colors: [Color(0xFFE91E63), Color(0xFFAD1457)],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _animation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))],
                  ),
                  child: const Icon(Icons.pregnant_woman, size: 60, color: Color(0xFFE91E63)),
                ),
                const SizedBox(height: 30),
                // App Name
                const Text(
                  'Siaga Bumil',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.2),
                ),
                const SizedBox(height: 10),
                // Slogan
                const Text(
                  'Sistem Asupan Gizi & AI untuk Bumil',
                  style: TextStyle(fontSize: 16, color: Colors.white70, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                // Loading indicator
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
