import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clean_seas_flutter/constants/colours.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the input fields
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _amountController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  // Function to handle form submission
  void _submitPayment() {
    if (_formKey.currentState!.validate()) {
      // Process payment logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment processing...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.withOpacity(0.6),
                      Colors.purple.withOpacity(0.6),
                    ],
                    stops: [0.0 + _controller.value, 1.0 - _controller.value],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text(
                    'Payment',
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  centerTitle: true,
                ),
                const SizedBox(height: 30),
                Text(
                  'Enter Payment Details',
                  style: GoogleFonts.raleway(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 50),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Payment Amount Field
                      buildTextFormField(
                        controller: _amountController,
                        label: 'Payment Amount',
                        icon: Icons.monetization_on,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a payment amount';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      // Card Number Field
                      buildTextFormField(
                        controller: _cardNumberController,
                        label: 'Card Number',
                        icon: Icons.credit_card,
                        keyboardType: TextInputType.number,
                        maxLength: 16,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length != 16) {
                            return 'Please enter a valid 16-digit card number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      // Expiry Date Field
                      buildTextFormField(
                        controller: _expiryDateController,
                        label: 'Expiry Date (MM/YY)',
                        icon: Icons.calendar_today,
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !RegExp(r'(0[1-9]|1[0-2])\/?([0-9]{2})')
                                  .hasMatch(value)) {
                            return 'Please enter a valid expiry date (MM/YY)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      // CVV Field
                      buildTextFormField(
                        controller: _cvvController,
                        label: 'CVV',
                        icon: Icons.lock,
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length != 3) {
                            return 'Please enter a valid 3-digit CVV';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitPayment,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Donate',
                            style: GoogleFonts.raleway(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to create a stylized TextFormField
  Widget buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required TextInputType keyboardType,
    required String? Function(String?) validator,
    int? maxLength,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        labelStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      keyboardType: keyboardType,
      maxLength: maxLength,
      style: const TextStyle(color: Colors.white),
      validator: validator,
    );
  }
}
