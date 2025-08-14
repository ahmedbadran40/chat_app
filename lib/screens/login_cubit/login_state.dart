abstract class LoginState {}

/// الحالة الابتدائية
class LoginInitial extends LoginState {}

/// حالة أثناء تحميل البيانات (Loading)
class LoginLoading extends LoginState {}

/// حالة نجاح تسجيل الدخول
class LoginSuccess extends LoginState {
  final String userId;
  LoginSuccess(this.userId);
}

/// حالة فشل تسجيل الدخول
class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}
