class Product {
  int? ID;
  String pname;
  int pqty;
  int price;
  String condition;
  Product(
      {required this.ID,
      required this.pname,
      required this.pqty,
      required this.price,
      required this.condition});
}

class products {
  static List<Product> plist = [];
}
