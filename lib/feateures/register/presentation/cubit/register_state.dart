// ignore_for_file: camel_case_types

part of 'register_cubit.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterSuccess extends RegisterState {}
class changepassstate extends RegisterState {}
class RegisterLoading extends RegisterState {}

class RegisterFailure extends RegisterState {
  String? error;
  RegisterFailure({required this.error});
}