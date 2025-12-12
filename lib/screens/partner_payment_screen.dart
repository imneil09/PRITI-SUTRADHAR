import 'package:flutter/material.dart';

class PartnerPaymentScreen extends StatelessWidget {
  const PartnerPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Complete Pickup"), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
                    child: Row(children: [
                      Icon(Icons.warning_amber_rounded, color: Colors.orange.shade800),
                      const SizedBox(width: 12),
                      Expanded(child: Text("Verify actual weight using digital scale.", style: TextStyle(color: Colors.orange.shade900, fontSize: 13, fontWeight: FontWeight.bold))),
                    ]),
                  ),
                  const SizedBox(height: 30),
                  _buildInput("Final Weight (KG)", "5.5", Icons.monitor_weight),
                  const SizedBox(height: 20),
                  _buildInput("Amount to Pay (₹)", "66", Icons.currency_rupee, color: Colors.green),
                  const SizedBox(height: 10),
                  const Align(alignment: Alignment.centerRight, child: Text("Rate applied: ₹12/kg", style: TextStyle(color: Colors.grey, fontSize: 12))),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            color: Colors.grey[50],
            child: Column(
              children: [
                Row(children: [
                  Expanded(child: OutlinedButton(onPressed: (){}, style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)), child: const Text("Cash"))),
                  const SizedBox(width: 16),
                  Expanded(child: OutlinedButton(onPressed: (){}, style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), backgroundColor: const Color(0xFFECFDF5), side: const BorderSide(color: Color(0xFF10B981))), child: const Text("Online Wallet", style: TextStyle(color: Color(0xFF047857), fontWeight: FontWeight.bold)))),
                ]),
                const SizedBox(height: 16),
                SizedBox(width: double.infinity, height: 56, child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF059669), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                  onPressed: () => Navigator.pushNamed(context, '/payment_success'),
                  child: const Text("Confirm Payment", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInput(String label, String val, IconData icon, {Color? color}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
      const SizedBox(height: 8),
      Row(children: [
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: Colors.grey)),
        const SizedBox(width: 16),
        Expanded(child: Text(val, style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: color ?? Colors.black))),
      ]),
      const Divider(),
    ]);
  }
}