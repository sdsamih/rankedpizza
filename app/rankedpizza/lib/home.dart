import 'package:flutter/material.dart';
import 'package:rankedpizza/api.dart'; // Certifique-se de que o arquivo API esteja correto
import 'join.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  String? codigoCriado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Criar Rodízio')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nome do rodízio'),
            ),
            ElevatedButton(
              onPressed: () async {
                final code = await criarRodizio(nameController.text);
                setState(() {
                  codigoCriado = code;
                });
              },
              child: Text('Criar'),
            ),
            if (codigoCriado != null)
              Column(
                children: [
                  Text('Código: $codigoCriado'),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => JoinPage(
                            code: codigoCriado!, // Passando o código correto
                          ),
                        ),
                      );
                    },
                    child: Text('Entrar'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
