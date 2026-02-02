part of "bloc.dart";

sealed class HomeState {}

final class HomeInitState extends HomeState {

}
final class HomeUpdatedCartState extends HomeState {

}


final class HomePaymentOption extends HomeState {
  final FlowData metaData;

  HomePaymentOption({required this.metaData});
}
final class HomeProgress extends HomeState {
  final FlowData metaData;

  HomeProgress({required this.metaData});
}

