import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New Year Countdown',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DateTime _newYear = DateTime(DateTime.now().year + 1, 1, 1);
  
  late Timer _timer;
  late String _countdown;
  late int _currentYear;

  @override
  void initState() {
    super.initState();
    _updateCountdown();
    _updateCurrentYear();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _updateCountdown();
    });
  }

  void _updateCountdown() {
    Duration duration = _newYear.difference(DateTime.now());
    setState(() {
      _countdown =
          '${duration.inDays}d ${duration.inHours.remainder(24)}h ${duration.inMinutes.remainder(60)}m ${duration.inSeconds.remainder(60)}s';
    });
  }

  void _updateCurrentYear() {
    setState(() {
      _currentYear = DateTime.now().year;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1549534077-1b4f31dd59ea?q=80&w=2052&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.black.withOpacity(0.6),
              child: Column(
                children: <Widget>[
                  Text(
                    'Current Year: $_currentYear',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Countdown until New Year:',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _countdown,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
