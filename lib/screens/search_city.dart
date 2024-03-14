import 'package:flutter/material.dart';
import 'package:know_your_weather/screens/loading_screen.dart';
import 'package:know_your_weather/screens/location_page.dart';
import 'package:know_your_weather/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});
  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName = '';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.blueAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                style: const TextStyle(color: Colors.black),
                decoration: kTextFieldDecoration,
                onChanged: (value) {
                  cityName = value;
                },
              ),
            ),
            OutlinedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                (states) => Colors.greenAccent,
              )),
              onPressed: () async {
                Navigator.pop(context, cityName);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
