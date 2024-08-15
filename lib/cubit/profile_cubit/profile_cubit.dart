import 'package:auth_mobile_app/models/user.dart';
import 'package:auth_mobile_app/services/api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.apiService) : super(ProfileInitial());

  final APIService apiService;

  Future<void> getUserProfile(String token) async {
    emit(LoadingProfileState());

    try {
      final user = await apiService.getProfile(token);
      emit(SuccessProfileState(userData: user));
    } catch (e) {
      emit(ErrorProfileState(e.toString()));
    }
  }


}
