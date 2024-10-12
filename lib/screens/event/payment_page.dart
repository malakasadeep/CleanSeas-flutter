import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment', style: GoogleFonts.raleway()),
      ),
      body: Center(
        child: Text(
          'Payment Page',
          style: GoogleFonts.raleway(fontSize: 24),
        ),
      ),
    );
  }
}
