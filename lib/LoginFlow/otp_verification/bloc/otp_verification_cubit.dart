import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:baroni_app/uttils/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'otp_verification_state.dart';

class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  OtpVerificationCubit() : super(OtpVerificationInitial());

  Future<void> verifyOtp({
    required String userId,
    required String otp,
    required String accessToken,
  }) async {
    emit(OtpVerificationLoading());
    try {
      final result = await ApiService.verifyOtp(
        userId: userId,
        otp: otp,
        accessToken: accessToken,
      );
      if (result != null && result['success'] == true) {
        final tokens = result['tokens'];
        if (tokens != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('accessToken', tokens['accessToken'] ?? '');
          await prefs.setString('refreshToken', tokens['refreshToken'] ?? '');
        }
        emit(OtpVerificationSuccess(result));
      } else {
        emit(OtpVerificationFailure(result?['message'] ?? 'OTP verification failed'));
      }
    } catch (e) {
      emit(OtpVerificationFailure(e.toString()));
    }
  }
}
