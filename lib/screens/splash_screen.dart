import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Alignment> _imageAnimation;
  late final Animation<Alignment> _textAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _imageAnimation = AlignmentTween(
      begin: Alignment(0, -2),
      end: const Alignment(0, -0.2),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _textAnimation = AlignmentTween(
      begin: Alignment(0, 2),
      end: const Alignment(0, 0.1),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // começa a animação
    _controller.forward();

    //vá para a próxima tela depois de um tempo de 3 segundos
    Future.delayed(const Duration(seconds: 3), () async {
      await Future.delayed(const Duration(seconds: 3));
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('is_logged_in') ?? false;

      if(!mounted) {
        return;
      }

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDDD1D),
      body: Stack(
        children: [
          // vai ser adicionado o rosto da moça da logo aqui
          AnimatedBuilder(
            animation: _imageAnimation,
            builder: (context, child) {
              return Align(
                alignment: _imageAnimation.value,
                child: Image.asset(
                  'assets/images/facemaisGostoso.png',
                  height: 150,
                ),
              );
            },
          ),

          AnimatedBuilder(
            animation: _textAnimation,
            builder: (context, child) {
              return Align(
                alignment: _textAnimation.value,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/maisostosoName.png',
                    height: 150,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
