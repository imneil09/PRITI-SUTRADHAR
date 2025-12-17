import 'package:flutter/material.dart';

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
          // 1. GLOBAL BACKGROUND (Header Background)
          Container(
            height: MediaQuery.of(context).size.height * 0.35, // Top 35% is green
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

          // 3. MAIN CONTENT
          Column(
            children: [
              // --- HEADER SECTION (GREEN) ---
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _HeaderBackButton(onTap: () {
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
                      
                      const SizedBox(height: 20),

                      // --- PROGRESS INDICATOR ---
                      if (_currentStep < 3)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),

              // --- WHITE BODY SECTION ---
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(24, 30, 24, 20),
                          child: _buildStepContent(),
                        ),
                      ),
                      
                      // --- BOTTOM ACTION BAR (WHITE) ---
                      _buildBottomBar(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF064E3B), // Deep Green Button
            foregroundColor: Colors.white,
            elevation: 10,
            shadowColor: const Color(0xFF064E3B).withOpacity(0.4),
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
    );
  }

  Widget _buildStepContent() {
    if (_currentStep == 1) return _buildStep1();
    if (_currentStep == 2) return _buildStep2();
    return _buildStep3();
  }

  // ================== STEP 1: QUANTITY (LIGHT THEME) ==================
  Widget _buildStep1() {
    int estValue = (_quantity * 12).round();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("CATEGORY", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1)),
        const SizedBox(height: 8),
        Row(children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.water_drop, color: Colors.orange, size: 28),
          ),
          const SizedBox(width: 12),
          const Text("Plastic Waste", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF064E3B))),
        ]),
        const SizedBox(height: 30),
        
        // --- QUANTITY CARD (LIGHT) ---
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5)),
            ],
          ),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text("Est. Quantity", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF34D399).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(" ₹$estValue", style: const TextStyle(color: Color(0xFF064E3B), fontWeight: FontWeight.bold)),
                )
              ]),
              const SizedBox(height: 24),
              Text(
                "${_quantity.toInt()} KG", 
                style: const TextStyle(fontSize: 56, fontWeight: FontWeight.w900, color: Color(0xFF064E3B), height: 1.0)
              ),
              const SizedBox(height: 20),
              
              // Slider
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: const Color(0xFF064E3B),
                  inactiveTrackColor: Colors.grey[200],
                  thumbColor: const Color(0xFF34D399),
                  trackHeight: 6,
                  overlayColor: const Color(0xFF34D399).withOpacity(0.2),
                ),
                child: Slider(
                  value: _quantity, min: 1, max: 50,
                  onChanged: (val) => setState(() => _quantity = val),
                ),
              ),
              const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("1 kg", style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text("50 kg", style: TextStyle(fontSize: 12, color: Colors.grey)),
              ])
            ],
          ),
        ),
        const SizedBox(height: 30),
        
        const Text("VERIFICATION", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1)),
        const SizedBox(height: 12),
        
        // --- UPLOAD BOX (LIGHT) ---
        Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[50],
            border: Border.all(color: Colors.grey[300]!, style: BorderStyle.solid), // Dashed border preferred if package allowed
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
                child: const Icon(Icons.camera_alt, color: Color(0xFF064E3B), size: 28),
              ),
              const SizedBox(height: 12),
              const Text("Upload Photo", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            ],
          ),
        )
      ],
    );
  }

  // ================== STEP 2: SCHEDULE (LIGHT THEME) ==================
  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("When & Where?", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF064E3B))),
        const Text("Select a convenient slot.", style: TextStyle(color: Colors.grey, fontSize: 16)),
        const SizedBox(height: 30),
        
        // --- ADDRESS CARD (LIGHT) ---
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
          ),
          child: Row(children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: const Color(0xFF34D399).withOpacity(0.1), shape: BoxShape.circle),
              child: const Icon(Icons.location_on, color: Color(0xFF064E3B), size: 24),
            ),
            const SizedBox(width: 16),
            const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("PICKUP ADDRESS", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1)),
              SizedBox(height: 4),
              Text("Ms Priti Sutradhar", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF064E3B))),
              Text("Silchar, Assam", style: TextStyle(color: Colors.grey, fontSize: 12)),
            ])
          ]),
        ),
        const SizedBox(height: 24),
        
        const Text("Select Date", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF064E3B))),
        const SizedBox(height: 12),
        Row(children: [
          _optionBtn("Today", false),
          const SizedBox(width: 12),
          _optionBtn("Tomorrow", true),
          const SizedBox(width: 12),
          _optionBtn("Oct 14", false),
        ]),
        const SizedBox(height: 24),
        
        const Text("Time Slot", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF064E3B))),
        const SizedBox(height: 12),
        
        // --- TIME SLOT (LIGHT) ---
        Container(
          width: double.infinity, padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF34D399).withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF34D399).withOpacity(0.3)),
          ),
          child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("09:00 AM - 12:00 PM", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF064E3B), fontSize: 16)),
            Icon(Icons.check_circle, color: Color(0xFF064E3B))
          ]),
        )
      ],
    );
  }

  // ================== STEP 3: SUCCESS (LIGHT THEME) ==================
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
        const Text("Request Sent !", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF064E3B))),
        const Text("Partner will arrive tomorrow.", style: TextStyle(color: Colors.grey, fontSize: 16)),
        const SizedBox(height: 40),
        
        // --- SUMMARY CARD (LIGHT) ---
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text("Est. Value", style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold)),
            Text("₹${(_quantity * 12).toInt()}", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF064E3B))),
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
          color: selected ? const Color(0xFF064E3B) : Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: selected ? const Color(0xFF064E3B) : Colors.transparent),
        ),
        child: Center(
          child: Text(
            text, 
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              color: selected ? Colors.white : Colors.black54
            )
          )
        ),
      ),
    );
  }
}

// ================== HELPER WIDGETS ==================

class _HeaderBackButton extends StatelessWidget {
  final VoidCallback onTap;
  const _HeaderBackButton({required this.onTap});

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