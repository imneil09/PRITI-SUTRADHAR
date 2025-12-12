import 'package:flutter/material.dart';
import 'dart:ui'; // Required for BackdropFilter

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve role passed from arguments
    final role = ModalRoute.of(context)?.settings.arguments as String? ?? 'user';

    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents background squishing
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
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF10B981).withOpacity(0.15), // Emerald glow
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF34D399).withOpacity(0.08), // Light glow
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
                        opacity: val,
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
                        opacity: val,
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
                            "LOGIN SECURELY",
                            style: TextStyle(color: Color(0xFF34D399), fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 1.2),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Mobile Number',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: -1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "We'll send you a 4-digit OTP to verify.",
                          style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 16),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                  // Glassmorphic Input Field
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeOutExpo,
                    builder: (context, double val, child) {
                      return Transform.translate(offset: Offset(0, 50 * (1 - val)), child: Opacity(opacity: val, child: child));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withOpacity(0.2)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(right: 16),
                                decoration: BoxDecoration(
                                  border: Border(right: BorderSide(color: Colors.white.withOpacity(0.2))),
                                ),
                                child: const Text(
                                  '+91',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white70),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.phone,
                                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.5),
                                  cursorColor: const Color(0xFF34D399),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '70059 XXXXX',
                                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.2), letterSpacing: 1.5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Action Button
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 1200),
                    curve: Curves.easeOutExpo,
                    builder: (context, double val, child) {
                      return Transform.scale(scale: val, child: Opacity(opacity: val, child: child));
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
                        onPressed: () => Navigator.pushNamed(context, '/otp', arguments: role),
                        child: const Text(
                          'Send OTP',
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