import 'package:flutter/material.dart';

class PagamentoScreen extends StatelessWidget {
  const PagamentoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pagamento')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Escolha o método de pagamento:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.pix),
              title: const Text('Pix'),
              onTap: () {
                // Aqui você pode simular ou implementar a lógica do pagamento via Pix
                Navigator.pushNamed(context, '/pagamento/pix');
              },
            ),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Cartão de Crédito'),
              onTap: () {
                Navigator.pushNamed(context, '/pagamento/cartao');
              },
            ),
          ],
        ),
      ),
    );
  }
}
