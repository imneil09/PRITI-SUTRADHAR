import 'package:flutter/material.dart';
import 'dart:ui';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Content
          SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildCategories(context),
                const SizedBox(height: 20),
                _buildRecentActivity(),
                const SizedBox(height: 100), // Space for FAB
              ],
            ),
          ),
          
          // FAB Positioned
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/pickup_wizard'),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2937),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))
                    ]
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.local_shipping_outlined, color: Color(0xFF34D399)),
                      SizedBox(width: 12),
                      Text('Schedule Pickup', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 320,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF059669), Color(0xFF064E3B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.white70, size: 16),
                      SizedBox(width: 4),
                      Text('HSR Layout, BLR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.account_balance_wallet, color: Colors.white, size: 16),
                        SizedBox(width: 6),
                        Text('₹250', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              const Text('Hello, Aryan!', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900)),
              const Text("Let's clean up & earn cash.", style: TextStyle(color: Colors.white70, fontSize: 16)),
              const SizedBox(height: 30),
              
              // Glass Stats
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), border: Border.all(color: Colors.white24)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _StatItem(value: '14 kg', label: 'Recycled'),
                        _StatItem(value: '4', label: 'Pickups'),
                        _StatItem(value: '180', label: 'CO2 Saved'),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sell Scrap', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Best Rates', style: TextStyle(fontSize: 12, color: Color(0xFF059669), fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _CategoryCard(icon: Icons.water_drop, title: 'Plastic', price: '₹12/KG', color: Colors.orange, onTap: () => Navigator.pushNamed(context, '/pickup_wizard'))),
              const SizedBox(width: 16),
              Expanded(child: _CategoryCard(icon: Icons.checkroom, title: 'Clothes', price: '₹15/KG', color: Colors.purple, onTap: () => Navigator.pushNamed(context, '/pickup_wizard'))),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recent Pickups', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade100)),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.check, color: Colors.green),
                ),
                const SizedBox(width: 16),
                const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Plastic Mix', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Tue, 10 Oct', style: TextStyle(fontSize: 12, color: Colors.grey)),
                ]),
                const Spacer(),
                const Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text('+ ₹45', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                  Text('Success', style: TextStyle(fontSize: 10, color: Colors.grey)),
                ]),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value, label;
  const _StatItem({required this.value, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
      Text(label.toUpperCase(), style: const TextStyle(color: Colors.white70, fontSize: 10)),
    ]);
  }
}

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title, price;
  final MaterialColor color;
  final VoidCallback onTap;
  const _CategoryCard({required this.icon, required this.title, required this.price, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.shade50,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.shade100),
        ),
        child: Column(
          children: [
            CircleAvatar(backgroundColor: Colors.white, radius: 24, child: Icon(icon, color: color, size: 28)),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(price, style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}