import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LeaderboardPage extends StatefulWidget {
  final String code;
  final String username;

  const LeaderboardPage({
    super.key,
    required this.code,
    required this.username,
  });

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  List<dynamic> _leaderboard = [];

  Future<void> _fetchLeaderboard() async {
    final response = await http.get(
      Uri.parse(
        'http://192.168.100.31:5000/rodizio/${widget.code}/leaderboard',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        _leaderboard = jsonDecode(response.body);
      });
    }
  }

  Future<void> _comerFatias() async {
    await http.post(
      Uri.parse('http://192.168.100.31:5000/rodizio/${widget.code}/comer'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': widget.username}),
    );
    _fetchLeaderboard();
  }

  @override
  void initState() {
    super.initState();
    _fetchLeaderboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leaderboard')),
      body: RefreshIndicator(
        onRefresh: _fetchLeaderboard,
        child: ListView.builder(
          itemCount: _leaderboard.length,
          itemBuilder: (context, index) {
            final p = _leaderboard[index];
            return ListTile(
              title: Text(p['username']),
              trailing: Text('${p['slices']} fatias'),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _comerFatias,
        child: const Icon(Icons.local_pizza),
        tooltip: 'Comer +1 fatia',
      ),
    );
  }
}
