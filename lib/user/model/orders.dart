class Orders{
  final String pType;
  final String productCode;
  final String purchasedOn;
  final String warrantTill;

  Orders({
    this.pType,
    this.productCode,
    this.purchasedOn,
    this.warrantTill
  });
  
  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      pType: json['pType'],
      productCode: json['productCode'],
      purchasedOn: json['purchasedOn'],
      warrantTill: json['warrantTill']
    );
  }

  Map<String, dynamic> toMap() =>{
    "pType":pType,
    "productCode":productCode,
    "purchasedOn":purchasedOn,
    "warrantTill":warrantTill
  };
}

