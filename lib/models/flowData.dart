import 'dart:convert';
import 'package:myshop_app/models/countryData.dart';
import 'package:myshop_app/models/productCategory.dart';
import 'paymentTypeData.dart';


FlowData flowDataFromJson(String str) => FlowData.fromJson(json.decode(str));
String flowDataToJson(FlowData data) => json.encode(data.toJson());

class FlowData {
  double cartTotalAmount;
  List<Item> cart;
  String? transactionID;
  String? date;
  String? tenderType;
  String? receiptNum;
  PaymentData? paymentData;
  CountryData? countryData;


  FlowData({
    required this.cartTotalAmount,
    required this.cart,
    this.transactionID,
    this.date,
    this.tenderType,
    this.receiptNum,
    this.paymentData,
    this.countryData

  });

  FlowData copyWith({
    double? cartTotalAmount,
    List<Item>? cart,
    String? transactionID,
    String? date,
    String? tenderType,
    String? receiptNum,
    PaymentData? paymentData,
    CountryData? countryData,

  }) {
    return FlowData(
      cartTotalAmount: cartTotalAmount ?? this.cartTotalAmount,
      cart: cart ?? this.cart,
      transactionID: transactionID ?? this.transactionID,
      date: date ?? this.date,
      tenderType: tenderType ?? this.tenderType,
      receiptNum: receiptNum ?? this.receiptNum,
      paymentData: paymentData ?? this.paymentData,
      countryData: countryData ?? this.countryData,
    );
  }

  factory FlowData.fromJson(Map<String, dynamic> json) {
    return FlowData(
      cartTotalAmount: (json["cartTotalAmount"] ?? 0).toDouble(),
      cart: (json["cart"] as List<dynamic>?)
          ?.map((x) => Item.fromJson(x))
          .toList() ??
          [],
      transactionID: json["transactionID"],
      date: json["date"],
      tenderType: json["tenderType"],
      receiptNum: json["receiptNum"],

      paymentData: json["paymentData"] != null
          ? PaymentData.fromJson(json["paymentData"])
          : null,
      countryData: json["countryData"] != null
          ? CountryData.fromJson(json["countryData"])
          : null,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      "cartTotalAmount": cartTotalAmount,
      "cart": cart.map((x) => x.toJson()).toList(),
      "transactionID": transactionID,
      "date": date,
      "tenderType": tenderType,
      "receiptNum": receiptNum,
      "paymentData": paymentData?.toJson(),
    };
  }
}
