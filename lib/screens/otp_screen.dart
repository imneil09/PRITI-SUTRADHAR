import 'package:flutter/material.dart';
import 'dart:ui'; // Required for BackdropFilter

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final role = ModalRoute.of(context)?.settings.arguments as String? ?? 'user';

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                color: const Color(0xFF10B981).withOpacity(0.15), // Emerald glow
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF34D399).withOpacity(0.1), // Light glow
              ),
            ),
          ),

          // 3. MAIN CONTENT
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Custom Back Button
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 600),
                    builder: (context, double val, child) {
                      return Opacity(
                        opacity: val.clamp(0.0, 1.0),
                        child: Transform.translate(offset: Offset(-20 * (1 - val), 0), child: child),
                      );
                    },
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Animated Header
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 800),
                    builder: (context, double val, child) {
                      return Opacity(
                        opacity: val.clamp(0.0, 1.0),
                        child: Transform.translate(offset: Offset(0, 20 * (1 - val)), child: child),
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
                            "VERIFICATION CODE",
                            style: TextStyle(color: Color(0xFF34D399), fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 1.2),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Verify OTP',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: -1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Enter the code sent to your mobile.",
                          style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 16),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                  // OTP Digit Boxes (Staggered Animation)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) => _AnimatedOtpBox(
                      index: index,
                      isFocused: index == 0, // Mock focus for the first one
                    )),
                  ),

                  const Spacer(),

                  // Action Button
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 1200),
                    curve: Curves.easeOutExpo,
                    builder: (context, double val, child) {
                      return Transform.scale(scale: val, child: Opacity(opacity: val.clamp(0.0, 1.0), child: child));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF10B981), Color(0xFF059669)], // Bright Emerald
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF10B981).withOpacity(0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        onPressed: () {
                          if (role == 'user') {
                            Navigator.pushNamedAndRemoveUntil(context, '/kyc', (route) => false);
                          } else {
                            Navigator.pushNamedAndRemoveUntil(context, '/partner_home', (route) => false);
                          }
                        },
                        child: const Text(
                          'Verify & Proceed',
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedOtpBox extends StatelessWidget {
  final int index;
  final bool isFocused;

  const _AnimatedOtpBox({required this.index, required this.isFocused});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 800 + (index * 100)), // Staggered delay
      curve: Curves.easeOutBack, // This curve goes above 1.0!
      builder: (context, double val, child) {
        return Transform.scale(
          scale: val,
          child: Opacity(
            // FIX: Clamp opacity to max 1.0 to prevent crash when curve overshoots
            opacity: val.clamp(0.0, 1.0), 
            child: child
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 64, 
            height: 64,
            decoration: BoxDecoration(
              color: isFocused ? Colors.white.withOpacity(0.15) : Colors.white.withOpacity(0.05),
              border: Border.all(
                color: isFocused ? const Color(0xFF34D399) : Colors.white.withOpacity(0.1), 
                width: isFocused ? 2 : 1
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: isFocused ? [
                BoxShadow(
                  color: const Color(0xFF34D399).withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                )
              ] : [],
            ),
            child: Center(
              child: Text(
                isFocused ? '5' : '', // Mock value
                style: const TextStyle(
                  fontSize: 28, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.white
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}