// To parse this JSON data, do
//
//     final productCategoryData = productCategoryDataFromJson(jsonString);

import 'dart:convert';

ProductCategoryData productCategoryDataFromJson(String str) => ProductCategoryData.fromJson(json.decode(str));

String productCategoryDataToJson(ProductCategoryData data) => json.encode(data.toJson());

class ProductCategoryData {
  String? category;
  String? icon;
  List<Item>? items;

  ProductCategoryData({
    this.category,
    this.icon,
    this.items,
  });

  ProductCategoryData copyWith({
    String? category,
    String? icon,
    List<Item>? items,
  }) =>
      ProductCategoryData(
        category: category ?? this.category,
        icon: icon ?? this.icon,
        items: items ?? this.items,
      );

  factory ProductCategoryData.fromJson(Map<String, dynamic> json) => ProductCategoryData(
    category: json["category"],
    icon: json["icon"],
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "icon": icon,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Item {
  String? image;
  double? price;
  double? totalAmount;
  String? name;
  String? unit;
  int? qty;

  Item({
    this.image,
    this.price,
    this.totalAmount,
    this.name,
    this.unit,
    this.qty,
  });

  Item copyWith({
    String? image,
    double? price,
    double? totalAmount,
    String? name,
    String? unit,
    int? qty,
  }) =>
      Item(
        image: image ?? this.image,
        price: price ?? this.price,
        totalAmount: totalAmount ?? this.totalAmount,
        name: name ?? this.name,
        unit: unit ?? this.unit,
        qty: qty ?? this.qty,
      );

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    image: json["image"],
    price: json["price"]?.toDouble(),
    totalAmount: json["totalAmount"]?.toDouble(),
    name: json["name"],
    unit: json["unit"],
    qty: json["qty"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "price": price,
    "totalAmount": totalAmount,
    "name": name,
    "unit": unit,
    "qty": qty,
  };
}
