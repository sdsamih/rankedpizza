import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'leaderboard.dart';

class JoinPage extends StatefulWidget {
  final String code; // Recebendo o código do rodízio

  const JoinPage({super.key, required this.code}); // Modificando o construtor

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  final _codeController = TextEditingController();
  final _usernameController = TextEditingController();

  String? _error;

  Future<void> _joinRodizio() async {
    final code = _codeController.text.trim().toUpperCase();
    final username = _usernameController.text.trim();

    try {
      final response = await http.post(
        Uri.parse('http://192.168.100.31:5000/rodizio/$code/entrar'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username}),
      );

      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LeaderboardPage(code: code, username: username),
          ),
        );
      } else {
        setState(() {
          _error = jsonDecode(response.body)['error'] ?? 'Erro desconhecido';
        });
      }
    } catch (e) {
      debugPrint('Erro na requisição: $e');
      setState(() {
        _error = 'Falha de conexão ou erro inesperado';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Entrar no Rodízio')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _codeController,
              decoration: const InputDecoration(labelText: 'Código do Rodízio'),
            ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Seu nome'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _joinRodizio,
              child: const Text('Entrar'),
            ),
            if (_error != null) ...[
              const SizedBox(height: 20),
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ],
          ],
        ),
      ),
    );
  }
}
