import 'package:flutter/material.dart';

class UserKycScreen extends StatefulWidget {
  const UserKycScreen({super.key});

  @override
  State<UserKycScreen> createState() => _UserKycScreenState();
}

class _UserKycScreenState extends State<UserKycScreen> {
  final _formKey = GlobalKey<FormState>();

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
                      Row(
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
                          const SizedBox(width: 20),
                          // CHANGED: Title updated here
                          const Text(
                            "Complete Your Profile",
                            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Padding(
                        padding: EdgeInsets.only(left: 60),
                        child: Text(
                          "Help us locate you accurately.",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 20),
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
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Auto Fetch Location Button
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 24),
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.my_location, color: Color(0xFF064E3B)),
                              label: const Text("Auto Fetch my Location"),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF064E3B),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                side: const BorderSide(color: Color(0xFF064E3B), width: 1.5),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              ),
                            ),
                          ),

                          const Text("PERSONAL DETAILS", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1)),
                          const SizedBox(height: 12),
                          
                          _buildLightTextField(Icons.person_outline, "Full Name"),
                          const SizedBox(height: 16),
                          _buildLightTextField(Icons.email_outlined, "Email ID"),
                          
                          const SizedBox(height: 24),
                          const Text("ADDRESS DETAILS", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1)),
                          const SizedBox(height: 12),

                          // Pincode, State, City Row
                          Row(
                            children: [
                              Expanded(child: _buildLightTextField(null, "Pincode", isNumber: true)),
                              const SizedBox(width: 10),
                              Expanded(child: _buildLightTextField(null, "State")),
                              const SizedBox(width: 10),
                              Expanded(child: _buildLightTextField(null, "City")),
                            ],
                          ),
                          const SizedBox(height: 16),
                          
                          _buildLightTextField(Icons.flag_outlined, "Landmark"),
                          const SizedBox(height: 16),
                          _buildLightTextField(Icons.home_outlined, "House No, Area, Colony"),

                          const SizedBox(height: 80),

                          // NEXT BUTTON
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF064E3B),
                                foregroundColor: Colors.white,
                                elevation: 10,
                                shadowColor: const Color(0xFF064E3B).withOpacity(0.4),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              ),
                              onPressed: () {
                                // Navigate to Home Screen
                                Navigator.pushNamedAndRemoveUntil(context, '/user_home', (route) => false);
                              },
                              child: const Text("Next", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
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

  Widget _buildLightTextField(IconData? icon, String hint, {bool isNumber = false}) {
    return TextFormField(
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
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
}