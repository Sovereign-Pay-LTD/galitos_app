import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:myshop_app/res/app_drawables.dart';
import 'package:myshop_app/res/app_strings.dart';
import '../models/countryData.dart';
import '../models/flowData.dart';
import 'package:sunmi_printer_plus/column_maker.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

import 'country_currency_Manager.dart';

class PrintingService extends ChangeNotifier {
  bool printBinded = false;
  int paperSize = 0;
  String serialNumber = "";
  String printerVersion = "";

  PrintingService() {
    loadInit();
  }

  loadInit() async {
    await initiatePrinter();
  }

  initiatePrinter() {
    _bindingPrinter().then((bool? isBind) async {
      SunmiPrinter.paperSize().then((int size) {
        paperSize = size;
      });

      SunmiPrinter.printerVersion().then((String version) {
        printerVersion = version;
      });

      SunmiPrinter.serialNumber().then((String serial) {
        serialNumber = serial;
      });

      printBinded = isBind!;
    });
  }

  /// must binding ur printer at first init in app
  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result;
  }

  Future<Uint8List> readFileBytes(String path) async {
    ByteData fileData = await rootBundle.load(path);
    Uint8List fileUnit8List = fileData.buffer
        .asUint8List(fileData.offsetInBytes, fileData.lengthInBytes);
    return fileUnit8List;
  }

  Future<Uint8List> _getImageFromAsset(String iconPath) async {
    return await readFileBytes(iconPath);
  }

  printReceipt({required BuildContext context, required FlowData data,required Map<String, dynamic> apiResponse}) async {
    CountryData activeCurrency = CountryManager().activeCountry;

    try {
      // Receipt Header
      if (!printBinded) {
        await initiatePrinter();
      }

      await SunmiPrinter.initPrinter();
      // 2. Start transaction once
      await SunmiPrinter.startTransactionPrint(true);
      await SunmiPrinter.lineWrap(1);
      Uint8List byte = await _getImageFromAsset(AppDrawables.printLogo);
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
      await SunmiPrinter.printImage(byte);
      await SunmiPrinter.lineWrap(1);
      await SunmiPrinter.printText(AppStrings.transactionReceipts);
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
      await SunmiPrinter.setCustomFontSize(28);
      await SunmiPrinter.line(len: 48);
      await SunmiPrinter.printText(
          "${AppStrings.transactionID}:${data.transactionID}");
      await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);
      await SunmiPrinter.setCustomFontSize(28);
      await SunmiPrinter.printText(
          "${AppStrings.referenceNum}");
      await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);
      await SunmiPrinter.setCustomFontSize(28);
      await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);
      await SunmiPrinter.setCustomFontSize(28);
      await SunmiPrinter.printText(AppStrings.orderNo);
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
      await SunmiPrinter.setCustomFontSize(60); // SET CUSTOM FONT 12
      await SunmiPrinter.printText('${data.receiptNum}');
      await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);
      await SunmiPrinter.resetFontSize();
      await SunmiPrinter.printText(
        "${AppStrings.time}:${DateFormat("dd-MMM-yyyy  h:mm a").format(DateTime.now())}",
      );

      await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);
      await SunmiPrinter.setCustomFontSize(28);
      await SunmiPrinter.printText(
          // ignore: prefer_interpolation_to_compose_strings
          "${AppStrings.payment}:"
          '${data.paymentData?.name}');

      if (data.tenderType == "01") {
        await SunmiPrinter.printText(
          // ignore: prefer_interpolation_to_compose_strings
            "${AppStrings.card} ${AppStrings.number}:"
                '${data.paymentData?.name}'
                "${apiResponse['PAN']??'12345678908764'.substring(0, 4)} **** **** ${apiResponse['PAN']??'12345678908764'.substring(apiResponse['PAN']??'12345678908764'.length - 4)}"
        );
      }

      if (data.tenderType == "02") {
        await SunmiPrinter.printText(
          // ignore: prefer_interpolation_to_compose_strings
            "${AppStrings.mobile} ${AppStrings.number}:" '${apiResponse['PAN']??'0542134356'}');

      }
      await SunmiPrinter.line(len: 48);
      await SunmiPrinter.printRow(cols: [
        ColumnMaker(text: AppStrings.name, width: 27, align: SunmiPrintAlign.LEFT),
        ColumnMaker(text: AppStrings.number, width: 6, align: SunmiPrintAlign.CENTER),
        ColumnMaker(
            text: "${AppStrings.amount}(${activeCurrency.symbol})",
            width: 14,
            align: SunmiPrintAlign.RIGHT),
      ]);
      for (var i = 0; i < data.cart.length; i++) {
        await SunmiPrinter.printRow(cols: [
          ColumnMaker(
              text: data.cart[i].name!,
              width: 27,
              align: SunmiPrintAlign.LEFT),
          ColumnMaker(
              text: data.cart[i].qty.toString(),
              width: 6,
              align: SunmiPrintAlign.CENTER),
          ColumnMaker(
              // ignore: prefer_interpolation_to_compose_strings, unrelated_type_equality_checks
              text: activeCurrency.dp == 2
                  ? data.cart[i].totalAmount!.toStringAsFixed(2)
                  : data.cart[i].totalAmount.toString(),
              width: 14,
              align: SunmiPrintAlign.RIGHT),
        ]);
      }
      await SunmiPrinter.line(len: 48);
      await SunmiPrinter.printRow(
        cols: [
          ColumnMaker(text: AppStrings.total, width: 23, align: SunmiPrintAlign.LEFT),
          ColumnMaker(
              // ignore: unrelated_type_equality_checks
              text: activeCurrency.dp == 2
                  ? data.cartTotalAmount.toStringAsFixed(2)
                  : data.cartTotalAmount.toString(),
              width: 24,
              align: SunmiPrintAlign.RIGHT),
        ],
      );
      await SunmiPrinter.printRow(
        cols: [
          ColumnMaker(
              text: "${AppStrings.paidIn} ", width: 23, align: SunmiPrintAlign.LEFT),
          ColumnMaker(
              // ignore: unrelated_type_equality_checks
              text: activeCurrency.dp == 2 ? '0.01' : '0',
              width: 24,
              align: SunmiPrintAlign.RIGHT),
        ],
      );
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
      await SunmiPrinter.line(len: 48);
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
      await SunmiPrinter.printText(
          AppStrings.demoNote);

      /// Receipt Footer

      await SunmiPrinter.lineWrap(1);
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
      await SunmiPrinter.printQRCode("${AppStrings.orderNo}${data.cartTotalAmount}");
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
      await SunmiPrinter.lineWrap(1);
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER); // Center align
      await SunmiPrinter.printText(AppStrings.thankYouForChoosingMyShop);
      await SunmiPrinter.lineWrap(1);
      await SunmiPrinter.exitTransactionPrint(true);
      await SunmiPrinter.cut();

      return true;
    } catch (e) {
      //print("Cannot Print. An Error Occured!");
      return false;
    }
  }
}
