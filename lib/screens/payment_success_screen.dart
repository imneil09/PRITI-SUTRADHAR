import 'package:flutter/material.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF059669),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(padding: const EdgeInsets.all(20), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: const Icon(Icons.check, size: 40, color: Color(0xFF059669))),
              const SizedBox(height: 24),
              const Text("Payment Sent!", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white)),
              const Text("₹66 added to user's wallet.", style: TextStyle(color: Colors.white70, fontSize: 16)),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.white24)),
                child: const Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text("Transaction ID", style: TextStyle(color: Colors.white70)),
                    Text("#TRX9982", style: TextStyle(color: Colors.white, fontFamily: 'Monospace')),
                  ]),
                  SizedBox(height: 16),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text("Weight", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                    Text("5.5 KG", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                  ]),
                ]),
              ),
              const Spacer(),
              SizedBox(width: double.infinity, height: 56, child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/partner_home', (route) => false),
                child: const Text("Back to Dashboard", style: TextStyle(color: Color(0xFF059669), fontSize: 16, fontWeight: FontWeight.bold)),
              )),
            ],
          ),
        ),
      ),
    );
  }
}