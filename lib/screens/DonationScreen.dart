import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../services/DonationService.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _upiIdController = TextEditingController();

  String _selectedMethod = 'Card';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // Format card number
    _cardNumberController.addListener(() {
      final text = _cardNumberController.text.replaceAll(RegExp(r'\D'), '');
      final formatted = text
          .replaceAllMapped(RegExp(r".{1,4}"), (match) => "${match.group(0)} ")
          .trimRight();
      if (_cardNumberController.text != formatted) {
        _cardNumberController.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }
    });

    // Format expiry MM/YY
    _expiryController.addListener(() {
      String text = _expiryController.text.replaceAll(RegExp(r'[^0-9]'), '');
      if (text.length > 4) text = text.substring(0, 4);
      if (text.length >= 3) {
        text = text.substring(0, 2) + '/' + text.substring(2);
      }
      _expiryController.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    });
  }

  Future<void> _submitDonation() async {
    if (_amountController.text.isEmpty || _descController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Amount and Description required')),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulated loading
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId') ?? '';

    final success = await DonationService.sendDonation(
      userId,
      _amountController.text.trim(),
      _descController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (success) {
      _amountController.clear();
      _descController.clear();
      _cardNumberController.clear();
      _expiryController.clear();
      _cvvController.clear();
      _upiIdController.clear();

      showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Colors.teal, size: 60),
                const SizedBox(height: 16),
                const Text(
                  "Donation Successful!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Thank you for supporting PawConnect. Your contribution helps us rescue and care for more animals ❤️",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Done"),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLength: maxLength,
        decoration: InputDecoration(
          labelText: label,
          counterText: '',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.teal),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildCardMockup() {
    final cardNumber = _cardNumberController.text.isEmpty
        ? 'XXXX XXXX XXXX XXXX'
        : _cardNumberController.text;

    final expiry = _expiryController.text.isEmpty
        ? 'MM/YY'
        : _expiryController.text;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF2c3e50), Color(0xFF4ca1af)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black38, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.credit_card, color: Colors.white70),
              Text(
                "VISA",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            cardNumber,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "VALID THRU",
                style: TextStyle(color: Colors.white70, fontSize: 10),
              ),
              Text(
                expiry,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.favorite, color: Colors.teal, size: 36),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Make a Difference",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade800,
                  ),
                ),
                Text(
                  "Your donation helps save lives ❤️",
                  style: TextStyle(color: Colors.teal.shade700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggle() {
    return Row(
      children: ['Card', 'UPI'].map((method) {
        final isSelected = _selectedMethod == method;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedMethod = method),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected ? Colors.teal : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                method,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPaymentFields() {
    if (_selectedMethod == "Card") {
      return Column(
        children: [
          _buildCardMockup(),
          _buildTextField(
            controller: _cardNumberController,
            label: 'Card Number',
            keyboardType: TextInputType.number,
            maxLength: 19,
          ),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _expiryController,
                  label: 'MM/YY',
                  keyboardType: TextInputType.datetime,
                  maxLength: 5,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildTextField(
                  controller: _cvvController,
                  label: 'CVV',
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  obscureText: true,
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return _buildTextField(
        controller: _upiIdController,
        label: 'UPI ID (e.g. name@bank)',
        keyboardType: TextInputType.emailAddress,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donate to PawConnect"),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(),
                _buildTextField(
                  controller: _amountController,
                  label: 'Donation Amount (₹)',
                  keyboardType: TextInputType.number,
                ),
                _buildTextField(
                  controller: _descController,
                  label: 'Description',
                ),
                const SizedBox(height: 10),
                _buildToggle(),
                const SizedBox(height: 10),
                _buildPaymentFields(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 55,
          child: FloatingActionButton.extended(
            onPressed: _isLoading ? null : _submitDonation,
            icon: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Icons.volunteer_activism),
            label: Text(
              _isLoading ? "Processing..." : "Donate Now",
              style: const TextStyle(fontSize: 16),
            ),
            backgroundColor: Colors.orangeAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
