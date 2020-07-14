

class Products {
  String itemName;
  double itemPrice;
  String itemImage;
  double itemRating;

  Products.items({this.itemName, this.itemPrice, this.itemImage, this.itemRating});
}

List<Products> productsItems = [
  Products.items(
      itemName: "Brita",
      itemPrice: 35.00,
      itemImage: "assets/p2.png",
      itemRating: 5.0),
  Products.items(
      itemName: "Bottles",
      itemPrice: 10.00,
      itemImage: "assets/p4.png",
      itemRating: 4.5),
  Products.items(
      itemName: "Filters",
      itemPrice: 10.00,
      itemImage: "assets/p3.png",
      itemRating: 4.7),
  Products.items(
      itemName: "Brita",
      itemPrice: 35.00,
      itemImage: "assets/p2.png",
      itemRating: 5.0),
  Products.items(
      itemName: "Bottles",
      itemPrice: 10.00,
      itemImage: "assets/p4.png",
      itemRating: 4.5),
  Products.items(
      itemName: "Filters",
      itemPrice: 10.00,
      itemImage: "assets/p3.png",
      itemRating: 4.7),
  
];