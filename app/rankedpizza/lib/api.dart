import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl =
    'http://192.168.100.31:5000'; // emulador Android no localhost

Future<String?> criarRodizio(String name) async {
  final response = await http.post(
    Uri.parse('$baseUrl/rodizio'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'name': name}),
  );

  if (response.statusCode == 201) {
    return jsonDecode(response.body)['code'];
  }
  return null;
}

Future<bool> entrarRodizio(String code, String username) async {
  final response = await http.post(
    Uri.parse('$baseUrl/rodizio/$code/entrar'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'username': username}),
  );
  return response.statusCode == 200;
}

Future<bool> comerFatia(String code, String username) async {
  final response = await http.post(
    Uri.parse('$baseUrl/rodizio/$code/comer'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'username': username}),
  );
  return response.statusCode == 200;
}

Future<List<Map<String, dynamic>>> getLeaderboard(String code) async {
  final response = await http.get(
    Uri.parse('$baseUrl/rodizio/$code/leaderboard'),
  );

  if (response.statusCode == 200) {
    return List<Map<String, dynamic>>.from(jsonDecode(response.body));
  } else {
    return [];
  }
}
