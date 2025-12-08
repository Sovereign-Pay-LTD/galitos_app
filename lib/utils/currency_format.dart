import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Currency {
  /// Amount formatter. Returns amount with divisions (1500 => 1,500)
  String formatAmount(double amount, BuildContext context) {
    String result = amount.toStringAsFixed(2);
    return result.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},");
  }

  String format({required String decimal, required double rate, required double amount}) {
    try {
      double newAmount = rate * amount;
      NumberFormat currencyFormat;

      // Choose the correct format based on the decimal value
      if (decimal == '2') {
        currencyFormat = NumberFormat(" #,##0.00");
      } else if (decimal == '0') {
        currencyFormat = NumberFormat(" #,###");
      } else {
        currencyFormat = NumberFormat(" #,##0.0");
      }

      if (newAmount == 0) {
        // Return appropriately formatted zero value
        return decimal == '0'
            ? "0"
            : decimal == '2'
                ? "0.00"
                : "0.0";
      }

      // Return formatted result
      return currencyFormat.format(newAmount);
    } catch (e) {
      // Return default zero value in case of any errors
      return decimal == '0'
          ? "0"
          : decimal == '2'
              ? "0.00"
              : "0.0";
    }
  }



  //       String formattedAmount = currencyFormat.format(newAmount);

  //       return formattedAmount;
  //     } catch (e) {
  //       return "0.0";
  //     }
  //   }
  // }
}
