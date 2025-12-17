import 'package:flutter/material.dart';

class PartnerRegistrationScreen extends StatefulWidget {
  const PartnerRegistrationScreen({super.key});

  @override
  State<PartnerRegistrationScreen> createState() => _PartnerRegistrationScreenState();
}

class _PartnerRegistrationScreenState extends State<PartnerRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedVehicle;
  String? _selectedRecyclerType; // Added state variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 1. GLOBAL BACKGROUND (Header Background)
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
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
            top: -50, left: -50,
            child: Container(
              width: 250, height: 250,
              decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF10B981).withOpacity(0.15)),
            ),
          ),

          // 3. MAIN CONTENT
          Column(
            children: [
              // --- HEADER SECTION ---
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white12),
                          ),
                          child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Become a Partner",
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: -1),
                      ),
                      const Text(
                        "Join us to clean & earn.",
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),

              // --- WHITE FORM SHEET ---
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildLightTextField(Icons.person_outline, "Full Name"),
                          const SizedBox(height: 16),
                          _buildLightTextField(Icons.phone_outlined, "Phone Number", isNumber: true),
                          const SizedBox(height: 16),
                          _buildLightTextField(Icons.badge_outlined, "Aadhaar / ID Proof"),
                          const SizedBox(height: 16),

                          // ADDED: Recycler Type Dropdown with specific materials
                          _buildRecyclerTypeDropdown(),
                          const SizedBox(height: 16),

                          // Vehicle Dropdown
                          _buildVehicleDropdown(),
                          const SizedBox(height: 16),
                          
                          _buildLightTextField(Icons.location_on_outlined, "Service Area (Pin Code)", isNumber: true),
                          const SizedBox(height: 30),
                          
                          // CREATE ACCOUNT BUTTON
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF064E3B), // Deep Green
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                elevation: 10,
                                shadowColor: const Color(0xFF064E3B).withOpacity(0.4),
                              ),
                              onPressed: () {
                                // Navigate to Confirmation Screen
                                Navigator.pushNamed(context, '/partner_confirmation');
                              },
                              child: const Text("Create Account", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // ALREADY REGISTERED LINK
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already a partner? ", style: TextStyle(color: Colors.grey)),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(context, '/login', arguments: 'partner'),
                                child: const Text(
                                  "Login Here",
                                  style: TextStyle(color: Color(0xFF064E3B), fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLightTextField(IconData icon, String hint, {bool isNumber = false}) {
    return TextFormField(
      keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
      style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.normal),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF064E3B), width: 1.5),
        ),
      ),
    );
  }

  // --- NEW: Recycler Type Dropdown ---
  Widget _buildRecyclerTypeDropdown() {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.white,
      style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
      value: _selectedRecyclerType,
      items: [
        "Plastic",
        "E-Waste",
        "Batteries",
        "Paper",
        "Metal",
        "Glass",
        "Clothes",
        "All Types"
      ].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
      onChanged: (val) => setState(() => _selectedRecyclerType = val),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.category_outlined, color: Colors.grey),
        hintText: "Select Recycler Type",
        hintStyle: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.normal),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF064E3B), width: 1.5),
        ),
      ),
    );
  }

  Widget _buildVehicleDropdown() {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.white,
      style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
      value: _selectedVehicle,
      items: ["Bike", "Three Wheeler", "Pickup Truck", "Van"]
          .map((v) => DropdownMenuItem(value: v, child: Text(v)))
          .toList(),
      onChanged: (val) => setState(() => _selectedVehicle = val),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.directions_car_outlined, color: Colors.grey),
        hintText: "Select Vehicle Type",
        hintStyle: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.normal),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF064E3B), width: 1.5),
        ),
      ),
    );
  }
}