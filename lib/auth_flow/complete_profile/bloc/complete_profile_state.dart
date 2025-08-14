part of 'complete_profile_cubit.dart';

@immutable
sealed class CompleteProfileState {}

final class CompleteProfileInitial extends CompleteProfileState {}

final class CompleteProfileLoading extends CompleteProfileState {}

final class CompleteProfileSuccess extends CompleteProfileState {
  final Map<String, dynamic> data;
  CompleteProfileSuccess(this.data);
}

final class CompleteProfileFailure extends CompleteProfileState {
  final String message;
  CompleteProfileFailure(this.message);
}
