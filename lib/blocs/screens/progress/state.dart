part of "bloc.dart";

sealed class ProgressState {}
final class  ProgressInitState extends ProgressState {

  final bool isLoading;
  final String error;

  ProgressInitState({
    this.isLoading = true,
    this.error = "",
  });

}
final class  ProgressErrorState extends ProgressState {


  final String error;

  ProgressErrorState({
    this.error = "",
  });

}
final class  ProgressSuccessful extends ProgressState {
  final String message;

  ProgressSuccessful({
    this.message = "",
  });
}
