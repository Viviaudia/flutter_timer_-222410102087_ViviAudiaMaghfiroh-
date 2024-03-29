import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Timer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Timer App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // Menambahkan parameter title pada konstruktor
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title; // Menyimpan judul halaman

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;
  bool _isTimerRunning = false;
  late Timer _timer;
  TextEditingController _controller = TextEditingController();

  void _startTimer() {
    int inputMinutes = int.tryParse(_controller.text) ?? 0;
    setState(() {
      _hours = inputMinutes ~/ 60;
      _minutes = inputMinutes % 60;
      _seconds = 0;
      _isTimerRunning = true;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        if (_minutes == 0 && _hours == 0) {
          timer.cancel();
          _showAlertDialog();
        } else {
          setState(() {
            if (_minutes == 0) {
              if (_hours > 0) {
                _hours--;
                _minutes = 59;
              }
            } else {
              _minutes--;
            }
            _seconds = 59;
          });
        }
      } else {
        setState(() {
          _seconds--;
        });
      }
    });
  }

  void _stopTimer() {
    _timer.cancel();
    setState(() {
      _isTimerRunning = false;
    });
  }

  void _resetTimer() {
    _timer.cancel();
    setState(() {
      _hours = 0;
      _minutes = 0;
      _seconds = 0;
      _isTimerRunning = false;
      _controller.clear();
    });
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Waktu Habis!'),
          content: Text('Timer telah selesai.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'NIM: 222410102087',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Nama: [Vivi Audia Maghfiroh]',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Center(
              child: Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Masukkan menit:',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Menit',
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Waktu Tersisa:',
              style: TextStyle(fontSize: 24),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildTimeDisplay(_hours, 'Hours'),
                SizedBox(width: 20),
                _buildTimeDisplay(_minutes, 'Minutes'),
                SizedBox(width: 20),
                _buildTimeDisplay(_seconds, 'Seconds'),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: Text('Start'),
                  onPressed: _isTimerRunning ? null : _startTimer,
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  child: Text('Stop'),
                  onPressed: _isTimerRunning ? _stopTimer : null,
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  child: Text('Reset'),
                  onPressed: _resetTimer,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeDisplay(int time, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            time.toString().padLeft(2, '0'),
            style: TextStyle(fontSize: 24),
          ),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
