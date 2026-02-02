

import 'dart:convert';

Request requestFromJson(String str) => Request.fromJson(json.decode(str));

String requestToJson(Request data) => json.encode(data.toJson());

class Request {
    String messageType;
    String transactionType;
    String tellerId;
    String tellerName;
    String referenceNo;
    String dateTime;
    String invoiceNo;
    String tenderType;
    String currency;
    String currencySymbol;
    String transactionAmount;
    String cashBackAmount;
    String narration;
    String account1;
    String account2;
    String echoData;
    String forcePost;

    Request({
        required this.messageType,
        required this.transactionType,
        required this.tellerId,
        required this.tellerName,
        required this.referenceNo,
        required this.dateTime,
        required this.invoiceNo,
        required this.tenderType,
        required this.currency,
        required this.currencySymbol,
        required this.transactionAmount,
        required this.cashBackAmount,
        required this.narration,
        required this.account1,
        required this.account2,
        required this.echoData,
         required this.forcePost,
    });

    factory Request.fromJson(Map<String, dynamic> json) => Request(
        messageType: json["MessageType"],
        transactionType: json["TransactionType"],
        tellerId: json["TellerID"],
        tellerName: json["TellerName"],
        referenceNo: json["ReferenceNo"],
        dateTime: json["DateTime"],
        invoiceNo: json["InvoiceNo"],
        tenderType: json["TenderType"],
        currency: json["Currency"],
        currencySymbol: json["CurrencySymbol"],
        transactionAmount: json["TransactionAmount"],
        cashBackAmount: json["CashBackAmount"],
        narration: json["Narration"],
        account1: json["Account1"],
        account2: json["Account2"],
        echoData: json["EchoData"],
         forcePost: json["forcePost"],
    );

    Map<String, dynamic> toJson() => {
        "MessageType": messageType,
        "TransactionType": transactionType,
        "TellerID": tellerId,
        "TellerName": tellerName,
        "ReferenceNo": referenceNo,
        "DateTime": dateTime,
        "InvoiceNo": invoiceNo,
        "TenderType": tenderType,
        "Currency": currency,
        "CurrencySymbol": currencySymbol,
        "TransactionAmount": transactionAmount,
        "CashBackAmount": cashBackAmount,
        "Narration": narration,
        "Account1": account1,
        "Account2": account2,
        "EchoData": echoData,
        "forcePost":forcePost
    };
}
