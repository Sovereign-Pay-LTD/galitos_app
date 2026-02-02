import 'dart:convert';

TransactionData transactionDataFromJson(String str) =>
    TransactionData.fromJson(json.decode(str));

String transactionDataToJson(TransactionData data) =>
    json.encode(data.toJson());

class TransactionData {
  String? paymentType;
  String? receiptNum;
  String? invoiceNo;
  String? paymentCode;
  String? countryCode;
  String? currencySymbol;
  String? date;
  String? pan;
  String? authorizationCode;
  String? referenceNo;

  TransactionData({
    this.paymentType,
    this.receiptNum,
    this.invoiceNo,
    this.paymentCode,
    this.countryCode,
    this.currencySymbol,
    this.date,
    this.pan,
    this.authorizationCode,
    this.referenceNo,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) =>
      TransactionData(
        paymentType: json["PaymentType"],
        receiptNum: json["receiptNum"],
        invoiceNo: json["InvoiceNo"],
        paymentCode: json["PaymentCode"],
        countryCode: json["countryCode"],
        currencySymbol: json["currencySymbol"],
        date: json["Date"],
        pan: json["pan"],
        authorizationCode: json["AuthorizationCode"],
        referenceNo: json["ReferenceNo"],
      );

  Map<String, dynamic> toJson() => {
        "PaymentType": paymentType,
        "receiptNum": receiptNum,
        "InvoiceNo": invoiceNo,
        "PaymentCode": paymentCode,
        "countryCode": countryCode,
        "currencySymbol": currencySymbol,
        "Date": date,
        "pan": pan,
        "AuthorizationCode": authorizationCode,
        "ReferenceNo": referenceNo,
      };
}
