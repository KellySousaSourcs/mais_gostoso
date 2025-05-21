import 'package:mais_gostoso/screens/home_screen.dart';
import 'package:mais_gostoso/screens/pagamento_screen.dart';
import 'package:mais_gostoso/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MaisGostoso());
}

class MaisGostoso extends StatelessWidget {
  const MaisGostoso({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '+Gostoso App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lime),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(initialIndex: 0),
        '/pedidos': (context) => const HomeScreen(initialIndex: 2),
        '/pagamento': (context) => const PagamentoScreen(),
        // futuramente: '/pagamento/pix': ..., '/pagamento/cartao': ...
      },
    );
  }
}
