class GroceryItem {
  final String name;
  final int quantity;

  GroceryItem({required this.name, required this.quantity});

  GroceryItem.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        quantity = json['quantity'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
    };
  }
}
