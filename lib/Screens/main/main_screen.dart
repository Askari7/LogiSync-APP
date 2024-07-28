import 'package:flutter/material.dart';
import 'package:flutter_auth/api/get_riders.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                try {
                  await AuthService().riders();
                } catch (e) {
                  print(e);
                }
              },
              child: Text('Call Riders API'),
            ),
          ),
          SizedBox(height: 20,),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                try {
                  final rider_id = await getRiderId();
                  await AuthService().rider_all_journeys(rider_id.toString());
                } catch (e) {
                  print(e);
                }
              },
              child: Text('Call Riders Joureys API'),
            ),
          ),
          SizedBox(height: 20,),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                try {
                  final rider_id = await getRiderId();
                  final response = await AuthService().start_journey();
                } catch (e) {
                  print(e);
                }
              },
              child: Text('Start Journey'),
            ),
          ),
          SizedBox(height: 20,),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                try {
                  final rider_id = await getRiderId();
                  // await AuthService().gps_ping();
                } catch (e) {
                  print(e);
                }
              },
              child: Text('Journey GPS Ping'),
            ),
          ),

          SizedBox(height: 20,),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                try {
                  final rider_id = await getRiderId();
                  // await AuthService().end_journey();
                } catch (e) {
                  print(e);
                }
              },
              child: Text('End Journey'),
            ),
          ),

        ],
      ),
    );
  }
}

Future<String?> getRiderId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('rider_id');
  }