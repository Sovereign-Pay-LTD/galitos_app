import "dart:math";
import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:intl/intl.dart";
import "../models/productCategory.dart";





class AppUtil {

  static late BuildContext homeScaffoldContext;

  AppUtil._();
  static  bool isSameItem(Item a, Item b) {
    return a.name == b.name && (a.image ) == (b.image );
  }
  static void toastMessage({
    required String message,
  }) => Fluttertoast.showToast(
      msg: message, toastLength: Toast.LENGTH_LONG
  );

  static String genRandCode({required int length, bool noZero = false,}) {
    String result = "", chars = noZero ? "123456789" : "0123456789";
    for(int a = 0;a < length;a++) {
      result += chars[ Random().nextInt(chars.length - 0) ];
    }
    return result;
  }

  static String parseDateTime2(DateTime date) =>
      DateFormat("yyyyMMddHHmmss").format(date);

  static  String getTransactionID(String transactionDate) {
    // Constants
    const String dateFormat = "yyyyMMddHHmmss";
    const int idLength = 12;
    const String alphabet = "0123456789";

    String uniqueTxnID = "";
    DateTime txnDateTime;

    // Parse the transactionDate or use the current date and time if parsing fails
    try {
      txnDateTime = DateFormat(dateFormat).parse(transactionDate);
    } catch (e) {
      txnDateTime = DateTime.now();
    }

    // Generate the unique ID in the format ydddHHmmss01
    int year = txnDateTime.year % 10;
    String dayOfYear = txnDateTime
        .difference(DateTime(txnDateTime.year))
        .inDays
        .toString()
        .padLeft(3, '0');
    String hour = txnDateTime.hour.toString().padLeft(2, '0');
    String minute = txnDateTime.minute.toString().padLeft(2, '0');
    String second = txnDateTime.second.toString().padLeft(2, '0');

    uniqueTxnID = "$year$dayOfYear$hour$minute$second";

    // Add random digits to make the ID 12 characters long
    Random random = Random();
    while (uniqueTxnID.length < idLength) {
      uniqueTxnID += alphabet[random.nextInt(alphabet.length)];
    }

    return uniqueTxnID;
  }

  static String getCurrentFormattedDateTime() {
    DateTime now = DateTime.now();
    String formattedDate = "${now.year}"
        "${now.month.toString().padLeft(2, '0')}"
        "${now.day.toString().padLeft(2, '0')}"
        "${now.hour.toString().padLeft(2, '0')}"
        "${now.minute.toString().padLeft(2, '0')}"
        "${now.second.toString().padLeft(2, '0')}";

    return formattedDate;
  }

  static String formatCardNumber(String? cardNumber) {
    if (cardNumber == null || cardNumber.isEmpty) return "**** **** **** ****";
    if (cardNumber.length <= 8) return cardNumber; // Too short to mask

    String first4 = cardNumber.substring(0, 4);
    String last4 = cardNumber.substring(cardNumber.length - 4);
    return "$first4 **** **** $last4";
  }



}
