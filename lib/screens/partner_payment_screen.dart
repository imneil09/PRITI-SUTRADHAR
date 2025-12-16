import 'package:flutter/material.dart';
import 'dart:ui'; // Required for BackdropFilter

class PartnerPaymentScreen extends StatelessWidget {
  const PartnerPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
            top: -50, right: -50,
            child: Container(
              width: 250, height: 250,
              decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF10B981).withOpacity(0.15),),
            ),
          ),
          Positioned(
            bottom: 100, left: -50,
            child: Container(
              width: 200, height: 200,
              decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF34D399).withOpacity(0.1),),
            ),
          ),

          // 3. MAIN CONTENT
          SafeArea(
            child: Column(
              children: [
                // --- HEADER ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      _GlassBackButton(onTap: () => Navigator.pop(context)),
                      const Expanded(
                        child: Text(
                          "Complete Pickup",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                        ),
                      ),
                      const SizedBox(width: 40), // Balance
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        // --- WARNING CARD ---
                        _GlassContainer(
                          padding: const EdgeInsets.all(16),
                          color: Colors.orange.withOpacity(0.1),
                          borderColor: Colors.orange.withOpacity(0.3),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(color: Colors.orange.withOpacity(0.2), shape: BoxShape.circle),
                                child: const Icon(Icons.warning_amber_rounded, color: Colors.orangeAccent),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Text(
                                  "Verify actual weight using digital scale.",
                                  style: TextStyle(color: Colors.orangeAccent, fontSize: 13, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),

                        // --- DIGITAL READOUTS ---
                        _buildDigitalDisplay("Final Weight", "5.5", "KG", Icons.monitor_weight),
                        const SizedBox(height: 20),
                        _buildDigitalDisplay("Amount to Pay", "66", "₹", Icons.currency_rupee, isMoney: true),
                        
                        const SizedBox(height: 12),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text("Rate applied: ₹12/kg", style: TextStyle(color: Colors.white54, fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                ),

                // --- BOTTOM PAYMENT SHEET ---
                _buildBottomPaymentSheet(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDigitalDisplay(String label, String value, String unit, IconData icon, {bool isMoney = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white54, letterSpacing: 1)),
        const SizedBox(height: 8),
        _GlassContainer(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isMoney ? const Color(0xFF34D399).withOpacity(0.15) : Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: isMoney ? const Color(0xFF34D399) : Colors.white70, size: 28),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        color: isMoney ? const Color(0xFF34D399) : Colors.white,
                        height: 1.0,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      unit,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isMoney ? const Color(0xFF34D399).withOpacity(0.8) : Colors.white38,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomPaymentSheet(BuildContext context) {
    return _GlassContainer(
      padding: const EdgeInsets.all(24),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      color: const Color(0xFF064E3B).withOpacity(0.6),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _PaymentOptionButton(label: "Cash", icon: Icons.money, isSelected: false)),
              const SizedBox(width: 16),
              Expanded(child: _PaymentOptionButton(label: "Wallet", icon: Icons.account_balance_wallet, isSelected: true)),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF34D399),
                foregroundColor: const Color(0xFF064E3B),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 10,
                shadowColor: const Color(0xFF34D399).withOpacity(0.4),
              ),
              onPressed: () => Navigator.pushNamed(context, '/payment_success'),
              child: const Text("Confirm Payment", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

// ================== HELPER WIDGETS ==================

class _PaymentOptionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  const _PaymentOptionButton({required this.label, required this.icon, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF34D399).withOpacity(0.15) : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? const Color(0xFF34D399) : Colors.white24,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: isSelected ? const Color(0xFF34D399) : Colors.white60),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? const Color(0xFF34D399) : Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color? color;
  final Color? borderColor;
  final BorderRadius? borderRadius;

  const _GlassContainer({
    required this.child,
    required this.padding,
    this.color,
    this.borderColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: color ?? Colors.white.withOpacity(0.08),
            border: Border.all(color: borderColor ?? Colors.white.withOpacity(0.1)),
            borderRadius: borderRadius ?? BorderRadius.circular(24),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _GlassBackButton extends StatelessWidget {
  final VoidCallback onTap;
  const _GlassBackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white12),
        ),
        child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
      ),
    );
  }
}