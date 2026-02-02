part of "bloc.dart";

sealed class HomeEvent {}



final class HomeOnExitEvent extends HomeEvent {
  final FlowData metaData;

  HomeOnExitEvent({required this.metaData});
}

final class HomeProgressEvent extends HomeEvent {
  final FlowData metaData;

  HomeProgressEvent({required this.metaData});
}

final class HomePaymentOptionEvent extends HomeEvent {
  final FlowData metaData;

  HomePaymentOptionEvent({required this.metaData});
}

final class HomeSetCurrencyAndCountryEvent extends HomeEvent {
  final String code;

  HomeSetCurrencyAndCountryEvent({required this.code});
}

final class HomeAddToCartEvent extends HomeEvent {
  final Item selectedProduct;


  HomeAddToCartEvent({required this.selectedProduct});
}
final class HomeRemoveEvent extends HomeEvent {
  final Item selectedProduct;


  HomeRemoveEvent({required this.selectedProduct});
}
final class HomeUpdateCartItemEvent extends HomeEvent {
  final Item selectedProduct;


  HomeUpdateCartItemEvent({required this.selectedProduct});
}
final class HomeEmptyCartEvent extends HomeEvent {

}

final class HomeLogoutEvent extends HomeEvent {}

final class HomeViewCartEvent extends HomeEvent {}

final class HomeBackEvent extends HomeEvent {}
