import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentScreen extends StatefulWidget {
  final String name;
  final String car;
  final String rat;
  PaymentScreen({required this.name, required this.car, required this.rat});
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // Function to handle redirection to PhonePe
  void _openPhonePe() async {
    const phonePeUrl =
        'phonepe://'; // Replace with the correct URL scheme for PhonePe
    if (await canLaunch(phonePeUrl)) {
      await launch(phonePeUrl);
    } else {
      print('Could not launch PhonePe');
    }
  }

void _showAlertDialog(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 50.0,
            ),
            const SizedBox(height: 16),
            Text.rich(
              TextSpan(
                text: '$content \n', // default text style
                children: <TextSpan>[
                  TextSpan(text: 'Driver name: ${widget.name}\n',),
                  TextSpan(text: 'Car: ${widget.car} \n'),
                  TextSpan(text: 'Ratings: ${widget.rat} \n'),
                ],
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

// Call the _showAlertDialog method like this:



  // Function to handle redirection to Google Pay
  void _openGooglePay() async {
    const googlePayUrl = 'upi://pay'; // Use the UPI URL scheme for Google Pay
    if (await canLaunch(googlePayUrl)) {
      await launch(googlePayUrl);
    } else {
      print('Could not launch Google Pay');
    }
  }

  // Function to handle redirection to Paytm
  void _openPaytm() async {
    const paytmUrl =
        'paytmmp://'; // Replace with the correct URL scheme for Paytm
    if (await canLaunch(paytmUrl)) {
      await launch(paytmUrl);
    } else {
      print('Could not launch Paytm');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Payment'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile and Amount Section
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(
                      'lib/asset/drive.png'), // Replace with actual image path
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(widget.rat),
                    Text('ID: 12345'),
                  ],
                ),
                Spacer(),
                Text(
                  '\$15',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Payment Methods Section
            Text('Select Payment Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('PhonePe'),
              onTap: _openPhonePe,
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Google Pay'),
              onTap: _openGooglePay,
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Paytm'),
              onTap: _openPaytm,
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('After the ride'),
              onTap: () {
                // Handle this option
              },
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Other'),
              onTap: () {
                // Handle this option
              },
            ),
            Spacer(),
            // Take Ride Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showAlertDialog(
                      context,"success",
                      "your ride booking is confirmed   "
                      );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('Take Ride'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
