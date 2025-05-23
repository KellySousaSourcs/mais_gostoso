import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final AnimationController _fadeController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    super.initState();

    // Controladores para animações combinadas
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Configurações das animações
    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.elasticOut,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.easeInOutCubic,
      ),
    );

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.easeOutBack,
      ),
    );

    // Inicia as animações
    Future.delayed(const Duration(milliseconds: 300), () {
      _scaleController.forward();
      _fadeController.forward();
    });

    // Navega direto para home após animações completas
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFEDDD1D),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Tamanhos responsivos
          final logoSize = screenHeight * 0.3;
          final textSize = screenWidth * 0.4;
          final spacing = screenHeight * 0.02;

          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo com animações
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SizedBox(
                        height: logoSize.clamp(150, 300),
                        width: logoSize.clamp(150, 300),
                        child: Image.asset(
                          'assets/images/facemaisGostoso.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: spacing),

                  // Texto com animações
                  SlideTransition(
                    position: _textSlideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SizedBox(
                        width: textSize.clamp(200, 400),
                        child: Image.asset(
                          'assets/images/maisostosoName.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}