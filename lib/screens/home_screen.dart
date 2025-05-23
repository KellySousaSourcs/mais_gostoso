import 'package:mais_gostoso/data/quantidade_itens_home.dart';
import 'package:mais_gostoso/screens/cart_model.dart';
import 'package:mais_gostoso/screens/categoria_screen.dart';
import 'package:mais_gostoso/screens/navigation_bar_screens/perfil_screen.dart';
import 'package:mais_gostoso/screens/pedidos_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required int initialIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      _buildHomeContent(),
      const PedidoScreen(),
      const PerfilScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final cartItems = CartModel().items;
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildHomeContent() {
    return Container(
      color: const Color(0xFFEDDD1D),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 2),
          Expanded(child: _buildCategoryList()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        Container(
          height: 130,
          decoration: const BoxDecoration(
            color: Color(0xFFEDDD1D),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
        Positioned(
          top: 20,
          left: 0,
          right: 0,
          child: Center(
            child: Image.asset('assets/images/hatchef.png', height: 110),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryList() {
    final categorias = [
      {'title': 'Refeições', 'image': 'assets/images/refeicao.png'},
      {'title': 'Lanches', 'image': 'assets/images/lanches.png'},
      {'title': 'Sobremesas', 'image': 'assets/images/sobremesas.png'},
      {'title': 'Bebidas', 'image': 'assets/images/bebidas.png'},
      {'title': 'Vegetariano', 'image': 'assets/images/vegetariano.png'},
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF4EEE1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 5, bottom: 10),
        itemCount: categorias.length,
        itemBuilder: (context, index) {
          final category = categorias[index];
          return Stack(
            children: [
              Center(
                child: Container(
                  width: 306,
                  height: 121,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 15,
                  ),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(23),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 1,
                        color: const Color(0xFF757575).withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(3, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 52),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category['title']!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'COOPBL',
                                letterSpacing: 3,
                                color: Color(0xFF252810),
                              ),
                            ),
                            Text(
                              "${quantidadePorCategoria[category['title']] ?? 0} itens",
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13,
                                color: Color(0xFF252810),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 3,
                top: 20,
                child: Image.asset(category['image']!, height: 109, width: 109),
              ),
              Positioned(
                right: 32,
                top: 53,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF757575).withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: const Color(0xFF252810),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Color(0xFFEDDD1D),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => CategoryItemsScreen(
                                  categoryTitle: category['title']!,
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBottomBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Pedidos',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
      ],
      selectedItemColor: const Color(0xFF252810),
      unselectedItemColor: const Color(0xFF757575),
      backgroundColor: const Color(0xFFFFFFFF),
      type: BottomNavigationBarType.fixed,
    );
  }
}
