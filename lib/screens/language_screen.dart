import 'package:flutter/material.dart';
import 'dart:ui'; // Required for BackdropFilter

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. DYNAMIC BACKGROUND
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF064E3B), Color(0xFF065F46), Color(0xFF042F2E)], // Deep Forest & Dark Teal
              ),
            ),
          ),

          // 2. ABSTRACT BLOBS (Decoration)
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF10B981).withOpacity(0.2), // Emerald glow
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF34D399).withOpacity(0.1), // Light glow
              ),
            ),
          ),

          // 3. MAIN CONTENT
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  
                  // Animated Header
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 800),
                    builder: (context, double val, child) {
                      return Opacity(
                        opacity: val,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - val)),
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF34D399)),
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFF064E3B).withOpacity(0.5),
                          ),
                          child: const Text(
                            "START YOUR JOURNEY",
                            style: TextStyle(
                              color: Color(0xFF34D399), 
                              fontWeight: FontWeight.bold, 
                              fontSize: 10, 
                              letterSpacing: 1.2
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Welcome!',
                          style: TextStyle(
                            fontSize: 42, 
                            fontWeight: FontWeight.w900, 
                            color: Colors.white, 
                            height: 1.1, 
                            letterSpacing: -1
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Choose your preferred language',
                          style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  
                  const Spacer(),

                  // Language Buttons with Staggered Animation
                  _AnimatedLangButton(
                    delay: 200, 
                    lang: 'English', 
                    onTap: () => Navigator.pushNamed(context, '/role')
                  ),
                  _AnimatedLangButton(
                    delay: 300, 
                    lang: 'हिंदी (Hindi)', 
                    onTap: () => Navigator.pushNamed(context, '/role')
                  ),
                  _AnimatedLangButton(
                    delay: 400, 
                    lang: 'বাংলা (Bengali)', 
                    onTap: () => Navigator.pushNamed(context, '/role')
                  ),

                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedLangButton extends StatelessWidget {
  final int delay;
  final String lang;
  final VoidCallback onTap;

  const _AnimatedLangButton({required this.delay, required this.lang, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 800 + delay),
      curve: Curves.easeOutExpo,
      builder: (context, double val, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - val)),
          child: Opacity(opacity: val, child: child),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        lang,
                        style: const TextStyle(
                          fontSize: 18, 
                          fontWeight: FontWeight.bold, 
                          color: Colors.white, 
                          letterSpacing: 0.5
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, 
                          color: Colors.white.withOpacity(0.1)
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded, 
                          color: Colors.white, 
                          size: 14
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}