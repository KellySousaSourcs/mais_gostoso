import 'package:flutter/material.dart';

class PagamentoDinheiroScreen extends StatelessWidget {
  const PagamentoDinheiroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pagamento no Caixa')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.money, size: 80, color: Colors.green),
              const SizedBox(height: 24),
              const Text(
                'Informe no caixa que deseja pagar em dinheiro.\nSeu pedido será processado normalmente.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEDDD1D), // Co
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/pedido/concluido');
                },
                child: const Text('Confirmar',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF252810)),
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
