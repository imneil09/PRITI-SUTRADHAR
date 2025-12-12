import 'package:flutter/material.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECFDF5), // Light Emerald bg
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Who are you?', 
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF1F2937))),
            const SizedBox(height: 40),
            
            // User Card
            _buildRoleCard(
              context,
              title: 'Household',
              subtitle: 'I want to sell waste',
              icon: Icons.person,
              color: const Color(0xFF059669),
              bgColor: const Color(0xFFD1FAE5),
              onTap: () => Navigator.pushNamed(context, '/login', arguments: 'user'),
            ),
            const SizedBox(height: 20),
            
            // Partner Card
            _buildRoleCard(
              context,
              title: 'Recycler',
              subtitle: 'I want to collect waste',
              icon: Icons.local_shipping,
              color: const Color(0xFF2563EB), // Blue
              bgColor: const Color(0xFFDBEAFE),
              onTap: () => Navigator.pushNamed(context, '/login', arguments: 'partner'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard(BuildContext context, {required String title, required String subtitle, required IconData icon, required Color color, required Color bgColor, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [BoxShadow(color: color.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 5))],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                width: 70, height: 70,
                decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(18)),
                child: Icon(icon, color: color, size: 32),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(subtitle, style: TextStyle(color: Colors.grey[500], fontSize: 13)),
              ],
            )
          ],
        ),
      ),
    );
  }
}