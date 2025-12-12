import 'package:flutter/material.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome!', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const Text('Choose your preferred language', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 40),
            _buildLangButton(context, 'English'),
            _buildLangButton(context, 'हिंदी (Hindi)'),
            _buildLangButton(context, 'বাংলা (Bengali)'),
          ],
        ),
      ),
    );
  }

  Widget _buildLangButton(BuildContext context, String lang) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/role'),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10)],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(lang, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}