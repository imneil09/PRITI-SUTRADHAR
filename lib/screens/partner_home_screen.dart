import 'package:flutter/material.dart';
import 'dart:ui'; // Required for BackdropFilter

class PartnerHomeScreen extends StatefulWidget {
  const PartnerHomeScreen({super.key});

  @override
  State<PartnerHomeScreen> createState() => _PartnerHomeScreenState();
}

class _PartnerHomeScreenState extends State<PartnerHomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const _HomeTab(),
    const _UserPaymentsTab(),
    const _CompanyFinanceTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // For glass effect behind nav bar
      body: Stack(
        children: [
          // 1. GLOBAL BACKGROUND
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

          // 2. ABSTRACT BLOBS
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

      // 4. BOTTOM NAVIGATION BAR
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
                icon: Icon(Icons.payment_outlined),
                activeIcon: Icon(Icons.payment),
                label: 'Payouts',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_outlined),
                activeIcon: Icon(Icons.account_balance),
                label: 'Finance',
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

// ================== TAB 1: HOME (Dashboard) ==================
class _HomeTab extends StatefulWidget {
  const _HomeTab();

  @override
  State<_HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<_HomeTab> {
  bool isNewRequests = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Column(
          children: [
            // --- HEADER ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF34D399).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF34D399).withOpacity(0.3),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.circle, color: Color(0xFF34D399), size: 8),
                      SizedBox(width: 6),
                      Text(
                        "ONLINE",
                        style: TextStyle(
                          color: Color(0xFF34D399),
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const _LogoutButton(),
              ],
            ),
            const SizedBox(height: 20),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Partner Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // --- GLASS STATS ---
            _GlassContainer(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatItem(value: '₹850', label: "Today's Pay"),
                  _VerticalDivider(),
                  _StatItem(value: '1314 kg', label: 'Collected'),
                  _VerticalDivider(),
                  _StatItem(value: '4', label: 'Pending'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // --- TOGGLE SWITCH ---
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _TabButton(
                      text: "New Requests",
                      active: isNewRequests,
                      onTap: () => setState(() => isNewRequests = true),
                    ),
                  ),
                  Expanded(
                    child: _TabButton(
                      text: "Pickups",
                      active: !isNewRequests,
                      onTap: () => setState(() => isNewRequests = false),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // --- LIST ---
            Expanded(
              child:
                  isNewRequests
                      ? _buildNewRequestsList()
                      : _buildActivePickup(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewRequestsList() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: const [
        _RequestCard(
          title: "Plastic",
          weight: "5.0 kg",
          loc: "2.5 km • Silchar, Assam",
          color: Colors.orange,
        ),
        _RequestCard(
          title: "Newspaper",
          weight: "5.0 kg",
          loc: "2.5 km • Silchar, Assam",
          color: Colors.blueGrey,
        ),
        SizedBox(height: 80), // Bottom padding for nav bar
      ],
    );
  }

  Widget _buildActivePickup(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        _GlassContainer(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF34D399),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  "IN PROGRESS",
                  style: TextStyle(
                    color: Color(0xFF064E3B),
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Plastic Pickup",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                "Ms Priti Sutradhar",
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white10),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Address", style: TextStyle(color: Colors.white60)),
                    Text(
                      "Silchar, Assam",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF34D399),
                    foregroundColor: const Color(0xFF064E3B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed:
                      () => Navigator.pushNamed(context, '/partner_payment'),
                  icon: const Icon(Icons.scale),
                  label: const Text(
                    "Weigh & Pay",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ================== TAB 2: PAYOUTS ==================
class _UserPaymentsTab extends StatelessWidget {
  const _UserPaymentsTab();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerRight,
              child: _LogoutButton(),
            ),
            const SizedBox(height: 20),

            const Text(
              'Payouts',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            _GlassContainer(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: const Text(
                'Total Paid: ₹13,144',
                style: TextStyle(
                  color: Color(0xFF34D399),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 30),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recent Transactions",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: const [
                  _GlassTransactionTile(
                    name: "Priti Sutradhar",
                    date: "Today, 10:30 AM",
                    amount: "- ₹45",
                    status: "Success",
                  ),
                  _GlassTransactionTile(
                    name: "Sneha Dey",
                    date: "Today, 10:30 AM",
                    amount: "- ₹120",
                    status: "Success",
                  ),
                  _GlassTransactionTile(
                    name: "Rahul Saha",
                    date: "12 Oct",
                    amount: "- ₹45",
                    status: "Success",
                  ),
                  _GlassTransactionTile(
                    name: "Rasmita Saha",
                    date: "10 Oct",
                    amount: "- ₹200",
                    status: "Failed",
                  ),
                  _GlassTransactionTile(
                    name: "Sagar Bhowmik",
                    date: "10 Oct",
                    amount: "- ₹200",
                    status: "Failed",
                  ),

                  SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================== TAB 3: FINANCE ==================
class _CompanyFinanceTab extends StatelessWidget {
  const _CompanyFinanceTab();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerRight,
              child: _LogoutButton(),
            ),
            const SizedBox(height: 40),
            const Text(
              'TrashKari Finance',
              style: TextStyle(color: Colors.white60, letterSpacing: 1),
            ),
            const Text(
              '₹ 15,240',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _GlassActionButton(
                  icon: Icons.add,
                  label: "Add Request",
                  onTap: () {},
                ),
                const SizedBox(width: 20),
                _GlassActionButton(
                  icon: Icons.history,
                  label: "History",
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 40),

            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildGlassOption(Icons.receipt_long, "Invoices"),
                  _buildGlassOption(Icons.pie_chart, "Earnings Report"),
                  _buildGlassOption(Icons.calculate, "Export Ledger"),
                  _buildGlassOption(Icons.support_agent, "Finance Support"),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassOption(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: _GlassContainer(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
            const Icon(Icons.chevron_right, color: Colors.white38),
          ],
        ),
      ),
    );
  }
}

// ================== SHARED WIDGETS ==================

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

class _TabButton extends StatelessWidget {
  final String text;
  final bool active;
  final VoidCallback onTap;
  const _TabButton({
    required this.text,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF34D399) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: active ? const Color(0xFF064E3B) : Colors.white60,
            ),
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value, label;
  const _StatItem({required this.value, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 10,
            letterSpacing: 0.5,
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

class _RequestCard extends StatelessWidget {
  final String title, weight, loc;
  final MaterialColor color;
  const _RequestCard({
    required this.title,
    required this.weight,
    required this.loc,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _GlassContainer(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.recycling, color: color[200]),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          loc,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      weight,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF34D399),
                      ),
                    ),
                    const Text(
                      "EST.",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white38,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white54,
                      side: const BorderSide(color: Colors.white12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Reject"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF34D399),
                      foregroundColor: const Color(0xFF064E3B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Accept",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GlassTransactionTile extends StatelessWidget {
  final String name, date, amount, status;
  const _GlassTransactionTile({
    required this.name,
    required this.date,
    required this.amount,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    bool isSuccess = status == "Success";
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: _GlassContainer(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color:
                    isSuccess
                        ? const Color(0xFF34D399).withOpacity(0.2)
                        : Colors.redAccent.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSuccess ? Icons.check : Icons.close,
                color: isSuccess ? const Color(0xFF34D399) : Colors.redAccent,
                size: 16,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "To: $name",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(fontSize: 12, color: Colors.white54),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amount,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 10,
                    color:
                        isSuccess ? const Color(0xFF34D399) : Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF34D399).withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF34D399).withOpacity(0.4),
              ),
            ),
            child: Icon(icon, color: const Color(0xFF34D399)),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
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
