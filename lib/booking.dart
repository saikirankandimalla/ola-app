import 'package:flutter/material.dart';
import 'package:uberclone/payment.dart';

class BookingPage extends StatefulWidget {
  final String name;
  final String car;
  final String rat;
  BookingPage({required this.name, required this.car, required this.rat});
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BOOKING'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'lib/asset/car.png', // Replace with your image URL
                height: 150,
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                widget.car,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                      'lib/asset/drive.png'), // Replace with your image URL
                  radius: 30,
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(widget.rat),
                    Text('ID:12345'),
                  ],
                ),
                Spacer(),
                Text(
                  '15\$',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'DRIVER LICENSE>',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Center(
              child: Image.asset(
                'lib/asset/lince.png', // Replace with your image URL
                height: 100,
              ),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PaymentScreen(name: widget.name, car: widget.car, rat: widget.rat,)));
                  // Handle book button press
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                child: Text(
                  'BOOK',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
