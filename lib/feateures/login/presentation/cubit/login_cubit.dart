// ignore_for_file: unused_catch_clause, depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
    static LoginCubit get(context) => BlocProvider.of(context);
   bool ispassword = true;
   
    void changepass() {
      ispassword = !ispassword;
      emit(changepassstate());
    }
  String? uid;
  // ignore: non_constant_identifier_names
  Future<void> sign_in(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      uid = user.user!.uid;
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
      emit(LoginFailure(error:'No user found for that email.' ));  
      } else if (e.code == 'wrong-password') {
         emit(LoginFailure(error:'Wrong password for that user.' ));  
      }
    } on Exception catch (e) {
      emit(LoginFailure(error: 'something went wrong'));
    }
  }
}
