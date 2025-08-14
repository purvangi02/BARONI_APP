import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:baroni_app/uttils/api_service.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> register({
    required String contact,
    required String password,
    String? email,
  }) async {
    emit(SignUpLoading());
    try {
      final response = await ApiService.register(
        contact: contact,
        password: password,
        email: email,
      );
      if (response != null && response['success'] == true) {
        emit(SignUpSuccess(response['data']));
      } else {
        emit(SignUpFailure(response?['message'] ?? 'Registration failed'));
      }
    } catch (e) {
      emit(SignUpFailure('Error: $e'));
    }
  }
}
