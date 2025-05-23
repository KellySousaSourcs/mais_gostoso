import 'package:flutter/material.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDDD1D), // Cor de fundo externa
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
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/perfil.jpg'),
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
                color: const Color(0xFFF4EEE1), // Cor do fundo interno
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
                    const ListTile(
                      leading: Icon(Icons.description_outlined),
                      title: Text('Dados da conta'),
                    ),
                    const Divider(height: 22),
                    const ListTile(
                      leading: Icon(Icons.credit_card_outlined),
                      title: Text('Pagamentos'),
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