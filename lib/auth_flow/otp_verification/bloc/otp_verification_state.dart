part of 'otp_verification_cubit.dart';

@immutable
sealed class OtpVerificationState {}

final class OtpVerificationInitial extends OtpVerificationState {}

final class OtpVerificationLoading extends OtpVerificationState {}

final class OtpVerificationSuccess extends OtpVerificationState {
  final Map<String, dynamic> data;
  OtpVerificationSuccess(this.data);
}

final class OtpVerificationFailure extends OtpVerificationState {
  final String message;
  OtpVerificationFailure(this.message);
}

// This file is no longer used in the sign up flow and can be deleted or ignored.
