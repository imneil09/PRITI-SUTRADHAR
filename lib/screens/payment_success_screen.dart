import 'package:flutter/material.dart';
import 'dart:ui'; // Required for BackdropFilter

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. GLOBAL BACKGROUND
          Container(
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
            top: -100, right: -100,
            child: Container(
              width: 300, height: 300,
              decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF10B981).withOpacity(0.15),),
            ),
          ),
          Positioned(
            bottom: 100, left: -50,
            child: Container(
              width: 250, height: 250,
              decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF34D399).withOpacity(0.1),),
            ),
          ),

          // 3. MAIN CONTENT
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  
                  // --- SUCCESS ICON WITH GLOW ---
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF34D399), Color(0xFF059669)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF34D399).withOpacity(0.4),
                          blurRadius: 30,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.check_rounded, size: 60, color: Colors.white),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // --- TEXT ---
                  const Text(
                    "Payment Sent!",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "₹66 added to user's wallet.",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  
                  const SizedBox(height: 40),

                  // --- DIGITAL RECEIPT (GLASS) ---
                  _GlassContainer(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        _buildReceiptRow("Transaction ID", "#TRX9982", isMono: true),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Divider(color: Colors.white12),
                        ),
                        _buildReceiptRow("Total Paid", "₹66.00", isLarge: true),
                        const SizedBox(height: 12),
                        _buildReceiptRow("Total Weight", "5.5 KG"),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // --- ACTION BUTTON ---
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF064E3B),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 10,
                      ),
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/partner_home', (route) => false),
                      child: const Text(
                        "Back to Dashboard",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value, {bool isMono = false, bool isLarge = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white60,
            fontSize: isLarge ? 16 : 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isLarge ? const Color(0xFF34D399) : Colors.white,
            fontSize: isLarge ? 24 : 14,
            fontWeight: isLarge ? FontWeight.w900 : FontWeight.bold,
            fontFamily: isMono ? 'Monospace' : null,
          ),
        ),
      ],
    );
  }
}

// ================== HELPER WIDGETS ==================

class _GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const _GlassContainer({required this.child, required this.padding});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(24),
          ),
          child: child,
        ),
      ),
    );
  }
}