import 'package:flutter/material.dart';

class CarteiraScreen extends StatelessWidget {
  const CarteiraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEDDD1D),
        title: const Text(
          'Carteira',
          style: TextStyle(
            color: Color(0xFF252810),
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF252810),
        ),
      ),
      backgroundColor: const Color(0xFFF4EEE1),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Métodos de Pagamento',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Colors.white,
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.credit_card, color: Color(0xFF252810)),
                title: const Text('Cartão de Crédito'),
                subtitle: const Text('**** **** **** 1234'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Você pode implementar edição ou adição de cartão
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Saldo na Carteira',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'R\$ 150,00',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Color(0xFF252810),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
