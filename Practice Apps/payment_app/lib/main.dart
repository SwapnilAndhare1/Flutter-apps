import 'package:flutter/material.dart';

void main() {
  runApp(const MyPaymentApp());
}

class MyPaymentApp extends StatelessWidget {
  const MyPaymentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Payment App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PaymentHomePage(),
    );
  }
}

class PaymentHomePage extends StatelessWidget {
  const PaymentHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Payment App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Balance: \$100.00',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add logic for initiating payment
                // For example, navigate to a payment screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>const PaymentScreen()),
                );
              },
              child: const Text('Make Payment'),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Enter payment details:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            // Add form fields for payment details (e.g., amount, card details, etc.)
            // Add a button to confirm payment
            ElevatedButton(
              onPressed: () {
                // Add logic for processing payment
                // For example, show a success message and update balance
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Payment Successful'),
                    content: const Text('Thank you for your payment!'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // You might want to navigate back to the home screen
                          //Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Confirm Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
