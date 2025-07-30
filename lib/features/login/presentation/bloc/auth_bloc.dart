import 'package:bloc_pet/core/services/auth_service.dart';
import 'package:bloc_pet/features/login/data/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final AuthService _authService = AuthService();

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    
    // Check initial auth state
    _checkAuthStatus();
  }
  
  Future<void> _checkAuthStatus() async {
    final isAuthenticated = await _authService.isAuthenticated();
    if (isAuthenticated) {
      emit(AuthAuthenticated(await _authService.getToken() ?? ''));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final token = await _authRepository.authUser(event.username, event.password);
      await _authService.saveToken(token);
      emit(AuthAuthenticated(token));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await _authService.clearToken();
    emit(AuthUnauthenticated());
  }
}
