import 'package:flutter/material.dart';
import 'dart:ui'; // Required for BackdropFilter

class PickupWizardScreen extends StatefulWidget {
  const PickupWizardScreen({super.key});

  @override
  State<PickupWizardScreen> createState() => _PickupWizardScreenState();
}

class _PickupWizardScreenState extends State<PickupWizardScreen> {
  int _currentStep = 1;
  double _quantity = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 1. GLOBAL BACKGROUND (Deep Forest Theme)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF064E3B), Color(0xFF065F46), Color(0xFF022C22)],
              ),
            ),
          ),

          // 2. ABSTRACT BLOBS
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF10B981).withOpacity(0.15),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: -50,
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
          SafeArea(
            child: Column(
              children: [
                // --- CUSTOM HEADER ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      _GlassBackButton(onTap: () {
                         if(_currentStep > 1) setState(() => _currentStep--);
                         else Navigator.pop(context);
                      }),
                      Expanded(
                        child: Text(
                          _currentStep < 3 ? 'New Pickup' : 'Success',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 40), // Balance the back button
                    ],
                  ),
                ),

                // --- PROGRESS INDICATOR ---
                if (_currentStep < 3)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: Row(
                      children: List.generate(2, (index) {
                        bool isActive = _currentStep > index;
                        return Expanded(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 6,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: isActive ? const Color(0xFF34D399) : Colors.white24,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: isActive ? [
                                BoxShadow(
                                  color: const Color(0xFF34D399).withOpacity(0.4),
                                  blurRadius: 8,
                                )
                              ] : [],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                // --- DYNAMIC STEP CONTENT ---
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    physics: const BouncingScrollPhysics(),
                    child: _buildStepContent(),
                  ),
                ),

                // --- BOTTOM ACTION BAR ---
                _buildBottomBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF064E3B).withOpacity(0.6),
            border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
          ),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF34D399),
                foregroundColor: const Color(0xFF064E3B),
                elevation: 0,
                shadowColor: const Color(0xFF34D399).withOpacity(0.4),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: () {
                if (_currentStep < 3) {
                  setState(() => _currentStep++);
                } else {
                  Navigator.pushNamedAndRemoveUntil(context, '/user_home', (route) => false);
                }
              },
              child: Text(
                _currentStep < 3 ? 'Continue' : 'Back to Dashboard',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    if (_currentStep == 1) return _buildStep1();
    if (_currentStep == 2) return _buildStep2();
    return _buildStep3();
  }

  // ================== STEP 1: QUANTITY ==================
  Widget _buildStep1() {
    int estValue = (_quantity * 12).round();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("CATEGORY", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white54, letterSpacing: 1)),
        const SizedBox(height: 8),
        Row(children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.water_drop, color: Colors.orange, size: 28),
          ),
          const SizedBox(width: 12),
          const Text("Plastic Waste", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white)),
        ]),
        const SizedBox(height: 30),
        
        // --- QUANTITY CARD (GLASS) ---
        _GlassContainer(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text("Est. Quantity", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF34D399).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF34D399).withOpacity(0.3)),
                  ),
                  child: Text(" ₹$estValue", style: const TextStyle(color: Color(0xFF34D399), fontWeight: FontWeight.bold)),
                )
              ]),
              const SizedBox(height: 24),
              Text(
                "${_quantity.toInt()} KG", 
                style: const TextStyle(fontSize: 56, fontWeight: FontWeight.w900, color: Colors.white, height: 1.0)
              ),
              const SizedBox(height: 20),
              
              // Custom Slider Theme
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: const Color(0xFF34D399),
                  inactiveTrackColor: Colors.white12,
                  thumbColor: Colors.white,
                  trackHeight: 6,
                  overlayColor: const Color(0xFF34D399).withOpacity(0.2),
                ),
                child: Slider(
                  value: _quantity, min: 1, max: 50,
                  onChanged: (val) => setState(() => _quantity = val),
                ),
              ),
              const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("1 kg", style: TextStyle(fontSize: 12, color: Colors.white38)),
                Text("50 kg", style: TextStyle(fontSize: 12, color: Colors.white38)),
              ])
            ],
          ),
        ),
        const SizedBox(height: 30),
        
        const Text("VERIFICATION", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white54, letterSpacing: 1)),
        const SizedBox(height: 12),
        
        // --- UPLOAD BOX (GLASS) ---
        Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            border: Border.all(color: Colors.white24),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF34D399).withOpacity(0.1),
                  shape: BoxShape.circle
                ),
                child: const Icon(Icons.camera_alt, color: Color(0xFF34D399), size: 28),
              ),
              const SizedBox(height: 12),
              const Text("Upload Photo", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70)),
            ],
          ),
        )
      ],
    );
  }

  // ================== STEP 2: SCHEDULE ==================
  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("When & Where?", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white)),
        const Text("Select a convenient slot.", style: TextStyle(color: Colors.white54, fontSize: 16)),
        const SizedBox(height: 30),
        
        // --- ADDRESS CARD (GLASS) ---
        _GlassContainer(
          padding: const EdgeInsets.all(20),
          child: Row(children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: const Color(0xFF34D399).withOpacity(0.15), shape: BoxShape.circle),
              child: const Icon(Icons.location_on, color: Color(0xFF34D399), size: 24),
            ),
            const SizedBox(width: 16),
            const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("PICKUP ADDRESS", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white54, letterSpacing: 1)),
              SizedBox(height: 4),
              Text("Home (Sector 4)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
              Text("#102, Green Valley Apts", style: TextStyle(color: Colors.white70, fontSize: 12)),
            ])
          ]),
        ),
        const SizedBox(height: 24),
        
        const Text("Select Date", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 12),
        Row(children: [
          _optionBtn("Today", false),
          const SizedBox(width: 12),
          _optionBtn("Tomorrow", true),
          const SizedBox(width: 12),
          _optionBtn("Oct 14", false),
        ]),
        const SizedBox(height: 24),
        
        const Text("Time Slot", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 12),
        
        // --- TIME SLOT (ACTIVE GLASS) ---
        Container(
          width: double.infinity, padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF34D399).withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF34D399).withOpacity(0.5)),
          ),
          child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("09:00 AM - 12:00 PM", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF34D399), fontSize: 16)),
            Icon(Icons.check_circle, color: Color(0xFF34D399))
          ]),
        )
      ],
    );
  }

  // ================== STEP 3: SUCCESS ==================
  Widget _buildStep3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        // Glow Animation Container
        Container(
          width: 120, height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF34D399).withOpacity(0.1),
            boxShadow: [
              BoxShadow(color: const Color(0xFF34D399).withOpacity(0.2), blurRadius: 40, spreadRadius: 10),
            ],
          ),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [Color(0xFF34D399), Color(0xFF059669)]),
              ),
              child: const Icon(Icons.check, size: 48, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 30),
        const Text("Request Sent !", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white)),
        const Text("Partner will arrive tomorrow.", style: TextStyle(color: Colors.white60, fontSize: 16)),
        const SizedBox(height: 40),
        
        // --- SUMMARY CARD (GLASS) ---
        _GlassContainer(
          padding: const EdgeInsets.all(24),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text("Est. Value", style: TextStyle(color: Colors.white70, fontSize: 16)),
            Text("₹${(_quantity * 12).toInt()}", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF34D399))),
          ]),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _optionBtn(String text, bool selected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF34D399) : Colors.white.withOpacity(0.05),
          border: Border.all(color: selected ? const Color(0xFF34D399) : Colors.white12),
          borderRadius: BorderRadius.circular(16)
        ),
        child: Center(
          child: Text(
            text, 
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              color: selected ? const Color(0xFF064E3B) : Colors.white70
            )
          )
        ),
      ),
    );
  }
}

// ================== HELPER WIDGETS ==================

class _GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const _GlassContainer({required this.child, required this.padding});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(24),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _GlassBackButton extends StatelessWidget {
  final VoidCallback onTap;
  const _GlassBackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white12),
        ),
        child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
      ),
    );
  }
}