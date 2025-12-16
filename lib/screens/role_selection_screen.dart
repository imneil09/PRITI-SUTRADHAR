import 'package:flutter/material.dart';
import 'dart:ui'; 

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

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
                colors: [Color(0xFF064E3B), Color(0xFF065F46), Color(0xFF042F2E)],
              ),
            ),
          ),

          // 2. ABSTRACT BLOBS
          Positioned(
            top: -100, right: -100,
            child: Container(
              width: 300, height: 300,
              decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF10B981).withOpacity(0.2)),
            ),
          ),
          Positioned(
            bottom: -50, left: -50,
            child: Container(
              width: 250, height: 250,
              decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF34D399).withOpacity(0.1)),
            ),
          ),

          // 3. MAIN CONTENT
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF34D399)),
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF064E3B).withOpacity(0.5),
                    ),
                    child: const Text("WELCOME TO TRASHKARI", style: TextStyle(color: Color(0xFF34D399), fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 1.2)),
                  ),
                  const SizedBox(height: 16),
                  const Text("Let's Change\nThe World.", style: TextStyle(fontSize: 42, fontWeight: FontWeight.w900, color: Colors.white, height: 1.1, letterSpacing: -1)),
                  const SizedBox(height: 10),
                  Text("Identify yourself to get started.", style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 16)),

                  const Spacer(),

                  // HOUSEHOLD -> Goes to Login
                  _AnimatedRoleCard(
                    delay: 200,
                    title: "Household",
                    subtitle: "I have waste to sell.",
                    icon: Icons.home_filled,
                    gradientColors: const [Color(0xFF10B981), Color(0xFF059669)],
                    onTap: () => Navigator.pushNamed(context, '/login', arguments: 'user'),
                  ),
                  const SizedBox(height: 20),
                  
                  // RECYCLER -> Goes to Register Screen
                  _AnimatedRoleCard(
                    delay: 400,
                    title: "Recycler",
                    subtitle: "I collect & process waste.",
                    icon: Icons.local_shipping,
                    gradientColors: const [Color(0xFF3B82F6), Color(0xFF2563EB)],
                    onTap: () => Navigator.pushNamed(context, '/partner_register'), // ✅ CHANGED THIS
                  ),

                  const Spacer(),
                  Center(child: Text("Clean India, Earn India", style: TextStyle(color: Colors.white.withOpacity(0.3), fontWeight: FontWeight.bold, letterSpacing: 2))),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedRoleCard extends StatelessWidget {
  final int delay;
  final String title, subtitle;
  final IconData icon;
  final List<Color> gradientColors;
  final VoidCallback onTap;

  const _AnimatedRoleCard({required this.delay, required this.title, required this.subtitle, required this.icon, required this.gradientColors, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 800 + delay),
      curve: Curves.easeOutExpo,
      builder: (context, double val, child) {
        return Transform.translate(offset: Offset(0, 50 * (1 - val)), child: Opacity(opacity: val, child: child));
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 130, padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.white.withOpacity(0.1))),
                child: Row(
                  children: [
                    Container(
                      width: 60, height: 60,
                      decoration: BoxDecoration(gradient: LinearGradient(colors: gradientColors, begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: gradientColors.first.withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 8))]),
                      child: Icon(icon, color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 20),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 0.5)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.6))),
                    ])),
                    Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.1)), child: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 14)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}