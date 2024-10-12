import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clean_seas_flutter/constants/colours.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the input fields
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

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
      backgroundColor: backgroundBlue,
      appBar: AppBar(
        backgroundColor: backgroundBlue,
        title: Text('Payment',
            style: GoogleFonts.raleway(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter Payment Details',
                style: GoogleFonts.raleway(
                    fontSize: 28, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 50),
              // Payment Amount Field
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Payment Amount',
                  border: OutlineInputBorder(),
                ),
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
              TextFormField(
                controller: _cardNumberController,
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                maxLength: 16, // Max length for a card number
                validator: (value) {
                  if (value == null || value.isEmpty || value.length != 16) {
                    return 'Please enter a valid 16-digit card number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Expiry Date Field
              TextFormField(
                controller: _expiryDateController,
                decoration: const InputDecoration(
                  labelText: 'Expiry Date (MM/YY)',
                  border: OutlineInputBorder(),
                ),
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
              TextFormField(
                controller: _cvvController,
                decoration: const InputDecoration(
                  labelText: 'CVV',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                maxLength: 3, // CVV is typically 3 digits
                validator: (value) {
                  if (value == null || value.isEmpty || value.length != 3) {
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
                    backgroundColor:
                        Colors.black, // Set background color to black
                  ),
                  child: Text(
                    'Donate',
                    style: GoogleFonts.raleway(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color:
                          Colors.white, // Ensure the text is white for contrast
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
