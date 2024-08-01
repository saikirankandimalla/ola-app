import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:uberclone/booking.dart';
import 'package:uberclone/sidepage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();

  List<dynamic> _allData = [];
  List<dynamic> _filteredData = [];

  @override
  void initState() {
    super.initState();
    _loadData();
    _searchController.addListener(_onSearchChanged);
  }

  Future<void> _loadData() async {
    final String response =
        await rootBundle.loadString('lib/assets/countries.json');
    final data = await json.decode(response);
    setState(() {
      _allData = data;
      _filteredData = data;
    });
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredData = _allData.where((item) {
        final name = item['name'].toLowerCase();
        return name.contains(query);
      }).toList();
    });
  }

  void _showAlertDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const sidepage()),
              );
            },
          ),
        ),
        title: const Text(
          'ANYTIME',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage:
                  AssetImage('lib/asset/logo.png'), // Your logo image
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              
              decoration: InputDecoration(
                hintText: 'Search for destinations?',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 248, 247, 247),
              child: Center(
                child: GestureDetector(
                  child: Image(
                    image: AssetImage('lib/asset/map.png'),
                    fit: BoxFit
                        .cover, // This will fit the image to the container
                  ),
                  onTap: () {
                    _showAlertDialog(context, "REQUEST",
                        "Sir, this is image of the map we know how to integrate the map from google cloud services but for that we have to 1000 rupees which we can't afford right now so sir this is our humble request to consider the project");
                  },
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nearby Drivers',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons
                              .location_on), // Change search icon to location icon
                          hintText: 'Enter location',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0), // Space between icon and text
                    IconButton(
                      icon: const Icon(Icons
                          .my_location),
                      onPressed: () {
                       
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Current location feature removed')),
                        );
                      },
                    ),
                    const SizedBox(width: 8.0), // Space between icon and text
                    TextButton(
                      onPressed: () {
                       
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Current location feature removed')),
                        );
                      },
                      child: const Text('Get Current Location'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                DriverCard(
                    name: 'John Doe', carModel: 'Toyota Prius', rating: 4.8),
                DriverCard(
                    name: 'Jane Smith', carModel: 'Honda Civic', rating: 4.6),
                DriverCard(
                    name: 'Mike Johnson', carModel: 'Ford Fusion', rating: 4.7),
                    DriverCard(
                    name: 'lokesh', carModel: 'Toyota Prius', rating: 4.8),
                // Add more DriverCard widgets as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DriverCard extends StatelessWidget {
  final String name;
  final String carModel;
  final double rating;

  const DriverCard({
    super.key,
    required this.name,
    required this.carModel,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('lib/asset/car.png',
                  height: 40), // Car image placeholder
              const SizedBox(height: 20),
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(carModel),
              Text('Rating: $rating'),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookingPage(
                        name: this.name,
                        car: this.carModel,
                        rat: this.rating.toString(),
                      )));
        },
      ),
    );
  }
}
