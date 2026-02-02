// To parse this JSON data, do
//
//     final PaymentData = PaymentDataFromJson(jsonString);

import 'dart:convert';

PaymentData paymentDataFromJson(String str) => PaymentData.fromJson(json.decode(str));

String paymentDataToJson(PaymentData data) => json.encode(data.toJson());

class PaymentData {
  String? name;
  String? image;
  String? tenderType;

  PaymentData({
    this.name,
    this.image,
    this.tenderType,
  });

  PaymentData copyWith({
    String? name,
    String? image,
    String? number,
  }) =>
      PaymentData(
        name: name ?? this.name,
        image: image ?? this.image,
        tenderType: tenderType ?? this.tenderType,
      );

  factory PaymentData.fromJson(Map<String, dynamic> json) => PaymentData(
    name: json["name"],
    image: json["image"],
    tenderType: json["tenderType"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "tenderType": tenderType,
  };
}
