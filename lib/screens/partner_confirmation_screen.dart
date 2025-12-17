import 'package:flutter/material.dart';

class PartnerConfirmationScreen extends StatelessWidget {
  const PartnerConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 1. GLOBAL BACKGROUND (Header Background)
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF064E3B), Color(0xFF065F46), Color(0xFF022C22)],
              ),
            ),
          ),

          // 2. ABSTRACT BLOBS
          Positioned(
            top: -50, right: -50,
            child: Container(
              width: 250, height: 250,
              decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF10B981).withOpacity(0.15)),
            ),
          ),

          // 3. MAIN CONTENT
          Column(
            children: [
              // --- HEADER SECTION ---
              SafeArea(
                bottom: false,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white24),
                        ),
                        child: const Icon(Icons.mark_email_read_outlined, size: 50, color: Color(0xFF34D399)),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Request Submitted",
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white),
                      ),
                      const Text(
                        "Verification Pending",
                        style: TextStyle(fontSize: 14, color: Colors.white70, letterSpacing: 1),
                      ),
                    ],
                  ),
                ),
              ),

              // --- WHITE BODY SECTION ---
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        
                        // INFO CARD
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.blueGrey[100]!),
                          ),
                          child: const Column(
                            children: [
                              Text(
                                "We will send you a confirmation on your registered phone number.",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
                              ),
                              SizedBox(height: 10),
                              Divider(),
                              SizedBox(height: 10),
                              Text(
                                "Our team reviews partner applications within 24-48 hours.",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 13, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),

                        const Spacer(),

                        const Text(
                          "If you already got the confirmation message:",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        const SizedBox(height: 10),

                        // LOGIN BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF064E3B), // Deep Green
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              elevation: 10,
                              shadowColor: const Color(0xFF064E3B).withOpacity(0.4),
                            ),
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false, arguments: 'partner');
                            },
                            child: const Text("Login Now", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}