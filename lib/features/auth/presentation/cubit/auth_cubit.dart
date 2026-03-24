import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/user_model.dart';
import '../../data/services/google_auth_service.dart';

sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthForgotPasswordSuccess extends AuthState {
  final String message;
  AuthForgotPasswordSuccess(this.message);
}

class AuthAuthenticated extends AuthState {
  final UserModel user;
  AuthAuthenticated(this.user);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthCubit extends Cubit<AuthState> {
  final Dio dio;

  AuthCubit(this.dio) : super(AuthInitial());

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final resp = await dio.post(
        'auth/register',
        data: {
          'name': name,
          'email': email,
          if (phone.trim().isNotEmpty) 'phone': phone.trim(),
          'password': password,
        },
      );
      final data = resp.data['data'];
      emit(AuthAuthenticated(UserModel.fromJson(data['user'])));
    } on DioException catch (e) {
      final code = e.response?.data?['error'];
      final msg = e.response?.data?['message'];
      if (code == 'EMAIL_ALREADY_EXISTS') {
        emit(AuthError('This email is already registered'));
      } else if (code == 'VALIDATION_ERROR') {
        emit(AuthError(msg ?? 'Please check your input'));
      } else {
        emit(AuthError('Registration failed. Please try again'));
      }
    } catch (e) {
      emit(AuthError('Registration failed: $e'));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final resp = await dio.post(
        'auth/login',
        data: {'email': email, 'password': password},
      );
      final data = resp.data['data'];
      emit(AuthAuthenticated(UserModel.fromJson(data['user'])));
    } on DioException catch (e) {
      final code = e.response?.data?['error'];
      if (code == 'INVALID_CREDENTIALS') {
        emit(AuthError('Invalid email or password'));
      } else if (code == 'RATE_LIMIT_EXCEEDED') {
        emit(AuthError('Too many attempts. Please wait a moment'));
      } else {
        emit(AuthError('Login failed. Please try again'));
      }
    } catch (e) {
      emit(AuthError('Login failed: $e'));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await GoogleAuthService().signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError('Logout failed'));
    }
  }

  Future<void> googleLogin() async {
    emit(AuthLoading());
    try {
      final idToken = await GoogleAuthService().getIdToken();
      if (idToken == null) {
        emit(AuthError('Google sign-in cancelled'));
        return;
      }
      final resp = await dio.post('auth/google', data: {'id_token': idToken});
      final data = resp.data;
      emit(AuthAuthenticated(UserModel.fromJson(data['data']['user'])));
    } on DioException catch (e) {
      emit(AuthError('Google error ${e.response?.statusCode}: ${e.response?.data}'));
    } catch (e) {
      emit(AuthError('Google error: $e'));
    }
  }

  Future<void> forgotPassword(String email) async {
    emit(AuthLoading());
    try {
      await dio.post('auth/forgot-password', data: {'email': email});
      emit(AuthForgotPasswordSuccess('Password reset link sent to your email'));
    } on DioException catch (e) {
      final message = e.response?.data['message'];
      if (message is String && message.isNotEmpty) {
        emit(AuthError(message));
      } else {
        emit(AuthError('Failed to send reset link'));
      }
    } catch (e) {
      emit(AuthError('Failed to send reset link'));
    }
  }
}
