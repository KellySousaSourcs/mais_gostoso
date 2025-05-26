import 'package:mais_gostoso/screens/PagamentoCartaoScreen.dart';
import 'package:mais_gostoso/screens/PagamentoDinheiroScreen.dart';
import 'package:mais_gostoso/screens/PagamentoPixScreen.dart';
import 'package:mais_gostoso/screens/PedidoConcluidoScreen.dart';
import 'package:mais_gostoso/screens/favorites_screen.dart';
import 'package:mais_gostoso/screens/home_screen.dart';
import 'package:mais_gostoso/screens/item_descripition_screen.dart';
import 'package:mais_gostoso/screens/loginScreen.dart';
import 'package:mais_gostoso/screens/pagamento_screen.dart';
import 'package:mais_gostoso/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Adicione estas linhas para debug:
  debugPrint('Teste de conexão: http://172.30.247.10:8000/api/test');
  debugPrint('Versão do app: 1.0.0'); // Opcional: útil para controle

  runApp(const MaisGostoso());
}

class MaisGostoso extends StatelessWidget {
  const MaisGostoso({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '+Gostoso App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color(0xFF252810),
          contentTextStyle: TextStyle(
            color: Color(0xFFF4FFF1),
            fontSize: 14,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(initialIndex: 0),
        '/pedidos': (context) => const HomeScreen(initialIndex: 1),
        '/pagamento': (context) => const PagamentoScreen(),
        '/pagamento/pix': (context) => const PagamentoPixScreen(),
        '/pagamento/cartao': (context) => const PagamentoCartaoScreen(),
        '/pagamento/dinheiro': (context) => const PagamentoDinheiroScreen(),
        '/pedido/concluido': (context) => const PedidoConcluidoScreen(),
        '/login': (context) => const LoginScreen(),
        '/favorites': (context) => const FavoritesScreen(),
        '/item-description': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return ItemDescriptionScreen(item: args);
        },
      },
    );
  }
}
