import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:baroni_app/uttils/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  Future<void> login(String contact, String password,bool isMobile) async {
    emit(SignInLoading());
    try {
      final response = await ApiService.login(contact, password,isMobile);
      if (response != null && response['success'] == true) {
        final tokens = response['tokens'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', tokens['accessToken']);
        await prefs.setString('refreshToken', tokens['refreshToken']);
        emit(SignInSuccess(response['data']));
      } else {
        emit(SignInFailure(response?['message']));
      }
    } catch (e) {
      emit(SignInFailure('Error: $e'));
    }
  }
}
