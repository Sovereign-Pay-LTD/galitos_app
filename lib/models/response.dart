class Response {
  String? messageType;
  String? transactionType;
  String? tellerId;
  String? tellerName;
  String? referenceNo;
  String? dateTime;
  String? invoiceNo;
  String? tenderType;
  String? currency;
  String? currencySymbol;
  String? transactionAmount;
  String? cashBackAmount;
  String? narration;
  String responseCode;
  String responseText;
  String? pan;
  String? authorizationCode;
  String? authorizationReference;
  String? account1;
  String? account2;
  String? echoData;
  String? receiptData;

  Response({
    this.messageType,
    this.transactionType,
    this.tellerId,
    this.tellerName,
    this.referenceNo,
    this.dateTime,
    this.invoiceNo,
    this.tenderType,
    this.currency,
    this.currencySymbol,
    this.transactionAmount,
    this.cashBackAmount,
    this.narration,
    required this.responseCode,
    required this.responseText,
    this.pan,
    this.authorizationCode,
    this.authorizationReference,
    this.account1,
    this.account2,
    this.echoData,
    this.receiptData,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
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
        responseCode: json["ResponseCode"],
        responseText: json["ResponseText"],
        pan: json["PAN"],
        authorizationCode: json["AuthorizationCode"],
        authorizationReference: json["AuthorizationReference"],
        account1: json["Account1"],
        account2: json["Account2"],
        echoData: json["EchoData"],
        receiptData: json["ReceiptData"],
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
        "ResponseCode": responseCode,
        "ResponseText": responseText,
        "Pan": pan,
        "AuthorizationCode": authorizationCode,
        "AuthorizationReference": authorizationReference,
        "Account1": account1,
        "Account2": account2,
        "EchoData": echoData,
        "ReceiptData": receiptData,
      };
}
