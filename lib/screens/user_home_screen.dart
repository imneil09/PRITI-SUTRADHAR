import 'package:flutter/material.dart';
import 'dart:ui'; // Required for BackdropFilter

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const _HomeTab(),
    const _WalletTab(),
    const _ProfileTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // 1. GLOBAL BACKGROUND (Header Background)
          Container(
            height: MediaQuery.of(context).size.height * 0.45, // Covers top part
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF064E3B),
                  Color(0xFF065F46),
                  Color(0xFF022C22),
                ],
              ),
            ),
          ),

          // 2. ABSTRACT BLOBS
          Positioned(
            top: -100, right: -100,
            child: Container(
              width: 300, height: 300,
              decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF10B981).withOpacity(0.15)),
            ),
          ),
          Positioned(
            top: 50, left: -50,
            child: Container(
              width: 150, height: 150,
              decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF34D399).withOpacity(0.1)),
            ),
          ),

          // 3. MAIN CONTENT
          IndexedStack(index: _selectedIndex, children: _widgetOptions),
        ],
      ),

      // 4. FLOATING ACTION BUTTON
      floatingActionButton: _selectedIndex == 0
          ? Padding(
              padding: const EdgeInsets.only(bottom: 70.0, left: 10),
              child: FloatingActionButton(
                onPressed: () => Navigator.pushNamed(context, '/pickup_wizard'),
                backgroundColor: const Color(0xFF34D399),
                foregroundColor: const Color(0xFF064E3B),
                elevation: 10,
                shape: const CircleBorder(),
                child: const Icon(Icons.add, size: 28),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

      // 5. NAV BAR
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -5)),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_outlined),
                  activeIcon: Icon(Icons.dashboard),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet_outlined),
                  activeIcon: Icon(Icons.account_balance_wallet),
                  label: 'Wallet',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: const Color(0xFF064E3B), // Dark Green for active
              unselectedItemColor: Colors.grey, // Grey for inactive
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white, // White Nav Bar
              elevation: 0,
              showUnselectedLabels: true,
              selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              unselectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

// ================== TAB 1: HOME ==================
class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // --- GREEN HEADER SECTION ---
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _GlassTag(icon: Icons.location_on, text: 'Assam University, Silchar, Assam'),
                    const _LogoutButton(),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Hello, Priti!', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900)),
                const Text("Let's Clean & Earn 👇", style: TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 20),
                
                // Stats Bar (Keep Glass on Green)
                _GlassContainer(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatItem(value: '14 kg', label: 'Recycled', icon: Icons.recycling),
                      _VerticalDivider(),
                      _StatItem(value: '₹250', label: 'Earned', icon: Icons.currency_rupee),
                      _VerticalDivider(),
                      _StatItem(value: '180', label: 'Saved', icon: Icons.co2),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // --- WHITE BODY SECTION ---
        Expanded(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            // CHANGED: Made the column scrollable
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // Live Pickup
                  const _LivePickupCardLight(),
                  const SizedBox(height: 25),

                  // Market Rates Header
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Market Rates', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF064E3B))),
                      Text('● LIVE', style: TextStyle(fontSize: 10, color: Color(0xFF34D399), fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Grid (Updated to wrap content)
                  _buildPriceGrid(context),

                  const SizedBox(height: 20),

                  // --- RECENT ACTIVITY ---
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Recent Activity',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF064E3B),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Single Transaction Tile
                  const _TransactionTileLight(
                    title: 'Sold Plastic',
                    date: 'Tue, 10 Oct',
                    amount: '+ ₹45',
                    isCredit: true,
                  ),
                  
                  // Extra padding at bottom to ensure content isn't hidden behind FAB/NavBar
                  const SizedBox(height: 100), 
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceGrid(BuildContext context) {
    final List<Map<String, dynamic>> rates = [
      {'icon': Icons.newspaper, 'name': 'Paper', 'price': '₹10/kg'},
      {'icon': Icons.water_drop, 'name': 'Plastic', 'price': '₹12/kg'},
      {'icon': Icons.settings, 'name': 'Iron', 'price': '₹26/kg'},
      {'icon': Icons.checkroom, 'name': 'Clothes', 'price': '₹15/kg'},
      {'icon': Icons.computer, 'name': 'E-Waste', 'price': '₹40/kg'},
      {'icon': Icons.wine_bar, 'name': 'Glass', 'price': '₹2/kg'},
    ];

    return GridView.builder(
      // CHANGED: ShrinkWrap and Physics to work inside SingleChildScrollView
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, childAspectRatio: 0.9, crossAxisSpacing: 15, mainAxisSpacing: 15,
      ),
      itemCount: rates.length,
      itemBuilder: (context, index) {
        return _RateCardLight(
          icon: rates[index]['icon'],
          name: rates[index]['name'],
          price: rates[index]['price'],
          onTap: () => Navigator.pushNamed(context, '/pickup_wizard'),
        );
      },
    );
  }
}

// ================== TAB 2: WALLET ==================
class _WalletTab extends StatelessWidget {
  const _WalletTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 40),
                    Text('Wallet', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    _LogoutButton(),
                  ],
                ),
                const SizedBox(height: 30),
                const Text('Total Balance', style: TextStyle(color: Colors.white60, fontSize: 16)),
                const Text('₹265.00', style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.w900)),
                const SizedBox(height: 20),
                _GlassTag(icon: Icons.trending_up, text: '+ ₹45 this week'),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
        
        // --- WHITE SHEET ---
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 30, 24, 0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ActionButtonLight(icon: Icons.add, label: 'Add Bank', onTap: () {}),
                    _ActionButtonLight(icon: Icons.qr_code_scanner, label: 'Scan', onTap: () {}),
                    _ActionButtonLight(icon: Icons.arrow_downward, label: 'Withdraw', onTap: () {}),
                  ],
                ),
                const SizedBox(height: 30),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Recent Transactions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF064E3B))),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 100),
                    children: const [
                       _TransactionTileLight(title: 'Sold Clothes', date: 'Sat, 07 Oct', amount: '+ ₹45', isCredit: true),
                       _TransactionTileLight(title: 'Sold Clothes', date: 'Sat, 07 Oct', amount: '+ ₹220', isCredit: true),
                       _TransactionTileLight(title: 'Withdrawal', date: 'Fri, 01 Oct', amount: '- ₹500', isCredit: false),
                       _TransactionTileLight(title: 'Sold Iron', date: 'Thu, 30 Sep', amount: '+ ₹500', isCredit: true),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ================== TAB 3: PROFILE ==================
class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Align(alignment: Alignment.centerRight, child: _LogoutButton()),
                const CircleAvatar(radius: 45, backgroundImage: AssetImage('assets/priti.jpeg')),
                const SizedBox(height: 12),
                const Text('Priti Sutradhar', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                const Text('+91 70059 48459', style: TextStyle(color: Colors.white60)),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),

        // --- WHITE SHEET ---
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                _buildProfileOptionLight(Icons.location_on_outlined, 'Addresses'),
                _buildProfileOptionLight(Icons.history, 'Order History'),
                _buildProfileOptionLight(Icons.account_balance_wallet_outlined, 'Payment Report'),
                _buildProfileOptionLight(Icons.notifications_outlined, 'Notifications'),
                _buildProfileOptionLight(Icons.help_outline, 'Help & Support'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileOptionLight(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF064E3B), size: 22),
          const SizedBox(width: 16),
          Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF064E3B), fontSize: 16))),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}

