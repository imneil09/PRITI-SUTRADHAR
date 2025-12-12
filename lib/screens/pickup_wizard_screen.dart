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
      appBar: AppBar(
        title: const Text('New Pickup', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: BackButton(onPressed: () {
          if(_currentStep > 1) setState(() => _currentStep--);
          else Navigator.pop(context);
        }),
      ),
      body: Column(
        children: [
          // Progress Bar
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(children: List.generate(3, (index) => Expanded(
              child: Container(
                height: 6,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: _currentStep > index ? const Color(0xFF10B981) : Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ))),
          ),
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: _buildStepContent(),
            ),
          ),
          
          // Bottom Bar
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade100)),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _currentStep == 3 ? const Color(0xFF1F2937) : const Color(0xFF10B981),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {
                  if (_currentStep < 3) {
                    setState(() => _currentStep++);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(context, '/user_home', (route) => false);
                  }
                },
                child: Text(_currentStep < 3 ? 'Continue' : 'Back to Dashboard', 
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    if (_currentStep == 1) return _buildStep1();
    if (_currentStep == 2) return _buildStep2();
    return _buildStep3();
  }

  Widget _buildStep1() {
    int estValue = (_quantity * 12).round(); // 12 rs per kg
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("CATEGORY", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 4),
        const Row(children: [
          Icon(Icons.water_drop, color: Colors.orange),
          SizedBox(width: 8),
          Text("Plastic Waste", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
        ]),
        const SizedBox(height: 30),
        
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white),
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 20)],
          ),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text("Est. Quantity", style: TextStyle(fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFFECFDF5), borderRadius: BorderRadius.circular(8)),
                  child: Text("~ ₹$estValue", style: const TextStyle(color: Color(0xFF059669), fontWeight: FontWeight.bold)),
                )
              ]),
              const SizedBox(height: 20),
              Text("${_quantity.toInt()} KG", style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w900)),
              Slider(
                value: _quantity, min: 1, max: 50, activeColor: const Color(0xFF10B981),
                onChanged: (val) => setState(() => _quantity = val),
              ),
              const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("1 kg", style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text("50 kg", style: TextStyle(fontSize: 12, color: Colors.grey)),
              ])
            ],
          ),
        ),
        const SizedBox(height: 30),
        const Text("VERIFICATION", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 8),
        Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid), // Dashed border needs a package, using solid for now
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(padding: const EdgeInsets.all(10), decoration: const BoxDecoration(color: Color(0xFFEFF6FF), shape: BoxShape.circle), child: const Icon(Icons.camera_alt, color: Colors.blue)),
              const SizedBox(height: 8),
              const Text("Upload Photo", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("When & Where?", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10)]),
          child: const Row(children: [
            CircleAvatar(backgroundColor: Color(0xFFECFDF5), child: Icon(Icons.location_on, color: Color(0xFF10B981))),
            SizedBox(width: 16),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("PICKUP ADDRESS", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
              Text("Home (Sector 4)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text("#102, Green Valley Apts", style: TextStyle(color: Colors.grey, fontSize: 12)),
            ])
          ]),
        ),
        const SizedBox(height: 20),
        const Text("Select Date", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(children: [
          _optionBtn("Today", false),
          const SizedBox(width: 10),
          _optionBtn("Tomorrow", true),
          const SizedBox(width: 10),
          _optionBtn("Oct 14", false),
        ]),
        const SizedBox(height: 20),
        const Text("Time Slot", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Container(
          width: double.infinity, padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: const Color(0xFFECFDF5), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF10B981))),
          child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("09:00 AM - 12:00 PM", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF064E3B))),
            Icon(Icons.check, color: Color(0xFF059669))
          ]),
        )
      ],
    );
  }

  Widget _buildStep3() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [Color(0xFF34D399), Color(0xFF059669)])),
            child: const Icon(Icons.check, size: 48, color: Colors.white),
          ),
          const SizedBox(height: 24),
          const Text("Request Sent!", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900)),
          const Text("Partner will arrive tomorrow.", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 20)]),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("Est. Value", style: TextStyle(color: Colors.grey)),
              Text("~₹${(_quantity * 12).toInt()}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF059669))),
            ]),
          )
        ],
      ),
    );
  }

  Widget _optionBtn(String text, bool selected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFECFDF5) : Colors.white,
          border: Border.all(color: selected ? const Color(0xFF10B981) : Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12)
        ),
        child: Center(child: Text(text, style: TextStyle(fontWeight: FontWeight.bold, color: selected ? const Color(0xFF065F46) : Colors.grey))),
      ),
    );
  }
}