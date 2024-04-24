// ignore_for_file: must_be_immutable, camel_case_types

part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class changepassstate extends LoginState {}
class LoginSuccess extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  String? error;
  LoginFailure({required this.error});
}
