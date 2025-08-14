part of 'sign_in_cubit.dart';

@immutable
sealed class SignInState {}

final class SignInInitial extends SignInState {}

final class SignInLoading extends SignInState {}

final class SignInSuccess extends SignInState {
  final Map<String, dynamic> userData;
  SignInSuccess(this.userData);
}

final class SignInFailure extends SignInState {
  final String message;
  SignInFailure(this.message);
}
