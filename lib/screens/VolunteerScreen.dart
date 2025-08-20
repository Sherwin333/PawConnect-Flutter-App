import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/VolunteerService.dart';

class BecomeVolunteerScreen extends StatefulWidget {
  const BecomeVolunteerScreen({super.key});

  @override
  State<BecomeVolunteerScreen> createState() => _BecomeVolunteerScreenState();
}

class _BecomeVolunteerScreenState extends State<BecomeVolunteerScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  final _addressController = TextEditingController();
  final _professionController = TextEditingController();
  final _reasonController = TextEditingController();

  String _selectedGender = 'Male';
  bool _isLoading = false;

  Future<void> _selectDOB(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> _submitVolunteer() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final success = await VolunteerService.sendVolunteerData(
      name: _nameController.text.trim(),
      contact: _contactController.text.trim(),
      email: _emailController.text.trim(),
      gender: _selectedGender,
      dob: _dobController.text.trim(),
      address: _addressController.text.trim(),
      profession: _professionController.text.trim(),
      reason: _reasonController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (success) {
      _formKey.currentState!.reset();
      _dobController.clear();
      _selectedGender = 'Male';
      _showSuccessDialog();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submission failed. Please try again.')),
      );
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.check_circle_outline, color: Colors.teal, size: 60),
              SizedBox(height: 16),
              Text("Thank You!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(
                "Your request has been received. We'll get back to you soon!",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType type = TextInputType.text,
    int maxLines = 1,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        maxLines: maxLines,
        readOnly: readOnly,
        onTap: onTap,
        validator: (val) => val == null || val.trim().isEmpty ? 'Required' : null,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(_getIconForLabel(label), color: Colors.teal),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.teal),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  IconData _getIconForLabel(String label) {
    switch (label) {
      case 'Full Name':
        return Icons.person;
      case 'Contact Number':
        return Icons.phone;
      case 'Email':
        return Icons.email;
      case 'Date of Birth':
        return Icons.cake;
      case 'Address':
        return Icons.location_on;
      case 'Profession':
        return Icons.work;
      case 'Why do you want to volunteer?':
        return Icons.question_answer;
      default:
        return Icons.text_fields;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Become a Volunteer'),
      ),
      body: Stack(
        children: [
          // 🌊 Abstract Background Shapes
          Positioned(
            top: -80,
            left: -60,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            right: -80,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(120),
              ),
            ),
          ),

          // 📝 Form Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // 👋 Header Banner
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade600,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.handshake, size: 40, color: Colors.white),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Join us to rescue and care for animals in need!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 📄 Form Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildTextField(controller: _nameController, label: 'Full Name'),
                          _buildTextField(
                            controller: _contactController,
                            label: 'Contact Number',
                            type: TextInputType.phone,
                          ),
                          _buildTextField(
                            controller: _emailController,
                            label: 'Email',
                            type: TextInputType.emailAddress,
                          ),
                          DropdownButtonFormField<String>(
                            value: _selectedGender,
                            items: ['Male', 'Female', 'Other'].map((g) {
                              return DropdownMenuItem(value: g, child: Text(g));
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) setState(() => _selectedGender = val);
                            },
                            decoration: InputDecoration(
                              labelText: 'Gender',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _dobController,
                            label: 'Date of Birth',
                            readOnly: true,
                            onTap: () => _selectDOB(context),
                          ),
                          _buildTextField(
                            controller: _addressController,
                            label: 'Address',
                            maxLines: 2,
                          ),
                          _buildTextField(
                            controller: _professionController,
                            label: 'Profession',
                          ),
                          _buildTextField(
                            controller: _reasonController,
                            label: 'Why do you want to volunteer?',
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 🚀 Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: _isLoading ? null : _submitVolunteer,
                      icon: _isLoading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : const Icon(Icons.send),
                      label: Text(_isLoading ? 'Submitting...' : 'Submit'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
