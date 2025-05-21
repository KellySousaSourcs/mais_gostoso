import 'package:mais_gostoso/screens/cart_model.dart';
import 'package:mais_gostoso/screens/menu_item_model.dart';
import 'package:flutter/material.dart';

class ItemDescriptionScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const ItemDescriptionScreen({super.key, required this.item});

  @override
  State<ItemDescriptionScreen> createState() => _ItemDescriptionScreenState();
}

class _ItemDescriptionScreenState extends State<ItemDescriptionScreen> {
  int quantity = 1;
  String observation = '';

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
            child: Container(
              padding: EdgeInsets.only(bottom: 232),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.item['image']),

                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Color(0xFFF4FFF1).withOpacity(0.3),
                    BlendMode.srcOver,
                  ),
                ),
              ),
            ),
          ),

          SingleChildScrollView(
            child: Column(
              children: [
                // Espaço adicional para o card sobreposto
                SizedBox(height: 235), // Ajuste conforme necessário
                // Container principal com conteúdo
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
                      // Imagem sobreposta
                      Positioned(
                        bottom: 230, // Ajuste a posição vertical
                        right: 9,
                        left: 9, // Ajuste a posição horizontal
                        child: Container(
                          width: 340, // Largura da imagem
                          height: 270, // Altura da imagem
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ), // Bordas arredondadas
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.asset(
                              widget
                                  .item['image'], // Caminho da sua imagem sobreposta
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
                        decoration: InputDecoration(
                          labelText: 'Alguma observação?',
                          hintText: 'Ex: tirar queijo, tenho lactose',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      SizedBox(height: 75),
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
                            onPressed:
                                () => _addToCart(
                                  context,
                                ), // Alterado para chamar o método diretamente
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

          // Imagem de cabeçalho fixa (não rola com o conteúdo)
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
                      color: Color(0xFFF4FFFF), // Cor do círculo (branco)
                      shape: BoxShape.circle, // Forma circular
                      boxShadow: [
                        BoxShadow(
                          color: Color(
                            0xFF252810,
                          ).withOpacity(0.1), // Sombra suave (opcional)
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
                      color: Color(0xFFF4FFFF), // Cor do círculo (branco)
                      shape: BoxShape.circle, // Forma circular
                      boxShadow: [
                        BoxShadow(
                          color: Color(
                            0xFF252810,
                          ).withOpacity(0.1), // Sombra suave (opcional)
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        color: Color(0xFF252810),
                        size: 19,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Container branco com o título da categoria que está sobreposto
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

                // IMAGEM dentro de círculo branco acima do container
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
