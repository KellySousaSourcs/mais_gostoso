import 'package:mais_gostoso/data/menu_items.dart';
import 'package:mais_gostoso/screens/item_descripition_screen.dart';
import 'package:flutter/material.dart';

class CategoryItemsScreen extends StatelessWidget {
  final String categoryTitle;

  const CategoryItemsScreen({super.key, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    final items = allMenuItems[categoryTitle] ?? [];

    return Scaffold(
      body: Column(
        children: [
          // Topo com imagem + overlay + botão de voltar + título
          Stack(
            children: [
              SizedBox(
                height: 187,
                width: double.infinity,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    // Imagem de fundo do topo que esta atrás, prato
                    Image.asset(
                      'assets/images/pratoprincipal.jpeg',
                      fit: BoxFit.cover,
                      width: 422,
                      height: 189,
                    ),

                    // Camada amarela com opacidade bem fraquinha
                    Container(
                      height: 187,
                      color: const Color(0xFFECDD1D).withOpacity(0.1),
                    ),

                    // Botão de voltar para a tela home
                    Positioned(
                      top: 48,
                      left: 16,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF757575).withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 18,
                            backgroundColor: Color(0xFFFFFFFF),
                            child: Icon(
                              Icons.arrow_back_outlined,
                              color: Color(0xFF252810),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Container branco com o título da categoria que está sobreposto
                    Positioned(
                      bottom: -51.9,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            width: 301,
                            height: 107,
                            margin: const EdgeInsets.only(bottom: 1),
                            padding: const EdgeInsets.only(
                              top: 50, // espaço para o círculo da imagem
                              left: 24,
                              right: 24,
                              bottom: 20,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0XFFFFFFFF),
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Color(0xFF757575).withOpacity(0.3),
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 12),
                                  Text(
                                    categoryTitle,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Nunito-Medium',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // IMAGEM dentro de círculo branco acima do container
                          Positioned(
                            top: -41.8,
                            child: Container(
                              width: 85,
                              height: 85,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(1),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/facemaisGostoso.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 58),

          // Lista dos itens
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 14),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4EEE1),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF757575).withOpacity(0.5),
                        blurRadius: 8,
                        spreadRadius: 0.2,
                        offset: Offset(2, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Imagem do item
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          item['image']!,
                          height: 100,
                          width: 102,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Texto do item
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF252810),
                              ),
                            ),
                            Text(
                              item['desc']!,
                              style: const TextStyle(fontSize: 13),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['weight']!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF757575),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Botão de adicionar
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        child: IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => ItemDescriptionScreen(
                                      item: item as Map<String, dynamic>,
                                    ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
