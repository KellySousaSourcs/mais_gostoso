class MenuItem {
  final String name;
  final String desc;
  final String weight;
  final String image;
  final double price;
  final int quantity;
  final String observation;

  MenuItem({
    required this.name,
    required this.desc,
    required this.weight,
    required this.image,
    required this.price,
    this.quantity = 1,
    this.observation = '',
  });

  double get totalPrice => price * quantity;
}
