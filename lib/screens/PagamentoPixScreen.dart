import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PagamentoPixScreen extends StatelessWidget {
  const PagamentoPixScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const chavePix = 'chavepix@exemplo.com';

    return Scaffold(
      appBar: AppBar(title: const Text('Pagamento via Pix')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Escaneie o QR Code para pagar',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                QrImageView(
                  data: chavePix,
                  version: QrVersions.auto,
                  size: 250.0, // Aumenta o tamanho do QR Code
                ),
                const SizedBox(height: 32),
                const Text(
                  'Ou copie a chave Pix abaixo:',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const SelectableText(
                    chavePix,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEDDD1D),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/pedido/concluido');
                    },
                    child: const Text(
                      'Pagamento Realizado',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF252810)
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
