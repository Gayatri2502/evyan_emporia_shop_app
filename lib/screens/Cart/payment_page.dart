import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPaymentMethod = '';
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController upiIdController = TextEditingController();
  TextEditingController gpayNumberController = TextEditingController();
  TextEditingController paytmNumberController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 60,),
        Padding(

          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),

              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: EdgeInsets.fromLTRB(12, 50, 50, 12),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Payment Method:',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 18, ),
                ),
                const SizedBox(height: 55),
                Row(
                  children: [
                    _buildPaymentOption('assets/mastercard_logo.png', 'Mastercard'),
                    const SizedBox(width: 16),
                    _buildPaymentOption('assets/visa_logo.png', 'Visa'),
                    const SizedBox(width: 16),
                    _buildPaymentOption('assets/upi_logo.png', 'UPI'),
                    const SizedBox(width: 16),
                    _buildPaymentOption('assets/gpay_logo.png', 'GPay'),
                    const SizedBox(width: 16),
                    _buildPaymentOption('assets/paytm_logo.png', 'Paytm'),
                  ],
                ),
                const SizedBox(height: 55),
                const Text(
                  'Payment Details:',

                  style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 50),

                if (selectedPaymentMethod == 'Mastercard' || selectedPaymentMethod == 'Visa')
                  _buildCardDetails(),
                if (selectedPaymentMethod == 'UPI') _buildUpiDetails(),
                if (selectedPaymentMethod == 'GPay') _buildGPayDetails(),
                if (selectedPaymentMethod == 'Paytm') _buildPaytmDetails(),
                const SizedBox(height: 50),
                Center(

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo.shade900, // Set the background color here
                    ),
                    onPressed: () {
                      // Process payment logic
                    },
                    child: const Text('Make Payment'),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentOption(String imagePath, String paymentMethod) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = paymentMethod;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: selectedPaymentMethod == paymentMethod ? Colors.indigo : Colors.white,
        ),
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          imagePath,
          height: 40,
          width: 40,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildCardDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: cardNumberController,
          decoration: const InputDecoration(
            labelText: 'Card Number',
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: expiryDateController,
                decoration: const InputDecoration(
                  labelText: 'Expiry Date',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: cvvController,
                decoration: const InputDecoration(
                  labelText: 'CVV',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUpiDetails() {
    return TextField(
      controller: upiIdController,
      decoration: const InputDecoration(
        labelText: 'UPI ID',
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildGPayDetails() {
    return TextField(
      controller: gpayNumberController,
      decoration: const InputDecoration(
        labelText: 'GPay Number',
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildPaytmDetails() {
    return TextField(
      controller: paytmNumberController,
      decoration: const InputDecoration(
        labelText: 'Paytm Number',
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
