
import 'package:bloc/bloc.dart';
import 'package:real_track/feature/auth/data/data_resource/remote/auth_service.dart';
import 'package:real_track/feature/auth/domain/entities/user_info.dart';
import 'package:real_track/feature/auth/presentation/widget/form/bloc/bloc_sign_in/auth%20_state.dart';
import 'package:real_track/feature/auth/presentation/widget/form/bloc/bloc_sign_in/auth_event.dart';


class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService authService = AuthService();
  
  AuthenticationBloc() : super(AuthenticationInitialState()) {
    on<AuthenticationEvent>((event, emit) {});

    on<SignUpUser>((event, emit) async {
      emit(AuthenticationLoadingState(isLoading: true));
      try {
          final UserModel? user = await authService.signUp(event.email, event.password);
      if (user != null) {
        emit(AuthenticationSuccessState(user));
        
      } else {
        emit(const AuthenticationFailureState('create user failed'));
      }
      } catch (e) {
        print(e.toString());
      }
     emit(AuthenticationLoadingState(isLoading: false));
    });

     on<SignOut>((event, emit) async {
      emit(AuthenticationLoadingState(isLoading: true));
      try {
        authService.signOut();
      } catch (e) {
        print('error');
        print(e.toString());
      } 
       emit(AuthenticationLoadingState(isLoading: false));
     });
}
}