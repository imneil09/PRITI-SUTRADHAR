import 'package:flutter/material.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final role = ModalRoute.of(context)?.settings.arguments as String? ?? 'user';

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: const BackButton(color: Colors.black)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text('Verify OTP', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            const Text("Enter the code sent to your mobile.", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 40),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) => _otpDigitBox(index == 0)), // First one focused visually
            ),
            
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF059669),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 5,
                ),
                onPressed: () {
                  if (role == 'user') {
                    Navigator.pushNamedAndRemoveUntil(context, '/user_home', (route) => false);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(context, '/partner_home', (route) => false);
                  }
                },
                child: const Text('Verify & Proceed', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _otpDigitBox(bool isFocused) {
    return Container(
      width: 64, height: 64,
      decoration: BoxDecoration(
        color: isFocused ? const Color(0xFFECFDF5) : Colors.white,
        border: Border.all(color: isFocused ? const Color(0xFF10B981) : Colors.grey[300]!, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(isFocused ? '5' : '', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
    );
  }
}