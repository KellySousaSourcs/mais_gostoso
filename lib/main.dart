import 'package:mais_gostoso/screens/favorites_screen.dart';
import 'package:mais_gostoso/screens/home_screen.dart';
import 'package:mais_gostoso/screens/item_descripition_screen.dart';
import 'package:mais_gostoso/screens/login_screen.dart';
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
      theme: ThemeData(snackBarTheme: SnackBarThemeData(
      backgroundColor: Color(0xFF252810),
      contentTextStyle: TextStyle(
        color: Color(0xFFF4FFF1),
        fontSize: 14,
      ),
    ),),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(initialIndex: 0),
        '/pedidos': (context) => const HomeScreen(initialIndex: 1),
        '/pagamento': (context) => const PagamentoScreen(),
        '/login': (context) => const LoginScreen(),
        '/favorites': (context) => const FavoritesScreen(),
        '/item-description': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return ItemDescriptionScreen(item: args,);
        }
        // futuramente: '/pagamento/pix': ..., '/pagamento/cartao': ...
      },
    );
  }
}
