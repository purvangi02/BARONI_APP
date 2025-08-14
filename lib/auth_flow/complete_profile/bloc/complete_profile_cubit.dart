import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:io';
import 'package:baroni_app/uttils/api_service.dart';

part 'complete_profile_state.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  CompleteProfileCubit() : super(CompleteProfileInitial());

  Future<void> submitProfile({
    required String name,
    required String pseudo,
    File? profilePic,
    required String preferredLanguage,
    required String country,
    required String email,
    required String contact,
  }) async {
    emit(CompleteProfileLoading());
    try {
      final result = await ApiService.completeProfile(
        name: name,
        pseudo: pseudo,
        profilePic: profilePic,
        preferredLanguage: preferredLanguage,
        country: country,
        email: email,
        contact: contact,
      );
      if (result != null && result['success'] == true) {
        emit(CompleteProfileSuccess(result['data']));
      } else {
        emit(CompleteProfileFailure(result?['message'] ?? 'Profile update failed'));
      }
    } catch (e) {
      emit(CompleteProfileFailure(e.toString()));
    }
  }
}
