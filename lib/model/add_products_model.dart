class AddProducts {
  final String productName;
  final num productPrice;
  final num quantity;
  final String description;

  AddProducts(
      {required this.productName,
      required this.description,
      required this.productPrice,
      required this.quantity});
}

List<AddProducts> addproducts = [];
