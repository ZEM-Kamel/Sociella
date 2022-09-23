import 'package:sociella/shared/Cubit/restPasswordCubit/rest_password_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordStates> {
  ResetPasswordCubit() : super(ResetPasswordInitialState());

  static ResetPasswordCubit get(context) => BlocProvider.of(context);


  void resetPassword({
    required String email,
  })
  {
    emit(ResetPasswordLoadingState());
    FirebaseAuth.instance.sendPasswordResetEmail(
      email: email,
    ).then((value) {
      emit(ResetPasswordSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ResetPasswordErrorState());
    });
  }

}