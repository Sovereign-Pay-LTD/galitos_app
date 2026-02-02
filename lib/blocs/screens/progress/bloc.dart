import "dart:async";
import "dart:convert";
import "dart:io";
import "dart:math";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:http/http.dart" as http;
import "package:myshop_app/models/paymentTypeData.dart";
import "package:myshop_app/nav/app_navigator.dart";
import "../../../models/countryData.dart";
import "../../../models/flowData.dart";
import "../../../models/request.dart";
import "../../../res/app_strings.dart";
import "../../../res/app_theme.dart";
import "../../../services/app_Manager.dart";
import "../../../services/country_currency_Manager.dart";
import "../../../services/printing_service.dart";
import "../../../utils/sound.dart";

part "event.dart";
part "state.dart";

class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  String receiptId = "";
  bool busyState = false;
  late FlowData progressInfo;
  late BuildContext sectionContext;
  late void Function(FlowData? data) onExit;
  StreamSubscription<Map>? _controller;
  final printingService = PrintingService();

  ProgressBloc() : super(ProgressInitState()) {
    // ---------------- ProgressSubmitEvent ----------------
    on<ProgressSubmitEvent>((event, emit) async {
      busyState = false;
      String ipaddress = await AppManager().getIPAddress();
      bool isDebugMode = await AppManager().getDebug();
      CountryData activeCurrency = CountryManager().activeCountry;

      // Ensure paymentData is initialized
      progressInfo.paymentData ??= PaymentData();

      if (!isDebugMode) {
        busyState = true;
        try {
          Request requestBody = Request(
            messageType: "0200",
            transactionType: "00",
            tellerId: "11011011",
            tellerName: "Teller001",
            referenceNo: "${progressInfo.receiptNum}",
            dateTime: '${progressInfo.date}',
            invoiceNo: '${progressInfo.transactionID}',
            tenderType: progressInfo.paymentData!.tenderType ?? '',
            currency: '${activeCurrency.countryCode}',
            currencySymbol: '${activeCurrency.symbol}',
            transactionAmount:
            progressInfo.cartTotalAmount.toStringAsFixed(2),
            cashBackAmount: "0.00",
            narration: '',
            account1: '',
            account2: '',
            echoData: 'I move through air without wings',
            forcePost: '0',
          );

          final url = Uri.parse('http://$ipaddress:8080/v1/pay/');
         // print('API URL: $url');
          //print('Request Body: ${jsonEncode(requestBody)}');

          final response = await http
              .post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Accept': 'application/json',
            },
            body: jsonEncode(requestBody),
          )
              .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw TimeoutException(
                  'API request timed out after 30 seconds');
            },
          );

          busyState = false;
          if (response.statusCode == 200 || response.statusCode == 201) {
            var apiResponse = jsonDecode(response.body);
            print('Parsed API Response: $apiResponse');

            if (apiResponse["ResponseCode"] == "00") {

              emit(ProgressSuccessful());
              await SoundUtil.playTone();
              printingService.printReceipt(
                  context: sectionContext,
                  data: progressInfo,
                  apiResponse: apiResponse);
              AppNavigator.gotoHome(context: sectionContext);

            } else {
              emit(ProgressErrorState(
                  error: 'Transaction Failed: ${apiResponse["ResponseText"]}'));
              AppUtil.toastMessage(
                  message: 'Transaction Failed: ${apiResponse["ResponseText"]}');
            }
          } else {
            emit(ProgressErrorState(
                error: 'Transaction Failed: ${response.statusCode}'));
            AppUtil.toastMessage(
                message: 'Transaction Failed: ${response.statusCode}');
          }
        } on TimeoutException catch (e) {
          busyState = false;
          print('Timeout Error: $e');
          emit(ProgressErrorState(error: 'Request Timeout'));
          AppUtil.toastMessage(message: 'Connection timeout. Please try again.');
        } on SocketException catch (e) {
          busyState = false;
          print('Network Error: $e');
          emit(ProgressErrorState(error: 'Network Error'));
          AppUtil.toastMessage(message: 'No internet connection');
        } on FormatException catch (e) {
          busyState = false;
          print('JSON Parse Error: $e');
          emit(ProgressErrorState(error: 'Invalid Response Format'));
          AppUtil.toastMessage(message: 'Invalid server response');
        } catch (e, stackTrace) {
          busyState = false;
          print('Unexpected Error: $e');
          print('Stack Trace: $stackTrace');
          emit(ProgressErrorState(error: 'Transaction Failed: ${e.toString()}'));
          AppUtil.toastMessage(message: 'Transaction Failed');
        }
      } else {
        busyState = false;
        print('=== Debug Mode - Skipping API Call ===');
        await Future.delayed(const Duration(seconds: 5));
        emit(ProgressSuccessful());
        await SoundUtil.playTone();

        printingService.printReceipt(
            context: sectionContext,
            data: progressInfo,
            apiResponse: {});

      }
      AppNavigator.gotoHome(context: sectionContext);
    });

    // ---------------- ProgressSetPaymentDataEvent ----------------
    on<ProgressSetPaymentDataEvent>((event, emit) {
      // Ensure paymentData is always initialized
      progressInfo.paymentData ??= PaymentData();

      // Assign values
      progressInfo.paymentData!.name = event.data.name;
      progressInfo.paymentData!.tenderType = event.data.tenderType;



      progressInfo.date = AppUtil.getCurrentFormattedDateTime().toString();
      progressInfo.receiptNum = (1000 + Random().nextInt(9000)).toString();
      progressInfo.transactionID = AppUtil.getTransactionID(
        AppUtil.parseDateTime2(DateTime.now()),
      );

      print('Payment Data Set: ${progressInfo.paymentData!.toJson()}');
      add(ProgressSubmitEvent());
    });

    // ---------------- ProgressGoBackEvent ----------------
    on<ProgressGoBackEvent>((event, emit) {
      if (busyState) {
        AppUtil.toastMessage(message: AppStrings.processingPleaseWait);
        return;
      }
    });
  }

  void init({
    required BuildContext context,
    required FlowData input,
    StreamController<Map>? controller,
  }) {
    busyState = true;
    sectionContext = context;
    progressInfo = input;
    printingService.loadInit();
    if (controller != null) {
      _controller = controller.stream.asBroadcastStream().listen((event) {
        if (!sectionContext.mounted) return;
        for (String action in event.keys) {
          if (action == "go_back") {
            add(ProgressGoBackEvent());
          }
          if (action == "exit") {
            if (busyState) {
              return AppUtil.toastMessage(
                message: AppStrings.processingPleaseWait,
              );
            }
            Navigator.pop(sectionContext);
          }
        }
      });
    }
  }

  void dispose() {
    if (_controller != null) {
      _controller?.cancel();
    }
  }
}
