import 'package:flutter/material.dart';
import 'package:mais_gostoso/screens/models/favorites_model.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FavoritesModel _favoritesModel = FavoritesModel();

  @override
  void initState() {
    super.initState();
    _favoritesModel.loadFavorites();
    _favoritesModel.addListener(_updateState);
  }

  @override
  void dispose() {
    _favoritesModel.removeListener(_updateState);
    super.dispose();
  }

  void _updateState() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF252810),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: const Color(0xFFEDDD1D),
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4FFFF),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF252810).withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF252810),
                        size: 19,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    'Meus Favoritos',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Nunito-Medium',
                      color: Color(0xFF252810),
                    ),
                  ),
                ],
              ),
            ),

            // Lista de favoritos
            Expanded(
              child: Container(
                color: const Color(0xFFF4EEE1),
                child: _favoritesModel.favorites.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite_border,
                              size: 80,
                              color: Color(0xFF757575),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Nenhum item favoritado ainda',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF757575),
                                fontFamily: 'Nunito-Medium',
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Adicione seus pratos favoritos aqui!',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF999999),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _favoritesModel.favorites.length,
                        itemBuilder: (context, index) {
                          final item = _favoritesModel.favorites[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  item.image,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color(0xFFF4EEE1),
                                      ),
                                      child: const Icon(
                                        Icons.image_not_supported,
                                        color: Color(0xFF757575),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              title: Text(
                                item.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Nunito-Medium',
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Text(
                                    item.desc,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFFFFFFFF),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'R\$ ${item.price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF252810),
                                    ),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  _favoritesModel.removeFavorite(item.name);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${item.name} removido dos favoritos', style: TextStyle(color: Color(0xFFF4FFF1)),),
                                      backgroundColor: const Color(0xFF2870),
                                      duration: const Duration(seconds: 2),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                              ),
                              onTap: () {
                                // Navegar para detalhes do item
                                Navigator.pushNamed(
                                  context,
                                  '/item-description',
                                  arguments: {
                                    'name': item.name,
                                    'desc': item.desc,
                                    'weight': item.weight,
                                    'image': item.image,
                                    'price': item.price.toString(),
                                    'serves': item.serves,
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}