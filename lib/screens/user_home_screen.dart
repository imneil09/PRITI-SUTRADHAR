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
      extendBody: true, // Important for glass effect behind nav bar
      body: Stack(
        children: [
          // 1. GLOBAL BACKGROUND (Deep Forest Theme)
          Container(
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

          // 2. ABSTRACT BLOBS (Subtle Glow)
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF10B981).withOpacity(0.15),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF34D399).withOpacity(0.1),
              ),
            ),
          ),

          // 3. MAIN CONTENT
          IndexedStack(index: _selectedIndex, children: _widgetOptions),
        ],
      ),

      // 4. FLOATING ACTION BUTTON (Small, Left Corner)
      floatingActionButton:
          _selectedIndex == 0
              ? Padding(
                padding: const EdgeInsets.only(bottom: 70.0, left: 10),
                child: FloatingActionButton(
                  onPressed:
                      () => Navigator.pushNamed(context, '/pickup_wizard'),
                  backgroundColor: const Color(0xFF34D399),
                  foregroundColor: const Color(0xFF064E3B),
                  elevation: 10,
                  shape: const CircleBorder(),
                  child: const Icon(Icons.add, size: 28),
                ),
              )
              : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

      bottomNavigationBar: ClipRRect(
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
            selectedItemColor: const Color(0xFF34D399),
            unselectedItemColor: Colors.white38,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color(0xFF064E3B).withOpacity(0.85),
            elevation: 0,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// ================== TAB 1: HOME (FIXED LAYOUT) ==================
class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 90),
        child: Column(
          children: [
            // --- HEADER ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _GlassTag(
                  icon: Icons.location_on,
                  text: 'Assam University, Silchar, Assam',
                ),
                const _LogoutButton(),
              ],
            ),

            const SizedBox(height: 15),

            // Name & Greeting
            const SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, Priti!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    "Let's Clean & Earn 👇",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // --- STATS BAR ---
            _GlassContainer(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatItem(
                    value: '14 kg',
                    label: 'Recycled',
                    icon: Icons.recycling,
                  ),
                  _VerticalDivider(),
                  _StatItem(
                    value: '₹250',
                    label: 'Earned',
                    icon: Icons.currency_rupee,
                  ),
                  _VerticalDivider(),
                  _StatItem(value: '180', label: 'Saved', icon: Icons.co2),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // --- LIVE PICKUP STATUS ---
            const _LivePickupCard(),

            const SizedBox(height: 15),

            // --- MARKET RATES HEADER ---
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Market Rates',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '● LIVE',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF34D399),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // --- MARKET RATES GRID (Scrollable) ---
            Expanded(flex: 4, child: _buildPriceGrid(context)),

            const SizedBox(height: 15),

            // --- RECENT ACTIVITY ---
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),

            const Expanded(
              flex: 1,
              child: _GlassTransactionTile(
                title: 'Sold Plastic',
                date: 'Tue, 10 Oct',
                amount: '+ ₹45',
                isCredit: true,
              ),
            ),
          ],
        ),
      ),
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
      // Added extra items to demonstrate scrolling
      {
        'icon': Icons.battery_charging_full,
        'name': 'Batteries',
        'price': '₹50/kg',
      },
      {'icon': Icons.book, 'name': 'Books', 'price': '₹8/kg'},
      {'icon': Icons.car_repair, 'name': 'Tyres', 'price': '₹5/kg'},
    ];

    return GridView.builder(
      // ✅ CHANGED: Enabled BouncingScrollPhysics to allow scrolling
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero, // Remove top padding to align perfectly
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: rates.length,
      itemBuilder: (context, index) {
        return _GlassRateCard(
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 40),
                Text(
                  'Wallet',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _LogoutButton(),
              ],
            ),
            const Spacer(flex: 1),
            const Text(
              'Total Balance',
              style: TextStyle(color: Colors.white60, fontSize: 16),
            ),
            const Text(
              '₹265.00',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 20),
            _GlassTag(icon: Icons.trending_up, text: '+ ₹45 this week'),

            const Spacer(flex: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _GlassActionButton(
                  icon: Icons.add,
                  label: 'Add Bank',
                  onTap: () {},
                ),
                _GlassActionButton(
                  icon: Icons.qr_code_scanner,
                  label: 'Scan',
                  onTap: () {},
                ),
                _GlassActionButton(
                  icon: Icons.arrow_downward,
                  label: 'Withdraw',
                  onTap: () {},
                ),
              ],
            ),
            const Spacer(flex: 1),

            // Transactions Area
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Transactions',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  _GlassTransactionTile(
                    title: 'Sold Clothes',
                    date: 'Sat, 07 Oct',
                    amount: '+ ₹45',
                    isCredit: true,
                  ),
                  SizedBox(height: 10),
                  _GlassTransactionTile(
                    title: 'Sold Clothes',
                    date: 'Sat, 06 Oct',
                    amount: '+ ₹100',
                    isCredit: true,
                  ),
                  SizedBox(height: 10),
                  _GlassTransactionTile(
                    title: 'Sold Clothes',
                    date: 'Sat, 05 Oct',
                    amount: '+ ₹120',
                    isCredit: true,
                  ),
                  SizedBox(height: 10),
                  _GlassTransactionTile(
                    title: 'Withdrawal',
                    date: 'Fri, 01 Oct',
                    amount: '- ₹500',
                    isCredit: false,
                  ),
                  SizedBox(height: 10),
                  _GlassTransactionTile(
                    title: 'Sold Clothes',
                    date: 'Fri, 01 Oct',
                    amount: '- ₹500',
                    isCredit: true,
                  ),
                ],
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

