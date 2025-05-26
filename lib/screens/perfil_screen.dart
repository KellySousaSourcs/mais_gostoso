import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mais_gostoso/screens/carteira_screen.dart';
import 'package:mais_gostoso/screens/editarPerfilScreen.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  String? imagePath;
  String nome = 'Thomáz Jefferson';
  String telefone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDDD1D),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: const Color(0xFFEDDD1D),
              padding: const EdgeInsets.all(30),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF000000).withOpacity(0.1),
                          spreadRadius: 1,
                          offset: const Offset(1, 2),
                        ),
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(45)),
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          imagePath != null
                              ? FileImage(File(imagePath!))
                              : const AssetImage('assets/images/perfil.jpg')
                                  as ImageProvider,
                    ),
                  ),
                  const SizedBox(width: 33),
                  const Text(
                    'Thomáz Jefferson',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Nunito-Medium',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: const Color(0xFFF4EEE1),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  children: [
                    ListTile(
                      leading: const Icon(Icons.favorite_border),
                      title: const Text('Favoritos'),
                      onTap: () {
                        Navigator.pushNamed(context, '/favorites');
                      },
                    ),
                    const Divider(height: 22),
                    ListTile(
                      leading: const Icon(Icons.description_outlined),
                      title: const Text('Dados da conta'),
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const EditarPerfilScreen(),
                          ),
                        );

                        if (result != null && result is Map) {
                          setState(() {
                            imagePath = result['imagem'] ?? imagePath;
                            nome =
                                result['nome'].isNotEmpty
                                    ? result['nome']
                                    : nome;
                            telefone = result['telefone'] ?? telefone;
                          });
                        }
                      },
                    ),
                    const Divider(height: 22),
                    ListTile(
                      leading: const Icon(Icons.credit_card_outlined),
                      title: const Text('Pagamentos'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CarteiraScreen(),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 22),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
