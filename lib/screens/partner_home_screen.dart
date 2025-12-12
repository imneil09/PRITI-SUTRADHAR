import 'package:flutter/material.dart';

class PartnerHomeScreen extends StatefulWidget {
  const PartnerHomeScreen({super.key});

  @override
  State<PartnerHomeScreen> createState() => _PartnerHomeScreenState();
}

class _PartnerHomeScreenState extends State<PartnerHomeScreen> {
  bool isNewRequests = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text("Partner Mode", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
                    Row(children: [
                      Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                      const SizedBox(width: 6),
                      const Text("ONLINE", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green)),
                    ])
                  ]),
                  IconButton(onPressed: () => Navigator.pushReplacementNamed(context, '/'), icon: const Icon(Icons.logout, color: Colors.red))
                ],
              ),
            ),
            
            // Stats
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(children: [
                _statCard("₹850", "Today's Pay", true),
                const SizedBox(width: 12),
                _statCard("45kg", "Collected", false),
                const SizedBox(width: 12),
                _statCard("3", "Pending", false),
              ]),
            ),
            const SizedBox(height: 24),

            // Tabs
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
              child: Row(children: [
                Expanded(child: _tabBtn("New Requests", isNewRequests, () => setState(() => isNewRequests = true))),
                Expanded(child: _tabBtn("My Pickups", !isNewRequests, () => setState(() => isNewRequests = false))),
              ]),
            ),
            const SizedBox(height: 20),

            // List
            Expanded(
              child: isNewRequests ? _buildNewRequestsList() : _buildActivePickup(),
            )
          ],
        ),
      ),
    );
  }

  Widget _tabBtn(String text, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: active ? Colors.white : Colors.transparent, borderRadius: BorderRadius.circular(10), boxShadow: active ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)] : []),
        child: Center(child: Text(text, style: TextStyle(fontWeight: FontWeight.bold, color: active ? Colors.black : Colors.grey))),
      ),
    );
  }

  Widget _statCard(String val, String label, bool dark) {
    return Container(
      padding: const EdgeInsets.all(16),
      constraints: const BoxConstraints(minWidth: 100),
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF1F2937) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100)
      ),
      child: Column(children: [
        Text(val, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: dark ? Colors.white : Colors.black)),
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
      ]),
    );
  }

  Widget _buildNewRequestsList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        _requestCard("Plastic Waste", "5.0 kg", "2.5 km • Sector 4", Colors.orange),
        _requestCard("Old Clothes", "12.0 kg", "1.2 km • Green Park", Colors.purple),
      ],
    );
  }

  Widget _requestCard(String title, String weight, String loc, MaterialColor color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 15)]),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(12)), child: Icon(Icons.recycling, color: color)),
              const SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(loc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ])
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(weight, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
              const Text("EST.", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
            ])
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: OutlinedButton(onPressed: () {}, child: const Text("Reject", style: TextStyle(color: Colors.grey)))),
            const SizedBox(width: 12),
            Expanded(flex: 2, child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1F2937), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              onPressed: () => setState(() => isNewRequests = false),
              child: const Text("Accept Pickup", style: TextStyle(color: Colors.white))
            )),
          ])
        ],
      ),
    );
  }

  Widget _buildActivePickup() {
    return ListView(padding: const EdgeInsets.symmetric(horizontal: 24), children: [
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: const Color(0xFF10B981), width: 2), boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.1), blurRadius: 20)]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: const BoxDecoration(color: Color(0xFF10B981), borderRadius: BorderRadius.only(bottomRight: Radius.circular(8))), child: const Text("IN PROGRESS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10))),
          const SizedBox(height: 10),
          const Text("Plastic Waste", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Text("User: Amit K.", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12)), child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Address"), Text("Sector 4, Main Rd", style: TextStyle(fontWeight: FontWeight.bold))])),
          const SizedBox(height: 20),
          SizedBox(width: double.infinity, height: 50, child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF059669), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            onPressed: () => Navigator.pushNamed(context, '/partner_payment'),
            icon: const Icon(Icons.scale, color: Colors.white),
            label: const Text("Weigh & Pay", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ))
        ]),
      )
    ]);
  }
}