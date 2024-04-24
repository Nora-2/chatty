// ignore: unnecessary_import
// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
   static RegisterCubit get(context) => BlocProvider.of(context);
   bool ispassword = true;
   
    void changepass() {
      ispassword = !ispassword;
      emit(changepassstate());
    }
  Future<void> CreateUser(
      {required String email,
      required String password,
      required String username}) async {
    final usercreate = FirebaseFirestore.instance.collection('users');
    emit(RegisterLoading());

    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      usercreate.doc(user.user!.uid).set({
        'email': user.user!.email,
        'uid': user.user!.uid,
        'username': username,
        'photo':
            'assets/images/menna.jpg'
      });
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(error: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(
            error: 'The account already exists for that email.'));
      } else {
        emit(RegisterFailure(error: 'email or password bad format'));
      }
    } on Exception catch (error) {
      RegisterFailure(error: 'something went wrong' '$error');
    }
  }
}
