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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller:
                  nameController, // Campo para colocar o nome do rodízio
              decoration: InputDecoration(labelText: 'Nome do rodízio'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              // Botão para criar rodízio
              onPressed: () async {
                final code = await criarRodizio(nameController.text);
                setState(() {
                  codigoCriado = code;
                });
              },
              child: Text('Criar'),
            ),
            const SizedBox(height: 20),
            //botão de entrar
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => JoinPage(
                          code:
                              codigoCriado ??
                              '', // Se nenhum código foi criado, passa string vazia
                        ),
                  ),
                );
              },
              child: Text('Entrar em Rodízio'),
            ),
            const SizedBox(height: 16),
            // Exibe o código criado, se existir
            if (codigoCriado != null) ...[
              Text(
                'Código: $codigoCriado',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