// ================== TAB 3: PROFILE ==================
class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerRight,
              child: _LogoutButton(),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF34D399), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF34D399).withOpacity(0.3),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage('assets/priti.jpeg'),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Priti Sutradhar',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Text(
              '+91 70059 48459',
              style: TextStyle(color: Colors.white60),
            ),

            const SizedBox(height: 30),

            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildGlassProfileOption(
                    Icons.location_on_outlined,
                    'Addresses',
                  ),
                  _buildGlassProfileOption(Icons.history, 'Order History'),
                  _buildGlassProfileOption(
                    Icons.account_balance_wallet_outlined,
                    'Payment Report',
                  ),
                  _buildGlassProfileOption(
                    Icons.notifications_outlined,
                    'Notifications',
                  ),
                  _buildGlassProfileOption(
                    Icons.help_outline,
                    'Help & Support',
                  ),
                  _buildGlassProfileOption(Icons.info_outline, 'About Us'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassProfileOption(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: _GlassContainer(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF34D399), size: 20),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white38, size: 20),
          ],
        ),
      ),
    );
  }
}

// ================== HELPER WIDGETS ==================

class _LivePickupCard extends StatelessWidget {
  const _LivePickupCard();

  @override
  Widget build(BuildContext context) {
    return _GlassContainer(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Icon Box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF34D399).withOpacity(0.15),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF34D399).withOpacity(0.3),
              ),
            ),
            child: const Icon(
              Icons.local_shipping,
              color: Color(0xFF34D399),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pickup #8492",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "In Progress",
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF34D399),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: 0.6,
                  backgroundColor: Colors.white12,
                  color: const Color(0xFF34D399),
                  minHeight: 4,
                  borderRadius: BorderRadius.circular(2),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Partner is arriving in 15 mins",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
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
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF34D399),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassRateCard extends StatelessWidget {
  final IconData icon;
  final String name, price;
  final VoidCallback onTap;

  const _GlassRateCard({
    required this.icon,
    required this.name,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: _GlassContainer(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 4),
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              price,
              style: const TextStyle(
                color: Color(0xFF34D399),
                fontWeight: FontWeight.w900,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlassTransactionTile extends StatelessWidget {
  final String title, date, amount;
  final bool isCredit;
  const _GlassTransactionTile({
    required this.title,
    required this.date,
    required this.amount,
    required this.isCredit,
  });
  @override
  Widget build(BuildContext context) {
    return _GlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Center(
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color:
                    isCredit
                        ? const Color(0xFF34D399).withOpacity(0.2)
                        : Colors.redAccent.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                color: isCredit ? const Color(0xFF34D399) : Colors.redAccent,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(fontSize: 10, color: Colors.white54),
                  ),
                ],
              ),
            ),
            Text(
              amount,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isCredit ? const Color(0xFF34D399) : Colors.redAccent,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlassActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _GlassActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white24),
            ),
            child: Icon(icon, color: const Color(0xFF34D399), size: 24),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.pushNamedAndRemoveUntil(
            context,
            '/role',
            (route) => false,
          ),
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
  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF34D399), size: 18),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 8,
            letterSpacing: 1,
          ),
        ),
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
