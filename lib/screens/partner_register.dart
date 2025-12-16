import 'package:flutter/material.dart';
import 'dart:ui';

class PartnerRegistrationScreen extends StatefulWidget {
  const PartnerRegistrationScreen({super.key});

  @override
  State<PartnerRegistrationScreen> createState() => _PartnerRegistrationScreenState();
}

class _PartnerRegistrationScreenState extends State<PartnerRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedVehicle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
      ),
      body: Stack(
        children: [
          // 1. BACKGROUND
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF064E3B), Color(0xFF065F46), Color(0xFF022C22)],
              ),
            ),
          ),
          
          // 2. DECORATION BLOBS
          Positioned(
            top: -50, left: -50,
            child: Container(
              width: 200, height: 200,
              decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF10B981).withOpacity(0.15)),
            ),
          ),

          // 3. FORM CONTENT
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Become a Partner",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: -1),
                  ),
                  const Text(
                    "Join us to clean & earn.",
                    style: TextStyle(fontSize: 16, color: Colors.white60),
                  ),
                  const SizedBox(height: 30),

                  // --- FORM CONTAINER ---
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              _buildGlassTextField(Icons.person, "Full Name"),
                              const SizedBox(height: 16),
                              _buildGlassTextField(Icons.phone, "Phone Number", isNumber: true),
                              const SizedBox(height: 16),
                              _buildGlassTextField(Icons.badge, "Aadhaar / ID Proof"),
                              const SizedBox(height: 16),
                              _buildGlassDropdown(),
                              const SizedBox(height: 16),
                              _buildGlassTextField(Icons.location_on, "Service Area (Pin Code)", isNumber: true),
                              const SizedBox(height: 30),
                              
                              // REGISTER BUTTON
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF34D399),
                                    foregroundColor: const Color(0xFF064E3B),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    elevation: 10,
                                    shadowColor: const Color(0xFF34D399).withOpacity(0.4),
                                  ),
                                  onPressed: () {
                                    // Navigate to OTP or Partner Home
                                    Navigator.pushNamed(context, '/login', arguments: 'partner');
                                  },
                                  child: const Text("Create Account", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // --- ALREADY REGISTERED LINK ---
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already a partner? ", style: TextStyle(color: Colors.white60)),
                        GestureDetector(
                          onTap: () {
                             // Redirect to Login Screen
                             Navigator.pushNamed(context, '/login', arguments: 'partner');
                          },
                          child: const Text(
                            "Login Here",
                            style: TextStyle(color: Color(0xFF34D399), fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassTextField(IconData icon, String hint, {bool isNumber = false}) {
    return TextFormField(
      keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF34D399)),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: Colors.black.withOpacity(0.2),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF34D399)),
        ),
      ),
    );
  }

  Widget _buildGlassDropdown() {
    return DropdownButtonFormField<String>(
      dropdownColor: const Color(0xFF064E3B),
      style: const TextStyle(color: Colors.white),
      value: _selectedVehicle,
      items: ["Bike", "Three Wheeler", "Pickup Truck", "Van"]
          .map((v) => DropdownMenuItem(value: v, child: Text(v)))
          .toList(),
      onChanged: (val) => setState(() => _selectedVehicle = val),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.directions_car, color: Color(0xFF34D399)),
        hintText: "Select Vehicle Type",
        hintStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: Colors.black.withOpacity(0.2),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF34D399)),
        ),
      ),
    );
  }
}