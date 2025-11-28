part of "bloc.dart";

sealed class ProgressEvent {}
final class  ProgressSubmitEvent extends ProgressEvent {}
final class  ProgressSetPaymentDataEvent extends ProgressEvent {
  final PaymentData data;

  ProgressSetPaymentDataEvent({required this.data});
}
final class  ProgressGoBackEvent extends ProgressEvent {}
