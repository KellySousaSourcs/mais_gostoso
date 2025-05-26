import 'package:mais_gostoso/screens/cart_model.dart';
import 'package:mais_gostoso/screens/menu_item_model.dart';
import 'package:flutter/material.dart';
import 'package:mais_gostoso/screens/models/favorites_model.dart';
import 'package:mais_gostoso/services/auth_service.dart';

class ItemDescriptionScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const ItemDescriptionScreen({super.key, required this.item});

  @override
  State<ItemDescriptionScreen> createState() => _ItemDescriptionScreenState();
}

class _ItemDescriptionScreenState extends State<ItemDescriptionScreen> {
  final FavoritesModel _favoritesModel = FavoritesModel();
  int quantity = 1;
  String observation = '';

  @override
  void initState() {
    super.initState();
    _favoritesModel.loadFavorites();
    _favoritesModel.addListener(_updateFavoriteState);
  }

  void _updateFavoriteState() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _favoritesModel.removeListener(_updateFavoriteState);
    super.dispose();
  }

  void _addToCart(BuildContext context) {
    final menuItem = MenuItem(
      name: widget.item['name'] ?? '',
      desc: widget.item['desc'] ?? '',
      weight: widget.item['weight'] ?? '',
      image: widget.item['image'] ?? '',
      price: double.parse((widget.item['price'] ?? '0').replaceAll(',', '.')),
      quantity: quantity,
      observation: observation,
    );

    // Adiciona ao carrinho global
    CartModel().addItem(menuItem);

    // Volta para tela anterior
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final price = widget.item['price'] ?? 0.0;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(bottom: 232),
              child: Transform.scale(
                scale: 3,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.item['image']),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      colorFilter: ColorFilter.mode(
                        Color(0xFFF4FFF1).withOpacity(0.3),
                        BlendMode.srcOver,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 230),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(19),
                  decoration: BoxDecoration(
                    color: Color(0xFFF4EEE1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Positioned(
                        bottom: 220,
                        right: 9,
                        left: 9,
                        child: Container(
                          width: 340,
                          height: 270,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.asset(
                              widget.item['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 17),
                      Text(widget.item['desc'] ?? ''),
                      Text(
                        'Serve até ${widget.item['serves'] ?? '1'} pessoas (${widget.item['weight'] ?? '0g'})',
                      ),
                      SizedBox(height: 20),
                      Text(
                        'R\$ ${double.parse(price.replaceAll(',', '.')).toStringAsFixed(2)}',
                      ),
                      SizedBox(height: 20),
                      TextField(
                        onChanged: (value) => observation = value,
                        decoration: InputDecoration(
                          labelText: 'Alguma observação?',
                          hintText: 'Ex: tirar queijo, tenho lactose',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed:
                                    () => setState(() {
                                      quantity =
                                          quantity > 1 ? quantity - 1 : 1;
                                    }),
                              ),
                              Text('$quantity', style: TextStyle(fontSize: 18)),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () => setState(() => quantity++),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final isLoggedIn =
                                  await AuthService.checkSession().then(
                                    (session) => session['success'] == true,
                                  );

                              if (isLoggedIn) {
                                _addToCart(context);
                              } else {
                                final result = await Navigator.pushNamed(
                                  context,
                                  '/login',
                                  arguments: {
                                    'returnRoute': '/item-description',
                                    'item': widget.item,
                                    'quantity': quantity,
                                    'observation': observation,
                                  },
                                );

                                if (result == true && mounted) {
                                  _addToCart(context);
                                }
                              }
                            },
                            child: Text(
                              'Adicionar R\$ ${(double.parse(price.toString().replaceAll(',', '.')) * quantity).toStringAsFixed(2)}',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/pratoprincipal.jpeg',
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 48,
                  left: 16,
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Color(0xFFF4FFFF),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF252810).withOpacity(0.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Color(0xFF252810),
                        size: 19,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                Positioned(
                  top: 48,
                  right: 16,
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Color(0xFFF4FFFF),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF252810).withOpacity(0.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color:
                            _favoritesModel.isFavorite(widget.item['name'])
                                ? Colors.red
                                : Color(0xFF757575),
                        size: 19,
                      ),
                      onPressed: () async {
                        await _favoritesModel.toggleFavorite(widget.item);
                        final isNowFavorite = _favoritesModel.isFavorite(
                          widget.item['name'] ?? '',
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isNowFavorite
                                    ? '${widget.item['name']} adicionado aos favoritos!'
                                    : '${widget.item['name']} removido dos favoritos!',
                              ),
                              action: SnackBarAction(
                                textColor: Color(0xFFEDDD1D),
                                label: 'Fechar',
                                onPressed: () {},
                              ),
                              backgroundColor: const Color(0xFF252810),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 121,
            bottom: 54,
            left: 50,
            right: 50,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: 300,
                  height: 100,
                  margin: const EdgeInsets.only(bottom: 1),
                  padding: const EdgeInsets.only(
                    top: 50,
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
                        const SizedBox(height: 1),
                        Text(
                          widget.item['name'] ?? '',
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
                Positioned(
                  top: -41.8,
                  child: Container(
                    width: 78,
                    height: 78,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFFFFFF),
                    ),
                    padding: const EdgeInsets.all(1),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/facemaisGostoso.png',
                        height: 78,
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
    );
  }
}