// ================== NEW HELPER WIDGETS (LIGHT THEME) ==================

class _RateCardLight extends StatelessWidget {
  final IconData icon;
  final String name, price;
  final VoidCallback onTap;

  const _RateCardLight({required this.icon, required this.name, required this.price, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[100]!),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFF064E3B).withOpacity(0.1),
              child: Icon(icon, color: const Color(0xFF064E3B), size: 20),
            ),
            const SizedBox(height: 8),
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 4),
            Text(price, style: const TextStyle(color: Color(0xFF064E3B), fontWeight: FontWeight.w900, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

class _LivePickupCardLight extends StatelessWidget {
  const _LivePickupCardLight();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF34D399).withOpacity(0.1), // Light green tint
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF34D399).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: const Icon(Icons.local_shipping, color: Color(0xFF064E3B), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Pickup #TRX9982", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF064E3B), fontSize: 16)),
                    Text("In Progress", style: TextStyle(fontSize: 10, color: Color(0xFF064E3B), fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: 0.6,
                  backgroundColor: Colors.white,
                  color: const Color(0xFF064E3B),
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(3),
                ),
                const SizedBox(height: 6),
                const Text("Partner will arrive tomorrow", style: TextStyle(color: Colors.black54, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionTileLight extends StatelessWidget {
  final String title, date, amount;
  final bool isCredit;
  const _TransactionTileLight({required this.title, required this.date, required this.amount, required this.isCredit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isCredit ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(isCredit ? Icons.arrow_downward : Icons.arrow_upward, color: isCredit ? Colors.green : Colors.red, size: 18),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF064E3B), fontSize: 14)),
                Text(date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Text(amount, style: TextStyle(fontWeight: FontWeight.bold, color: isCredit ? Colors.green : Colors.red, fontSize: 14)),
        ],
      ),
    );
  }
}

class _ActionButtonLight extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ActionButtonLight({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 56, height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFF064E3B).withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF064E3B), size: 24),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54)),
      ],
    );
  }
}

// ================== EXISTING HELPERS (KEPT FOR HEADERS) ==================

class _GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const _GlassContainer({required this.child, required this.padding});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _GlassTag extends StatelessWidget {
  final IconData icon;
  final String text;
  const _GlassTag({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF34D399).withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF34D399).withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF34D399), size: 14),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(color: Color(0xFF34D399), fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/role', (route) => false),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white12),
        ),
        child: const Icon(Icons.logout, color: Colors.white, size: 18),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value, label;
  final IconData icon;
  const _StatItem({required this.value, required this.label, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF34D399), size: 18),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
        Text(label.toUpperCase(), style: const TextStyle(color: Colors.white54, fontSize: 8, letterSpacing: 1)),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 20, color: Colors.white24);
  }
}