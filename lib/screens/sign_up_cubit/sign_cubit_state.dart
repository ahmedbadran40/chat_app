sealed class SignCubitState {}

final class SignCubitInitial extends SignCubitState {}

final class SignCubitLoading extends SignCubitState {}

final class SignCubitSuccess extends SignCubitState {
  final String userId;
  SignCubitSuccess(this.userId);
}

final class SignCubitFailure extends SignCubitState {
  final String error;
  SignCubitFailure(this.error);
}
